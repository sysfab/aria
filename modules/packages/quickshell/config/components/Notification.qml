import Quickshell
import QtQuick
import QtQuick.Layouts

import './' as C
import '../config.js' as Config

Rectangle {
    id: root
    property string summary: ""
    property string body: ""
    property var image: ""

    width: Config.notifications.width

    Layout.preferredHeight: layout.implicitHeight + 36
    height: layout.implicitHeight + 36

    radius: Config.radius
    color: Config.colors.bg3

    RowLayout {
        id: layout

        anchors.fill: parent
        anchors.margins: 18
        spacing: 10

        Image {
            Layout.preferredHeight: 36
            Layout.preferredWidth: 36
            Layout.alignment: Qt.AlignTop

            fillMode: Image.PreserveAspectFit

            visible: source.toString() !== ""
            source: image
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: 2

            C.AText {
                Layout.fillWidth: true

                text: root.summary
                elide: Text.ElideRight
                color: Config.colors.text1

                font.bold: true
            }

            C.AText {
                Layout.fillWidth: true

                text: root.body
                visible: root.body !== ""

                wrapMode: Text.WordWrap
                elide: Text.ElideRight
                color: Config.colors.text1
            }
        }
    }
}
