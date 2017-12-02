﻿/*!
 *@file main.qml
 *@brief 主文件
 *@version 1.0
 *@section LICENSE Copyright (C) 2003-2103 CamelSoft Corporation
 *@author zhengtianzuo
*/
import QtQuick 2.7
import QtQuick.Controls 2.0

ApplicationWindow {
    id: frmWindow
    visible: true
    width: 800
    height: 600
    title: qsTr("")
    flags: Qt.Window | Qt.FramelessWindowHint
    font.family: "Microsoft YaHei"
    font.pixelSize: 15

    property int defaultMargin: 6

    MouseArea{
        anchors.fill: parent
        property point clickPos: "0,0"
        onPressed: {
            clickPos  = Qt.point(mouse.x,mouse.y)
        }
        onPositionChanged: {
            var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
            frmWindow.setX(frmWindow.x+delta.x)
            frmWindow.setY(frmWindow.y+delta.y)
        }
    }

    Column{
        height: parent.height
        width: parent.width

        Row{
            id: rowBtn
            height: 24
            spacing: defaultMargin/2
            anchors.right: parent.right
            anchors.rightMargin: defaultMargin
            BaseButton{
                id: btnMin
                anchors.top: parent.top
                anchors.topMargin: defaultMargin
                height: 24
                width: 24
                imgEntered: "qrc:/images/min(3).png"
                imgExited: "qrc:/images/min.png"
                imgPressed: "qrc:/images/min(1).png"
                onSClicked: {
                    showMinimized();
                }
            }
            BaseButton{
                id: btnClose
                anchors.top: parent.top
                anchors.topMargin: defaultMargin
                height: 24
                width: 24
                imgEntered: "qrc:/images/close(3).png"
                imgExited: "qrc:/images/close.png"
                imgPressed: "qrc:/images/close(1).png"
                onSClicked: {
                    Qt.quit();
                }
            }
        }

        TabBar {
            id: bar
            height: 48
            width: 48*myModel.count
            currentIndex: 0

            ListModel {
                id: myModel
                ListElement { modelText: qsTr("数据库"); modelSrc: "qrc:/images/DB.svg"; modelSrcG: "qrc:/images/DBG.svg";}
                ListElement { modelText: qsTr("浏览"); modelSrc: "qrc:/images/List.svg"; modelSrcG: "qrc:/images/ListG.svg";}
                ListElement { modelText: qsTr("查询"); modelSrc: "qrc:/images/Search.svg"; modelSrcG: "qrc:/images/SearchG.svg";}
                ListElement { modelText: qsTr("关于"); modelSrc: "qrc:/images/About.svg"; modelSrcG: "qrc:/images/AboutG.svg";}
            }

            Repeater {
                model: myModel

                TabButton {
                    height: bar.height
                    contentItem:Text{
                        text: modelText
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignBottom
                        font.family: "Microsoft YaHei"
                        font.pixelSize: 15
                        color: (model.index === bar.currentIndex) ? "#148014" : "#000000"
                    }
                    background:Image{
                        width: 24
                        height: 24
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: (model.index === bar.currentIndex) ? modelSrcG : modelSrc
                    }
                }
            }
        }

        SwipeView {
            id: view
            height: frmWindow.height - bar.height - rowBtn.height
            width: parent.width
            currentIndex: bar.currentIndex
            onCurrentIndexChanged: {
                bar.currentIndex = currentIndex;
            }

            DBs{

            }

            Browser{

            }

            Search{

            }

            About{

            }
        }
    }
}