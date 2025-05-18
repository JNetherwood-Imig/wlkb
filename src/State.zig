mods: ModMask = .{},
leds: LedMask = .{},

const ModMask = packed struct {};

const LedMask = packed struct {
    num_lock: bool = false,
    caps_lock: bool = false,
    scroll_lock: bool = false,
    compose: bool = false,
    kana: bool = false,
    sleep: bool = false,
    @"suspend": bool = false,
    mute: bool = false,
    misc: bool = false,
    mail: bool = false,
    charging: bool = false,
};

const std = @import("std");
