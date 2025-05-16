pub const State = struct {
    mods: struct {
        latched: packed struct {
            shift: bool = false,
            control: bool = false,
            alt: bool = false,
        },
        locked: packed struct {
            caps: bool = false,
        },
    },
};
