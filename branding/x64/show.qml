import QtQuick 2.0;
import calamares.slideshow 1.0;

Presentation
{
    id: presentation

    Slide {
        anchors.fill: parent
        anchors.verticalCenterOffset: 0

        Rectangle {
            anchors.fill: parent
            color: "#000000" // Fondo negro por si la imagen no cubre todo
            
            Image {
                id: background1
                source: "splash.png"
                anchors.fill: parent
                horizontalAlignment: Image.AlignCenter
                verticalAlignment: Image.AlignVCenter
                fillMode: Image.PreserveAspectCrop
            }
        }
    }

    function onActivate() {
        console.log("QML Component (X64 Splash) activated");
        presentation.currentSlide = 0;
    }

    function onLeave() {
        console.log("QML Component (X64 Splash) deactivated");
    }
}
