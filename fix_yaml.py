import re

with open('data/netinstall.yaml', 'r') as f:
    content = f.read()

# 1. Rename hidden groups
content = content.replace('name: "CachyOS required (hidden)"', 'name: "X64 required (hidden)"')
content = content.replace('name: "CachyOS kernels (hidden)"', 'name: "X64 kernels (hidden)"')
content = content.replace('name: "CachyOS kernels (hidden/handheld)"', 'name: "X64 kernels (hidden/handheld)"')

# 2. Rename Handhelds
content = content.replace('''- name: "CachyOS Handhelds"
  description: "Basic packages for handhelds"''', '''- name: "Soporte Handheld (Steam Deck, ROG Ally)"
  description: "Basic packages for handhelds"''')

# 3. Rename Shell
content = content.replace('''- name: "CachyOS shell configuration"
  description: "Shell packages for CachyOS"
  hidden: false
  selected: true
  packages:
     - cachyos-fish-config
     - cachyos-zsh-config''', '''- name: "X64 Shell Configuration"
  description: "Shell packages for X64"
  hidden: false
  selected: true
  packages:
     - fish
     - zsh
     - grml-zsh-config''')

# 4. Remove "X64 Core Packages" block entirely
pattern_core = r'- name: "X64 Core Packages".*?(?=\n- name: |\Z)'
content = re.sub(pattern_core, '', content, flags=re.DOTALL)

# 5. Remove UNSUPPORTED desktops entirely
unsupported = [
    "Budgie-Desktop", "MATE-Desktop", "LXQT-Desktop", "LXDE-Desktop",
    "MangoWM", "Sway", "Wayfire", "i3-Window-Manager", "Qtile", "bspwm", "Openbox"
]
for desk in unsupported:
    pattern = r'- name: "' + desk + r'".*?(?=\n- name: |\Z)'
    content = re.sub(pattern, '', content, flags=re.DOTALL)

# 6. Remove specific CachyOS packages from supported desktops
pkgs_to_remove = [
    r'\n\s+- cachy-update',
    r'\n\s+- cachyos-emerald-kde-theme-git',
    r'\n\s+- cachyos-iridescent-kde',
    r'\n\s+- cachyos-kde-settings',
    r'\n\s+- cachyos-nord-kde-theme-git',
    r'\n\s+- cachyos-gnome-settings',
    r'\n\s+- cachyos-niri-noctalia',
    r'\n\s+- cachyos-hypr-noctalia',
    r'\n\s+- cachyos-handheld'
]
for pkg in pkgs_to_remove:
    content = re.sub(pkg, '', content)

# 7. Clean up multiple empty lines
content = re.sub(r'\n\s*\n', '\n', content)

with open('data/netinstall.yaml', 'w') as f:
    f.write(content)

