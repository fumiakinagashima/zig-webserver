const std = @import("std");
const SocketConf = @import("web/socket.zig");
const Request = @import("web/request.zig");
const Response = @import("web/response.zig");
const Method = Request.Method;

pub fn main() !void {
    const socket = try SocketConf.Socket.init();
    std.debug.print("server is running at {any}.\n", .{socket._address});
    var server = try socket._address.listen(.{});

    while (true) {
        const connection = try server.accept();
        var buffer: [1024]u8 = undefined;
        for (0..buffer.len) |i| {
            buffer[i] = 0;
        }
        try Request.read_request(connection, buffer[0..buffer.len]);
        const request = Request.parse_request(buffer[0..buffer.len]);
        std.debug.print("request by {s}.\n", .{request.uri});
        if (request.method == Method.GET) {
            if (std.mem.eql(u8, request.uri, "/")) {
                try Response.send_200(connection);
            } else {
                try Response.send_404(connection);
            }
        }
    }
}
