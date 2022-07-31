import QtQuick
import QtQuick.Controls

Window {

    function showTranslateResultTxt(ret)
    {
        resultsTranslate.text = cppTranslaterTool.getTranlateResults();
    }

    function updateInputTxt(ret)
    {
        textInput.text =cppOcrProcess.getResults();
    }
    id:mainWindow
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
    visible: false
    width: 400
    height: 200 + rectInPut.height +rectOutput.height
    color: "#00000000"

    Rectangle{
        id:backGround
        anchors.fill: parent
        color: "#5a3838"
        opacity: 0.5
        radius: 10
    }

    ParallelAnimation{
        id:showAni
        PropertyAnimation{

            target: mainWindow
            properties: "height"
            from:0
            to: 280
            duration: 200
        }
        PropertyAnimation{
            target: mainWindow
            properties: "width"
            from:0
            to: 400
            duration: 200
        }
    }

    ParallelAnimation{
        id:closeAni
        PropertyAnimation{

            target: mainWindow
            properties: "height"
            from:280
            to: 0
            duration: 100
            easing.type: Easing.InOutQuad
        }
        PropertyAnimation{
            target: mainWindow
            properties: "width"
            from:400
            to: 0
            duration: 100
            easing.type: Easing.InOutQuad
        }

    }

    function showWithAnimation()
    {
        mainWindow.setVisible(true);
        showAni.start()
    }

    function hideWithAnimation()
    {
        closeAni.start()
    }

    Rectangle {

        id:rectInPut
        width: parent.width-20
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 50
        height: textInput.lineCount *20
        color: "lightgrey"
        border.color: "grey"

        TextEdit {
            id:textInput
            leftPadding :4
            text: "input text"
            selectByMouse:true
            font.family: "Microsoft YaHei"
            selectedTextColor: "red"
            selectionColor: "green"
            anchors.fill: parent
            color: "black"
            wrapMode :TextInput.WordWrap
        }
    }

    Rectangle {
        id:rectOutput
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: rectInPut.bottom
        anchors.topMargin: 20
        width: parent.width-20
        height: resultsTranslate.lineCount *20
        color: "lightgrey"
        border.color: "grey"
        TextEdit {
            id:resultsTranslate
            leftPadding :4
            font.family: "Microsoft YaHei"
            text: ""
            anchors.fill: parent
            selectByMouse:true
            selectedTextColor: "red"
            selectionColor: "green"
            color: "black"
            wrapMode :TextInput.WordWrap

        }
    }
    Button{
        text:"doTranslate"
        width:78
        height: 30
        MouseArea
        {
            anchors.fill: parent
            onClicked: {
                    mainWindow.tranlate();
            }
        }
    }

    function tranlate(){
        cppTranslaterTool.translate(textInput.text);
    }


}
