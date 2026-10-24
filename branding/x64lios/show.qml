import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import calamares.slideshow 1.0

Presentation
{
    id: presentation

    function nextSlide() {
        presentation.goToNextSlide();
    }

    Timer {
        id: advanceTimer
        interval: 10000
        running: presentation.activatedInCalamares
        repeat: true
        onTriggered: nextSlide()
    }

    // Fondo maestro oscuro para cubrir el 100% del viewport de QQuickWidget
    Rectangle {
        id: presentationBg
        anchors.fill: parent
        color: "#0b0b0d"
        z: -99
    }

    // Componente reutilizable para el contenido de cada Slide
    component X64SlideContent: Rectangle {
        id: card
        anchors.fill: parent
        anchors.margins: 16
        color: "#101014"
        radius: 8
        border.color: "#222228"
        border.width: 1

        property string tagText: ""
        property string slideNumber: "01 / 05"
        property string titleText: ""
        property string descText: ""
        property string feat1Title: ""
        property string feat1Desc: ""
        property string feat2Title: ""
        property string feat2Desc: ""
        property string feat3Title: ""
        property string feat3Desc: ""

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 24
            anchors.bottomMargin: 32
            spacing: 10

            // Cabecera: Tag y Número de Diapositiva
            RowLayout {
                Layout.fillWidth: true

                Rectangle {
                    color: "#200e12"
                    border.color: "#b31b1b"
                    border.width: 1
                    radius: 4
                    height: 22
                    width: tagLabel.implicitWidth + 16

                    Text {
                        id: tagLabel
                        anchors.centerIn: parent
                        text: card.tagText
                        color: "#ff3333"
                        font.pixelSize: 10
                        font.bold: true
                        font.letterSpacing: 1.5
                    }
                }

                Item { Layout.fillWidth: true }

                Text {
                    text: card.slideNumber
                    color: "#60606c"
                    font.pixelSize: 11
                    font.bold: true
                }
            }

            // Título Principal
            Text {
                text: card.titleText
                color: "#ffffff"
                font.pixelSize: 20
                font.bold: true
                wrapMode: Text.WordWrap
                Layout.preferredWidth: 680
            }

            // Línea Divisoria Carmesí
            Rectangle {
                Layout.preferredWidth: 680
                height: 2
                color: "#801212"
            }

            // Descripción Principal
            Text {
                text: card.descText
                color: "#a8a8b6"
                font.pixelSize: 13
                wrapMode: Text.WordWrap
                Layout.preferredWidth: 680
                lineHeight: 1.2
            }

            Item { height: 4 }

            // Lista de Puntos Clave
            ColumnLayout {
                Layout.preferredWidth: 680
                spacing: 8

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 12

                    Rectangle {
                        width: 8
                        height: 8
                        radius: 4
                        color: "#ff2a2a"
                        Layout.alignment: Qt.AlignTop
                        Layout.topMargin: 4
                    }

                    Text {
                        text: "<font color='#ffffff'><b>" + card.feat1Title + ":</b></font> " + card.feat1Desc
                        color: "#c8c8d2"
                        font.pixelSize: 12
                        wrapMode: Text.WordWrap
                        Layout.preferredWidth: 650
                    }
                }

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 12

                    Rectangle {
                        width: 8
                        height: 8
                        radius: 4
                        color: "#ff2a2a"
                        Layout.alignment: Qt.AlignTop
                        Layout.topMargin: 4
                    }

                    Text {
                        text: "<font color='#ffffff'><b>" + card.feat2Title + ":</b></font> " + card.feat2Desc
                        color: "#c8c8d2"
                        font.pixelSize: 12
                        wrapMode: Text.WordWrap
                        Layout.preferredWidth: 650
                    }
                }

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 12

                    Rectangle {
                        width: 8
                        height: 8
                        radius: 4
                        color: "#ff2a2a"
                        Layout.alignment: Qt.AlignTop
                        Layout.topMargin: 4
                    }

                    Text {
                        text: "<font color='#ffffff'><b>" + card.feat3Title + ":</b></font> " + card.feat3Desc
                        color: "#c8c8d2"
                        font.pixelSize: 12
                        wrapMode: Text.WordWrap
                        Layout.preferredWidth: 650
                    }
                }
            }

            Item { Layout.fillHeight: true }
        }

        // Cubo Tecnológico Isométrico X64 LIOS en la esquina inferior derecha
        Image {
            id: cubeGraphic
            source: "cube.png"
            width: 175
            height: 175
            fillMode: Image.PreserveAspectFit
            anchors.right: parent.right
            anchors.rightMargin: 36
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 32
            smooth: true
            mipmap: true
        }

        // Indicador de Progreso de Diapositivas (Pills animadas)
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 12
            spacing: 8

            Repeater {
                model: 5
                Rectangle {
                    width: index === presentation.currentSlide ? 24 : 8
                    height: 5
                    radius: 3
                    color: index === presentation.currentSlide ? "#b31b1b" : "#282830"

                    Behavior on width {
                        NumberAnimation { duration: 250; easing.type: Easing.InOutQuad }
                    }
                    Behavior on color {
                        ColorAnimation { duration: 250 }
                    }
                }
            }
        }
    }

    // SLIDE 1
    Slide {
        x: 0; y: 0
        width: parent.width; height: parent.height

        X64SlideContent {
            tagText: "X64 LIOS • ARQUITECTURA DE ALTO RENDIMIENTO"
            slideNumber: "01 / 05"
            titleText: "Máximo Rendimiento Bare-Metal y Latencia Ultra-Baja"
            descText: "Diseñado desde cero para exprimir el 100% de tu máquina. Base pura de Arch Linux sin bloatware ni telemetría oculta, con un consumo mínimo de apenas 600–800 MB de RAM en reposo."
            feat1Title: "Rendimiento Top Gaming"
            feat1Desc: "Kernel CachyOS optimizado con schedulers dinámicos scx y afinidad de procesos."
            feat2Title: "Rolling Release de Vanguardia"
            feat2Desc: "Lo último en optimizaciones de hardware, drivers y librerías siempre al día."
            feat3Title: "Sistema Quirúrgico"
            feat3Desc: "Cero servicios innecesarios en segundo plano para dedicar tu hardware 100% a jugar y crear."
        }
    }

    // SLIDE 2
    Slide {
        x: 0; y: 0
        width: parent.width; height: parent.height

        X64SlideContent {
            tagText: "MUTACIÓN DE HARDWARE & COMPATIBILIDAD"
            slideNumber: "02 / 05"
            titleText: "Detección Inteligente de CPU y Paquetes a Medida"
            descText: "Durante esta instalación, el sistema audita tu procesador: si es moderno activa paquetes de alto rendimiento (v3/v4); si es clásico, utiliza los paquetes oficiales estándar de Arch Linux para compatibilidad total sin fallos."
            feat1Title: "Optimización por Microarquitectura"
            feat1Desc: "Inyección de repositorios x86-64-v3 (AVX2) o v4 (AVX-512) para máxima velocidad en CPUs modernas."
            feat2Title: "Compatibilidad Oficial de Arch"
            feat2Desc: "En procesadores clásicos, el sistema recurre a los repositorios oficiales de Arch Linux garantizando estabilidad absoluta."
            feat3Title: "Detección Gráfica chwd"
            feat3Desc: "Reconocimiento e instalación automatizada de drivers para GPUs NVIDIA GeForce, AMD Radeon e Intel Iris."
        }
    }

    // SLIDE 3
    Slide {
        x: 0; y: 0
        width: parent.width; height: parent.height

        X64SlideContent {
            tagText: "OPTIMIZACIÓN EN TIEMPO REAL"
            slideNumber: "03 / 05"
            titleText: "FalconD: Gestión Inteligente de Recursos en Vivo"
            descText: "Integramos el demonio open-source FalconD con perfiles específicos optimizados para X64 LIOS, gestionando dinámicamente CPU, GPU, red y disco en segundo plano."
            feat1Title: "Prioridad Gaming Extrema"
            feat1Desc: "Ajusta la afinidad de núcleos y eleva la prioridad del juego activo para erradicar micro-tirones."
            feat2Title: "Ajuste Térmico y Frecuencias"
            feat2Desc: "Gestión dinámica de perfiles de energía, curvas de TDP y baja latencia de red con TCP BBR."
            feat3Title: "Soporte Adaptativo para Dispositivos"
            feat3Desc: "Perfiles automáticos para PC de sobremesa, laptops (ahorro de batería) y consolas Handheld (Steam Deck, ROG Ally, Legion Go)."
        }
    }

    // SLIDE 4
    Slide {
        x: 0; y: 0
        width: parent.width; height: parent.height

        X64SlideContent {
            tagText: "ENTORNOS GAMER & WAYLAND"
            slideNumber: "04 / 05"
            titleText: "Gaming Fluido en Ventana y Libertad Visual"
            descText: "Erradicación del stuttering y micro-tirones en Wayland. Disfruta de sincronización explícita perfecta tanto a pantalla completa como en ventanas de mosaico (tiling)."
            feat1Title: "Direct Scanout & VRR en Ventana"
            feat1Desc: "Desvío del compositor con soporte para G-Sync y FreeSync, jugando en ventana con la fluidez de pantalla completa."
            feat2Title: "8 Entornos Oficiales a Elegir"
            feat2Desc: "Máximo rendimiento probado en KDE Plasma 6, GNOME, COSMIC, Niri, Hyprland, Cinnamon, Xfce y Server."
            feat3Title: "ZRAM Latencia Cero"
            feat3Desc: "Paginado en RAM comprimida ultra-rápida, evitando bloqueos por swap lento en disco."
        }
    }

    // SLIDE 5
    Slide {
        x: 0; y: 0
        width: parent.width; height: parent.height

        X64SlideContent {
            tagText: "CENTRO DE CONTROL POST-INSTALACIÓN"
            slideNumber: "05 / 05"
            titleText: "X64-Hello: Tu Suite Integral de Gestión y Gaming"
            descText: "La instalación está por concluir. Al primer reinicio, X64-Hello te dará la bienvenida como tu centro de control integral para configurar gaming, rendimiento, kernels y mantenimiento con un solo clic."
            feat1Title: "Gaming Center Modular en 1 Clic"
            feat1Desc: "Despliega bajo demanda Steam, Heroic, Lutris, Proton-GE, Wine, GameMode, MangoHud y emuladores (RetroArch, RPCS3, PCSX2, Dolphin)."
            feat2Title: "Ajustes de CPU, Red y Mantenimiento"
            feat2Desc: "Control de gobernadores de CPU, EPP, schedulers scx, optimización de servidores espejo (mirrors) y limpieza del sistema."
            feat3Title: "Gestión de Kernels y Escudo Btrfs"
            feat3Desc: "Alterna entre kernels de alto rendimiento y crea instantáneas automáticas con Snapper para restaurar el sistema desde el bootloader si algo falla."
        }
    }

    function onActivate() {
        presentation.currentSlide = 0;
    }

    function onLeave() {
    }
}
