const std = @import("std");
const Connection = std.net.Server.Connection;

pub fn send_200(conn: Connection) !void {
    const message = ("HTTP/1.1 200 OK\n" ++
        "Content-Length: 48\n" ++
        "Content-Type: text/html\n" ++
        "Connection: Closed\n" ++
        "\n" ++
        "<html><body><h1>Hello, ultra!</h1></body></html>");
    _ = try conn.stream.write(message);
}

pub fn send_404(conn: Connection) !void {
    const message = ("HTTP/1.1 404  OK\n" ++
        "Content-Length: 50\n" ++
        "Content-Type: text/html\n" ++
        "Connection: Closed\n" ++
        "\n" ++
        "<html><body><h1>File not found!</h1></body></html>");
    _ = try conn.stream.write(message);
}
