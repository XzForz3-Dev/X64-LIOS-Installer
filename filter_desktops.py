import re

with open('data/netinstall.yaml', 'r') as f:
    lines = f.readlines()

desktops_to_remove = [
    "Cosmic", "Niri", "Cinnamon", "Budgie-Desktop", "MATE-Desktop",
    "Xfce4", "LXQT-Desktop", "LXDE-Desktop", "Hyprland", "MangoWM",
    "Sway", "Wayfire", "i3-Window-Manager", "Qtile", "bspwm", "Openbox"
]

out_lines = []
skip_mode = False

for line in lines:
    match = re.match(r'^- name: "(.*?)"', line)
    if match:
        name = match.group(1)
        if name in desktops_to_remove:
            skip_mode = True
        else:
            skip_mode = False
    
    if not skip_mode:
        out_lines.append(line)

with open('data/netinstall.yaml', 'w') as f:
    f.writelines(out_lines)

