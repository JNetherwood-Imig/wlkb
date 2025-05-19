const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const yaml = b.dependency("yaml", .{
        .target = target,
        .optimize = optimize,
    });

    const codes_exe = b.addExecutable(.{
        .name = "generate_codes",
        .root_source_file = b.path("codes/generate_codes.zig"),
        .target = target,
        .optimize = optimize,
    });

    codes_exe.root_module.addImport("yaml", yaml.module("yaml"));

    const generate_codes = b.addRunArtifact(codes_exe);
    const codes = generate_codes.addOutputFileArg("codes.zig");

    const mod = b.addModule("wlkb", .{
        .root_source_file = b.path("src/wlkb.zig"),
        .target = target,
        .optimize = optimize,
    });

    mod.addAnonymousImport("codes", .{
        .root_source_file = codes,
        .target = target,
        .optimize = optimize,
    });

    const test_mod = b.addTest(.{ .root_module = mod });

    const run_test = b.addRunArtifact(test_mod);
    const test_step = b.step("test", "Run tests");
    test_step.dependOn(&run_test.step);
}
