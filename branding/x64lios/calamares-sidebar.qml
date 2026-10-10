import io.calamares.ui 1.0
import io.calamares.core 1.0

import QtQuick 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.15

Rectangle {
    id: sideBar;
    color: "#0b0b0d" // Fondo general X64
    height: 48;
    width: parent.width;

    RowLayout {
        anchors.fill: parent;
        anchors.margins: 4;
        spacing: 4;

        Item {
            Layout.fillWidth: true; // Espaciador izquierdo
        }

        Repeater {
            model: ViewManager
            Rectangle {
                Layout.leftMargin: 4;
                Layout.rightMargin: 4;
                Layout.alignment: Qt.AlignCenter;
                height: 32;
                width: textLabel.implicitWidth + 24;
                radius: 4;
                color: index == ViewManager.currentStepIndex ? "#b31b1b" : "transparent";
                border.color: index == ViewManager.currentStepIndex ? "#ff2a2a" : "#333336";
                border.width: index == ViewManager.currentStepIndex ? 1 : 0;

                Text {
                    id: textLabel
                    horizontalAlignment: Text.AlignHCenter; 
                    verticalAlignment: Text.AlignVCenter; 
                    anchors.centerIn: parent;
                    color: index == ViewManager.currentStepIndex ? "#ffffff" : "#888888";
                    
                    text: display;
                    font.weight: (index == ViewManager.currentStepIndex ? Font.Bold : Font.Normal);
                    font.pointSize : 9;
                }
            }
        }
        
        Item {
            Layout.fillWidth: true; // Espaciador derecho
        }
    }
}

