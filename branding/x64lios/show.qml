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
            tagText: "X64 LIOS • ARQUITECTURA HÍBRIDA"
            slideNumber: "01 / 05"
            titleText: "Máximo Rendimiento Bare-Metal y Gaming Competitivo"
            descText: "Diseñado desde cero para exprimir el 100% de tu hardware. Un sistema operativo puro, sin capas innecesarias, telemetría oculta ni servicios que roben FPS en segundo plano."
            feat1Title: "Rolling Release Híbrido"
            feat1Desc: "La vanguardia de Arch con la estabilidad de Debian: kernel y drivers siempre al día para jugar, con la libertad de congelar paquetes críticos para que nada se rompa."
            feat2Title: "Base Arch Linux Pura"
            feat2Desc: "Control total de tu máquina y despliegue fresco de paquetes directamente desde la red."
            feat3Title: "Zero Bloatware"
            feat3Desc: "Solo los componentes esenciales para jugar y crear, garantizando latencias mínimas y arranque récord."
        }
    }

    // SLIDE 2
    Slide {
        x: 0; y: 0
        width: parent.width; height: parent.height

        X64SlideContent {
            tagText: "NÚCLEO & REPOSITORIOS X64"
            slideNumber: "02 / 05"
            titleText: "Detección Inteligente de CPU y Repositorio Oficial X64"
            descText: "El instalador analiza tu procesador en tiempo real. Si detecta una CPU moderna activa repositorios de microarquitectura avanzada; si detecta hardware clásico, aplica el fallback seguro para máxima compatibilidad."
            feat1Title: "Microarquitectura a Medida"
            feat1Desc: "Detección de x86-64-v3 (AVX2) y v4 (AVX-512), con fallback automático a x86-64-v1 y v2 para procesadores legacy."
            feat2Title: "Repositorio Oficial X64"
            feat2Desc: "Servidores dedicados con paquetes propios, herramientas exclusivas y parches compilados por nuestro equipo."
            feat3Title: "Kernel CachyOS & BORE"
            feat3Desc: "Planificador interactivo de tareas y ZRAM (ZSTD) que garantizan frametimes planos en cualquier juego."
        }
    }

    // SLIDE 3
    Slide {
        x: 0; y: 0
        width: parent.width; height: parent.height

        X64SlideContent {
            tagText: "OPTIMIZACIÓN EN TIEMPO REAL"
            slideNumber: "03 / 05"
            titleText: "FalconD: Inteligencia y Rendimiento en Segundo Plano"
            descText: "Un demonio de control desarrollado para X64 LIOS que optimiza en vivo el procesador, la GPU, la red y el disco, adaptándose automáticamente si estás en una torre de sobremesa, laptop o consola portátil."
            feat1Title: "Priorización Extrema de Juegos"
            feat1Desc: "Eleva la prioridad del juego en ejecución y silencia tareas en segundo plano para evitar tirones."
            feat2Title: "Ajuste Térmico & Frecuencias"
            feat2Desc: "Gestión dinámica de perfiles de energía, curvas de TDP y optimización de latencia de red (TCP BBR)."
            feat3Title: "Detección Automática de Handhelds"
            feat3Desc: "Soporte directo de controles, gatillos y consumo para Steam Deck, ROG Ally, Legion Go y más."
        }
    }

    // SLIDE 4
    Slide {
        x: 0; y: 0
        width: parent.width; height: parent.height

        X64SlideContent {
            tagText: "ENTORNOS GAMER & WAYLAND"
            slideNumber: "04 / 05"
            titleText: "Estaciones de Batalla de Ultra-Baja Latencia"
            descText: "Eliminamos el mayor dolor de cabeza de Wayland: los micro-tirones en juegos al ejecutarse en ventanas o modo mosaico (tiling). Disfruta de un frame pacing perfecto tanto a pantalla completa como en ventanas."
            feat1Title: "Gaming en Tiling sin Micro-Tirones"
            feat1Desc: "Sincronización explícita optimizada para que tus juegos corran 100% fluidos dentro de ventanas de mosaico sin pérdidas de FPS ni saltos de fotogramas."
            feat2Title: "Direct Scanout & VRR en Ventana"
            feat2Desc: "Desvío del compositor con soporte para G-Sync y FreeSync, permitiendo jugar en ventana con la latencia y suavidad de pantalla completa exclusiva."
            feat3Title: "Libertad Total de Entornos"
            feat3Desc: "Máximo rendimiento gaming configurado tanto en compositores tiling (Hyprland, Niri) como en escritorios completos (KDE Plasma 6, GNOME)."
        }
    }

    // SLIDE 5
    Slide {
        x: 0; y: 0
        width: parent.width; height: parent.height

        X64SlideContent {
            tagText: "POST-INSTALACIÓN & X64-HELLO"
            slideNumber: "05 / 05"
            titleText: "X64-Hello: Tu Centro de Mando Profesional"
            descText: "La instalación está finalizando la configuración en disco. Al reiniciar, la aplicación X64-Hello te recibirá con todas las herramientas de gestión pro y despliegue gamer a un solo clic."
            feat1Title: "Selector de Kernels y Drivers GPU"
            feat1Desc: "Alterna entre kernels de alto rendimiento y configura drivers NVIDIA/AMD en segundos."
            feat2Title: "Gaming Toolkit Pro"
            feat2Desc: "Despliega al instante Proton-GE, Wine, MangoHud, GameMode, Steam, Heroic, Lutris y emuladores."
            feat3Title: "Seguridad y Snapshots Btrfs"
            feat3Desc: "Crea copias de seguridad instantáneas del sistema antes de actualizar para total tranquilidad."
        }
    }

    function onActivate() {
        presentation.currentSlide = 0;
    }

    function onLeave() {
    }
}
