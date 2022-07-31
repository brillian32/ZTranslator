import QtQuick
import QtQuick.Controls

Window {
    id:screenshotBackWin
    visible: false
    width: Screen.desktopAvailableWidth
    height:Screen.desktopAvailableHeight
    flags: Qt.FramelessWindowHint
    color: "#00000000"

    Rectangle
    {
        id:fullFill
        anchors.fill: screenshotBackWin
        width: screenshotBackWin.width
        height: screenshotBackWin.height
        opacity: 0.5
        color: "blue"

        Rectangle{
            id:strokeArea //划选范围
            property point start: "0,0"  //划选开始位置
            property point end: "0,0"   //结束位置
            property bool clicked: false
            width:end.x - start.x
            height: end.y - start.y
            x:start.x
            y:start.y
            color: "#00000000"
            //opacity: 0.2
            border.color: "blue"
            border.width: 8
        }

        MouseArea{
            anchors.fill: parent
            onPressed: (event)=>{
                           strokeArea.clicked = true
                           strokeArea.start.x = event.x
                           strokeArea.start.y = event.y
                           fullFill.color = "#00000000"
                           //strokeArea.opacity = 0
                       }
            onPositionChanged: (event)=>
                               {
                                   if(strokeArea.clicked)
                                   {
                                       strokeArea.end.x = event.x
                                       strokeArea.end.y = event.y
                                   }

                               }
            onReleased: {
                strokeArea.clicked = false                

                //strokeArea.opacity = 0.1
                //strokeArea.color = "#00000000"
                cppOcrProcess.grabScreen(screenshotBackWin, strokeArea.start.x,strokeArea.start.y,strokeArea.width,strokeArea.height);
                cppOcrProcess.startOCR("C:\\Users\\17305\\Pictures\\ff.png");  
                screenshotBackWin.hide()
                fullFill.color = "blue"
                strokeArea.end.x = 0
                strokeArea.start.x = 0
            }

        }
    }




}

