import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import '../components' as C
import '../config.js' as Config

Scope {
    id: root
    property bool centerOpen: false
    ListModel { id: history }

    IpcHandler {
        target: "notifications"
        function toggle(): void { root.centerOpen = !root.centerOpen }
        function open(): void { root.centerOpen = true }
        function close(): void { root.centerOpen = false }
    }

    NotificationServer {
        id: server
        actionsSupported: true
        bodySupported: true
        imageSupported: true

        onNotification: n => {
            history.insert(0, {
                summary: n.summary,
                body: n.body,
                appName: n.appName,
                urgency: n.urgency,
                time: Qt.formatDateTime(new Date(), "HH:mm")
            })
            n.tracked = true
        }
    }

    Variants {
        model: Quickshell.screens

        Scope {
            id: screen_root
            required property var modelData //screen

            //
            // Notification center
            //
            PanelWindow {
                visible: root.centerOpen

                anchors { top: true; bottom: true; right: true }
                implicitWidth: Config.notifications.width + 40

                color: Config.colors.bg4
                exclusionMode: ExclusionMode.Ignore

                ColumnLayout {
                    id: centerCol
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 10

                    RowLayout {
                        Layout.fillWidth: true

                        C.AText {
                            Layout.fillWidth: true
                            text: "Notifications"
                            color: Config.colors.text1
                            font.bold: true
                        }

                        C.AText {
                            text: "Clear all"
                            color: Config.colors.text2
                            visible: history.count > 0

                            MouseArea {
                                anchors.fill: parent
                                onClicked: history.clear()
                            }
                        }
                    }

                    ListView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        clip: true
                        spacing: 10

                        model: history
                        delegate: C.Notification {
                            color: Config.colors.bg2

                            image: model.image || model.appIcon || ""
                            summary: model.summary
                            body: model.body

                            MouseArea {
                                anchors.fill: parent
                                onClicked: history.remove(index, 1)
                            }
                        }
                    }
                }
            }

            //
            // Notifications
            //
            PanelWindow {
                anchors { top: true; right: true }
                margins { top: 10;   right: 10 }

                implicitWidth: Config.notifications.width
                implicitHeight: Math.max(1, column.implicitHeight)

                color: "transparent"
                exclusionMode: ExclusionMode.Ignore

                ColumnLayout {
                    id: column
                    width: parent.width
                    spacing: 10

                    Repeater {
                        model: server.trackedNotifications
                        delegate: C.Notification {
                            id: card
                            required property var modelData

                            image: card.modelData.image || card.modelData.appIcon || ""
                            summary: card.modelData.summary
                            body: card.modelData.body

                            MouseArea {
                                anchors.fill: parent
                                onClicked: card.modelData.dismiss()
                            }

                            Timer {
                                running: card.modelData.urgency !== NotificationUrgency.Critical
                                interval: Config.notifications.timeout
                                onTriggered: card.modelData.dismiss()
                            }
                        }
                    }
                }
            }
        }
    }
}
