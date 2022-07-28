import QtQuick
import QtQuick.Controls

Window {

    id:screenshotBackWin
    visible: true
    width: Screen.desktopAvailableWidth
    height:Screen.desktopAvailableHeight
    flags: Qt.FramelessWindowHint
    color: "#00000000"

    Rectangle
    {
        id:fullFIll
        anchors.fill: screenshotBackWin
        opacity: 0.5
        color: "grey"
    }


}

