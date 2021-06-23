from i3pystatus import Status

# Hardcoded gruvbox palette
color0 = "#282828"
color1 = "#cc241d"
color2 = "#98971a"
color3 = "#d79921"
color4 = "#458588"
color5 = "#b16286"
color6 = "#689d6a"
color7 = "#a89984"
color8 = "#928374"
color9 = "#fb4934"
color10 = "#b8bb26"
color11 = "#fabd2f"
color12 = "#83a598"
color13 = "#d3869b"
color14 = "#8ec07c"
color15 = "#ebdbb2"


status = Status()


status.register("clock", format=" %a %-d %b %H:%M ")
status.register(
    "pulseaudio",
    format=" 🔊 {volume} ",
    color_muted=color9,
    color_unmuted=color15,
    multi_colors=True,
)
status.register(
    "backlight",
    format=" 🔆 {percentage}% ",
    backlight="intel_backlight",
)
status.register(
    "cpu_usage_graph", dynamic_color=True, start_color=color14, end_color=color9
)
status.register(
    "temp",
    format=" CPU: {Package_id_0:.0f}°C ",
    dynamic_color=True,
    lm_sensors_enabled=True,
    color=color14,
    alert_color=color9,
)

status.register(
    "mem",
    format=" Memory: {used_mem:4.0f}MB/{total_mem:4.0f}MB ",
    color=color15,
    warn_color=color11,
    alert_color=color9,
)
status.register(
    "battery",
    format=" BAT: {status}{percentage:.2f}% ({consumption}W) {remaining:%E%hh:%Mm} ",
    charging_color=color10,
    full_color=color14,
    alert=True,
    alert_percentage=10,
    status={
        "DIS": "↓",
        "CHR": "↑",
        "FULL": "",
    },
)
status.register(
    "network",
    interface="enp3s0",
    format_up=" {v4cidr} ",
    color_up=color14,
    color_down=color9,
)
status.register(
    "network",
    interface="wlp2s0",
    format_up=" {essid}{quality:3.0f}% ({v4cidr}) ",
    color_up=color14,
    color_down=color9,
)


status.run()
