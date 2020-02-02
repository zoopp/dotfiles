from i3pystatus import Status


status = Status()


status.register('clock', format=' %a %-d %b %H:%M ')
status.register('pulseaudio', format=' 🔊 {volume} ')
status.register('backlight', format=' 🔆 {percentage}% ', backlight='intel_backlight')
status.register('cpu_usage_graph')
status.register('temp', format=' CPU: {temp:.0f}°C ')
status.register('mem', color='#FFFFFF', format=' Memory: {used_mem:4.0f}MB/{total_mem:4.0f}MB ')
status.register('battery',
        format=' BAT: {status}{percentage:.2f}% ({consumption}W) {remaining:%E%hh:%Mm} ',
        alert=True,
        alert_percentage=10,
        status={
            'DIS': '↓',
            'CHR': '↑',
            'FULL': '',
        })
status.register('network', interface='enp3s0', format_up=' {v4cidr} ')
status.register('network', interface='wlp2s0', format_up=' {essid}{quality:3.0f}% ({v4cidr}) ')


status.run()
