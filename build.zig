const std = @import("std");

pub fn build(b: *std.Build) void {
    _ = b.addModule("wlkb", .{
        .root_source_file = b.path("src/wlkb.zig"),
        .target = b.standardTargetOptions(.{}),
        .optimize = b.standardOptimizeOption(.{}),
    });
}
