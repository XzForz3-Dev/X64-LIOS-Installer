#!/bin/bash
# X64 LIOS - Motor de Mutación de Hardware (Modo Turbo)
# Este script se ejecuta en el entorno Live antes de pacstrap.

PACMAN_CONF="/etc/pacman.conf"

# Detección de arquitectura del procesador
SUPPORTED_V3=$(/lib/ld-linux-x86-64.so.2 --help | grep 'x86-64-v3 (' | awk '{print $1}')
SUPPORTED_V4=$(/lib/ld-linux-x86-64.so.2 --help | grep 'x86-64-v4 (' | awk '{print $1}')

# Función para inyectar CachyOS
inyectar_cachyos() {
    local ARCH_LEVEL=$1
    echo "Inyectando repositorios de CachyOS ($ARCH_LEVEL)..."
    
    # 1. Configurar mirrorlist genérico de CachyOS temporalmente
    echo "Server = https://mirror.cachyos.org/repo/\$arch/\$repo" > /etc/pacman.d/cachyos-mirrorlist
    echo "Server = https://mirror.cachyos.org/repo/\$arch/\$repo" > /etc/pacman.d/cachyos-v3-mirrorlist
    echo "Server = https://mirror.cachyos.org/repo/\$arch/\$repo" > /etc/pacman.d/cachyos-v4-mirrorlist

    # 2. Bajar las llaves criptográficas de CachyOS
    pacman-key --recv-keys F3B607488DB35A47 --keyserver keyserver.ubuntu.com
    pacman-key --lsign-key F3B607488DB35A47
    
    # 3. Preparar el bloque a inyectar al principio de los repositorios
    # En pacman, el orden importa (el de más arriba tiene prioridad)
    sed -i '/\[core\]/i \
# --- X64 LIOS TURBO MODE --- \
[cachyos] \
Include = /etc/pacman.d/cachyos-mirrorlist \
' $PACMAN_CONF

    if [ "$ARCH_LEVEL" == "v3" ] || [ "$ARCH_LEVEL" == "v4" ]; then
        sed -i '/\[cachyos\]/i \
[cachyos-v3] \
Include = /etc/pacman.d/cachyos-v3-mirrorlist \
[cachyos-core-v3] \
Include = /etc/pacman.d/cachyos-v3-mirrorlist \
[cachyos-extra-v3] \
Include = /etc/pacman.d/cachyos-v3-mirrorlist \
' $PACMAN_CONF
    fi

    if [ "$ARCH_LEVEL" == "v4" ]; then
        sed -i '/\[cachyos-v3\]/i \
[cachyos-v4] \
Include = /etc/pacman.d/cachyos-v4-mirrorlist \
' $PACMAN_CONF
    fi
    
    # Sincronizar e instalar los paquetes oficiales de llaves y mirrors
    pacman -Sy --noconfirm cachyos-keyring cachyos-mirrorlist cachyos-v3-mirrorlist
}

if [ "$SUPPORTED_V4" == "x86-64-v4" ]; then
    echo "Hardware de Élite detectado (AVX-512). Activando Modo Turbo V4..."
    inyectar_cachyos "v4"
elif [ "$SUPPORTED_V3" == "x86-64-v3" ]; then
    echo "Hardware Moderno detectado (AVX2). Activando Modo Turbo V3..."
    inyectar_cachyos "v3"
else
    echo "Hardware Antiguo detectado. Manteniendo sistema en Modo Roca (Repositorios estándar de Arch)."
fi

exit 0
