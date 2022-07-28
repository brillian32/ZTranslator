import QtQuick
import QtQuick.Controls

Window {

    id:screenshotBackWin
    visible: false
    width: 1000//Screen.desktopAvailableWidth
    height:1000//Screen.desktopAvailableHeight
    //flags: Qt.FramelessWindowHint
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
            color: "red"
            opacity: 0.2
        }

        MouseArea{
            anchors.fill: parent
            onPressed: (event)=>{
                           strokeArea.clicked = true
                           strokeArea.start.x = event.x
                           strokeArea.start.y = event.y
                            fullFill.color = "#00000000"
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
                fullFill.opacity = 0.5
                strokeArea.opacity = 0.2
                strokeArea.grabToImage(function(result) {
                                       result.saveToFile("C:\\Qt\\cccccc.png");
                                   });
                //screenshotBackWin.close()
            }

        }
    }




}

