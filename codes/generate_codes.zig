const std = @import("std");
const Yaml = @import("yaml").Yaml;

const Codes = struct {
    codes: []const struct {
        key: []const u8,
        base: []const u8,
        shift: []const u8,
    },
};

const source = @embedFile("codes.yml");

pub fn main() !void {
    var gpa_state = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa_state.deinit();
    const gpa = gpa_state.allocator();

    const args = try std.process.argsAlloc(gpa);
    defer std.process.argsFree(gpa, args);

    std.debug.assert(args.len == 2);

    const out_path = args[1];
    const out_file = try std.fs.cwd().createFile(out_path, .{});
    defer out_file.close();

    var yaml = Yaml{ .source = source };
    defer yaml.deinit(gpa);
    const codes = try yaml.parse(gpa, Codes);
    std.debug.print("{any}", .{codes});
}
