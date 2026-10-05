import re

with open('data/netinstall.yaml', 'r') as f:
    content = f.read()

# 1. Rename hidden groups
content = content.replace('name: "CachyOS required (hidden)"', 'name: "X64 required (hidden)"')
content = content.replace('name: "CachyOS kernels (hidden)"', 'name: "X64 kernels (hidden)"')
content = content.replace('name: "CachyOS kernels (hidden/handheld)"', 'name: "X64 kernels (hidden/handheld)"')

# 2. Delete the entire "X64 Core Packages" block
# We will use regex to find the block and remove it.
# The block starts with '- name: "X64 Core Packages"' and ends before the next '- name:'
pattern_core = r'- name: "X64 Core Packages".*?(?=\n- name: |\Z)'
content = re.sub(pattern_core, '', content, flags=re.DOTALL)

# 3. Remove specific cachyos packages from KDE
packages_to_remove = [
    r'\n\s+- cachy-update',
    r'\n\s+- cachyos-emerald-kde-theme-git',
    r'\n\s+- cachyos-iridescent-kde',
    r'\n\s+- cachyos-kde-settings',
    r'\n\s+- cachyos-nord-kde-theme-git',
    r'\n\s+- cachyos-gnome-settings',
    r'\n\s+- cachyos-handheld'
]

for pkg in packages_to_remove:
    content = re.sub(pkg, '', content)

# ensure we don't have multiple blank lines
content = re.sub(r'\n\s*\n', '\n', content)

with open('data/netinstall.yaml', 'w') as f:
    f.write(content)

