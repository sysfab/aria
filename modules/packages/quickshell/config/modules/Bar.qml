import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Services.SystemTray
import QtQuick

import '../components' as C
import '../config.js' as Config

Scope {
    id: root
    property bool barShowed: true

    IpcHandler {
        target: "bar"
        function toggle(): void { root.barShowed = !root.barShowed }
        function show(): void { root.barShowed = true }
        function hide(): void { root.barShowed = false }
    }

    Variants {
        model: Quickshell.screens

        Scope {
            id: screen_root
            required property var modelData //screen

            SystemClock {
                id: clock
                precision: SystemClock.Seconds
            }

            //
            // Bar
            //
            PanelWindow {
                screen: screen_root.modelData
                visible: root.barShowed

                anchors { bottom: true; left: true; right: true }
                implicitHeight: Config.bar.height
                color: Config.colors.bg1

                C.AText {
                    anchors.centerIn: parent
                    text: Qt.formatDateTime(clock.date, "hh:mm:ss")
                    color: Config.colors.text1
                }

                Row {
                    anchors {
                        left: parent.left
                        leftMargin: 10
                        verticalCenter: parent.verticalCenter
                    }
                    spacing: Config.bar.tray.spacing

                    Repeater {
                        model: SystemTray.items
                        delegate: Item {
                            id: trayItem
                            required property SystemTrayItem modelData

                            width: Config.bar.tray.size
                            height: Config.bar.tray.size

                            Image {
                                anchors.fill: parent
                                source: modelData.icon
                            }

                            MouseArea {
                                anchors.fill: parent
                                acceptedButtons: Qt.LeftButton | Qt.RightButton

                                onClicked: e => {
                                    if (e.button === Qt.RightButton) {
                                        contextMenu.open()
                                    } else {
                                        trayItem.modelData.activate()
                                    }
                                }
                            }

                            QsMenuAnchor {
                                id: contextMenu
                                menu: trayItem.modelData.menu

                                anchor {
                                    item: trayItem
                                    edges: Edges.Top
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
