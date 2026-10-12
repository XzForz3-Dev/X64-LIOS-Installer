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
                Layout.fillWidth: true
            }

            // Línea Divisoria Carmesí
            Rectangle {
                Layout.fillWidth: true
                height: 2
                color: "#801212"
            }

            // Descripción Principal
            Text {
                text: card.descText
                color: "#a8a8b6"
                font.pixelSize: 13
                wrapMode: Text.WordWrap
                Layout.fillWidth: true
                lineHeight: 1.2
            }

            Item { height: 4 }

            // Lista de Puntos Clave
            ColumnLayout {
                Layout.fillWidth: true
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
                        Layout.fillWidth: true
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
                        Layout.fillWidth: true
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
                        Layout.fillWidth: true
                    }
                }
            }

            Item { Layout.fillHeight: true }
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
        X64SlideContent {
            tagText: "X64 LIOS • FILOSOFÍA SOBERANA"
            slideNumber: "01 / 05"
            titleText: "Máximo Rendimiento Bare-Metal y Gaming Competitivo"
            descText: "Diseñado desde cero para exprimir el 100% de tu hardware sin intermediarios, telemetría oculta ni servicios que consuman recursos en segundo plano."
            feat1Title: "Base Arch Linux Pura"
            feat1Desc: "Control total de tu máquina, actualizaciones continuas y máxima estabilidad operativa."
            feat2Title: "Cero Bloatware"
            feat2Desc: "Solo el software esencial que necesitas, sin dependencias superfluas ni servicios pesados."
            feat3Title: "Arquitectura Optimizada"
            feat3Desc: "Tiempos de arranque ultrarrápidos y respuesta instantánea del sistema operativo."
        }
    }

    // SLIDE 2
    Slide {
        X64SlideContent {
            tagText: "KERNEL & HARDWARE"
            slideNumber: "02 / 05"
            titleText: "Núcleo CachyOS & Latencia Ultrabaja"
            descText: "Impulsado por el kernel Linux CachyOS, adaptado con las técnicas de compilación y planificación más avanzadas del ecosistema de código abierto."
            feat1Title: "Planificador BORE"
            feat1Desc: "Respuesta interactiva garantizada y máxima estabilidad de frametimes en juegos bajo carga pesada."
            feat2Title: "Instrucciones x86-64-v3"
            feat2Desc: "Aprovecha extensiones vectoriales modernas (AVX2, FMA) para mayor tasa de procesamiento."
            feat3Title: "ZRAM con ZSTD"
            feat3Desc: "Compresión de memoria RAM en tiempo real que previene cuellos de botella en multitarea."
        }
    }

    // SLIDE 3
    Slide {
        X64SlideContent {
            tagText: "ECOSISTEMA GAMING"
            slideNumber: "03 / 05"
            titleText: "FalconD: Demonio de Rendimiento en Tiempo Real"
            descText: "Un demonio de control soberano desarrollado para X64 LIOS que gestiona los recursos de tu hardware según la demanda de tus partidas."
            feat1Title: "Priorización Inteligente"
            feat1Desc: "Ajusta la prioridad de los procesos de juego automáticamente al iniciar títulos competitivos."
            feat2Title: "Gestión Energética"
            feat2Desc: "Perfiles de alto rendimiento para equipos de sobremesa y eficiencia balanceada para portátiles."
            feat3Title: "Compatibilidad Handheld"
            feat3Desc: "Soporte nativo y optimizaciones dedicadas para consolas portátiles y controles integrados."
        }
    }

    // SLIDE 4 (Modularidad y Libertad de Elección de Escritorios)
    Slide {
        X64SlideContent {
            tagText: "MODULARIDAD • LIBERTAD DE ELECCIÓN"
            slideNumber: "04 / 05"
            titleText: "Tu Entorno Gráfico, Tus Propias Reglas"
            descText: "X64 LIOS no impone un único flujo de trabajo. Selecciona y disfruta del entorno que mejor potencie tu productividad y estilo personal."
            feat1Title: "Suites Modernas"
            feat1Desc: "KDE Plasma 6 y GNOME con aceleración gráfica completa y soporte nativo Wayland."
            feat2Title: "Tiling Compositors"
            feat2Desc: "Hyprland y Niri para navegación fluida por teclado, animaciones suaves y estética hacker."
            feat3Title: "Ligereza & Clásicos"
            feat3Desc: "COSMIC (Rust), Cinnamon y Xfce4 para mínima huella de memoria y máxima agilidad."
        }
    }

    // SLIDE 5
    Slide {
        X64SlideContent {
            tagText: "ESTADO DE LA INSTALACIÓN"
            slideNumber: "05 / 05"
            titleText: "Tu Sistema se está Configurando en Disco"
            descText: "El instalador está desplegando los paquetes del sistema y configurando el gestor de arranque en tu unidad seleccionada."
            feat1Title: "Despliegue Seguro"
            feat1Desc: "Instalación de paquetes con firmas verificadas y soporte para el esquema de partición deseado."
            feat2Title: "Drivers y Red"
            feat2Desc: "Configuración automatizada de hardware gráfico, adaptadores de red y subsistema de audio PipeWire."
            feat3Title: "Próximo Paso"
            feat3Desc: "Al concluir la barra de progreso, retira el medio de instalación USB y reinicia para entrar en X64 LIOS."
        }
    }

    function onActivate() {
        presentation.currentSlide = 0;
    }

    function onLeave() {
    }
}
