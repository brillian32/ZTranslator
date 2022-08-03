import QtQuick
import QtQuick.Controls


Window {
    id:quickWin
    width: 48/screen.devicePixelRatio
    height: 48/screen.devicePixelRatio
    visible: true
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
    color: colorSet.transparent

    ColorSetting{
        id:colorSet
    }

    Rectangle{
        id:rectOut
        color: colorSet.keyColor
        opacity: 0.25
        width: quickWin.width
        height: quickWin.height
        anchors.top: quickWin.top
        anchors.left: quickWin.left
        radius: 4

    }

    Rectangle{
        id:rectIn
        color: "#1d262f"
        anchors.centerIn: rectOut
        width: 36/screen.devicePixelRatio
        height: 36/screen.devicePixelRatio
        radius: 18/screen.devicePixelRatio

        Text{
            id:textIn
            anchors.centerIn: rectIn
            color:colorSet.keyColor
            //font.family: "Helvetica"
            font.pointSize: 9
            font.bold :true
            text: "35"

        }

        PropertyAnimation{
            id:rectInAnimationBigger
            target: rectIn
            properties: "radius"
            to:4/screen.devicePixelRatio
            easing.type: Easing.InOutQuad
        }

        PropertyAnimation{
            id:rectInAnimationSmaller
            target: rectIn
            properties: "radius"
            to:18/screen.devicePixelRatio
            easing.type: Easing.InOutQuad
        }


    }

    MouseArea{
        id:animationControl
        anchors.fill: rectOut
        hoverEnabled: true
        onEntered: {
            rectInAnimationBigger.start()
        }
        onExited: {
            rectInAnimationSmaller.start()
        }

    }

    MouseArea { //为窗口添加鼠标事件
        anchors.fill: rectOut
        acceptedButtons: Qt.LeftButton //只处理鼠标左键
        property point clickPos: "0,0"
        onPressed:(mouse) => { //接收鼠标按下事件
                clickPos  = Qt.point(mouse.x,mouse.y)
        }
        onPositionChanged: (mouse) =>{ //鼠标按下后改变位置
                //鼠标偏移量
                var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)

                //如果mainwindow继承自QWidget,用setPos
                quickWin.setX(quickWin.x+delta.x)
                quickWin.setY(quickWin.y+delta.y)
        }
        onDoubleClicked: {
            if(mainWindow.height === 0 ||!mainWindow.visible){
                //screenshotBackWin.show()
                mainWindow.showWithAnimation()
                console.log("show")

            }
            else{
                //screenshotBackWin.hide()
                mainWindow.hideWithAnimation();
                console.log("hide");
            }
        }
    }

    MainWindow{
        id:mainWindow
        x:quickWin.x + 50
        y:quickWin.y + 50
    }

    FullScreenWindow{
        x:0
        y:0
        id:screenshotBackWin
    }

    function showTranslateResultTxt(param)
    {
        mainWindow.showTranslateResultTxt();
    }

    function updateInputText(param)
    {
        mainWindow.updateInputTxt();
        mainWindow.tranlate();
    }

    function showScreenShotWindow(param)
    {
        screenshotBackWin.show();
    }

}
