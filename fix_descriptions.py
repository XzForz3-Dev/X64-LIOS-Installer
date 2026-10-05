import re

with open('data/netinstall.yaml', 'r') as f:
    content = f.read()

content = content.replace('description: "CachyOS font selection"', 'description: "X64 font selection"')
content = content.replace('description: "CachyOS kernels to install"', 'description: "X64 kernels to install"')
content = content.replace('description: "CachyOS kernels to install (Handheld)"', 'description: "X64 kernels to install (Handheld)"')

with open('data/netinstall.yaml', 'w') as f:
    f.write(content)

