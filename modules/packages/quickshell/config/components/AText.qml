import QtQuick

import '../config.js' as Config

Text {
    id: root
    property int size: Config.font.size.S

    font {
        family: Config.font.family
        pixelSize: root.size
    }
}
