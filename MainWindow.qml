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
    width: 840
    height: 540
    color: colorSet.transparent

    Rectangle{
        id:backGround
        anchors.fill: parent
        color: colorSet.backGround
        opacity: 0.5
        radius: 10
    }

    ParallelAnimation{
        id:showAni
        PropertyAnimation{

            target: mainWindow
            properties: "height"
            from:0
            to: 540
            duration: 100
        }
        PropertyAnimation{
            target: mainWindow
            properties: "width"
            from:0
            to: 840
            duration: 100
        }
    }

    ParallelAnimation{
        id:closeAni
        PropertyAnimation{

            target: mainWindow
            properties: "height"
            from:540
            to: 0
            duration: 100
            easing.type: Easing.InOutQuad
        }
        PropertyAnimation{
            target: mainWindow
            properties: "width"
            from:840
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
            width: parent.width/2-20
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 50
            height: 300/*textInput.contentHeight*/
            color: colorSet.textBackGround
            border.color: "grey"
            ScrollView{
                id:scrollViewInput
                anchors.fill: parent
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                ScrollBar.vertical.policy: ScrollBar.AlwaysOn

                TextEdit {
                    id:textInput
                    leftPadding :4
                    text: "input text"
                    selectByMouse:true
                    font.family: "Microsoft YaHei"
                    selectedTextColor: colorSet.selectText
                    selectionColor: colorSet.selectTextBack
                    //anchors.fill: parent  //此处需要注释，取消填充
                    width:rectInPut.width-20
                    color: colorSet.text
                    wrapMode :TextInput.Wrap
                }
            }

        }

        Rectangle {
            id:rectOutput
            anchors.top: parent.top
            anchors.topMargin: 50
            anchors.left: rectInPut.right
            anchors.leftMargin: 20
            width: parent.width/2-20
            height: 300/*resultsTranslate.contentHeight*/
            color: colorSet.textBackGround
            border.color: "grey"

            ScrollView{
                id:scrollViewOutput
                anchors.fill: parent
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                ScrollBar.vertical.policy: ScrollBar.AlwaysOn
                TextEdit {
                        id:resultsTranslate
                        leftPadding :4
                        font.family: "Microsoft YaHei"
                        text: ""
                        //anchors.fill: parent
                        width:rectOutput.width-20
                        selectByMouse:true
                        selectedTextColor: colorSet.selectText
                        selectionColor: colorSet.selectTextBack
                        color: colorSet.text
                        wrapMode :TextInput.Wrap
                    }
        }
    }

        Text {
            id:titleName
            height: 9
            width: contentWidth+5
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 10
            text: "发音:"
            anchors.left: rectOutput.left
            anchors.topMargin: 10
            anchors.top:rectOutput.bottom
            color: colorSet.text
        }
        Text{
            id:interpretationOutpot //音译
            anchors.top: rectOutput.bottom
            anchors.topMargin: 10
            anchors.left: titleName.right
            anchors.leftMargin: 5
            text:"interpretation Outpot"
            font.bold: false
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 9
            width: contentWidth
            height: 10
            color: colorSet.text
        }

        Item {
            id: example
            text: qsTr("text")

        }


    Button{
        id:btn
        contentItem: Text {
            text: btn.text
            font: btn.font
            opacity: enabled ? 1.0 : 0.7
            color: btn.down ? colorSet.text : colorSet.overlay1
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }
        text:"doTranslate"
        x:10
        y:10
        width:78
        height: 30

        background: Rectangle {
            anchors.fill: parent
            opacity: enabled ? 1 : 0.7
            border.color: btn.down ? colorSet.keyColor : colorSet.overlay1
            border.width: 1
            color:colorSet.keyColor
            radius: 2
        }

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
