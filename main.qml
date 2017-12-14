import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import QtMultimedia 5.9

ApplicationWindow {
    visible: true
    width: 1366
    height: 768
    visibility: Window.FullScreen
    title: qsTr("GaitKeeper")
    color: "#212121"

    Rectangle {
        id: gaitframe
        x: 66
        y: 29
        width: 549
        height: 230
        color: "#00000000"
        border.color: "#e65100"
        border.width: 5
        Frame {
            padding: 5
            anchors.fill: parent
            Image {
                anchors.fill: parent
                fillMode: Image.Tile
                source: "images/plot.png"
            }
        }
    }

    Button {
        id: start
        x: 1079
        y: 29
        contentItem: Text {
            text: qsTr("START")
            font.pointSize: 16
            opacity: enabled ? 1.0 : 0.3
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }
        background: Rectangle {
            implicitWidth: 223
            implicitHeight: 48
            opacity: enabled ? 1 : 0.3
            color: start.down ? "#757575" : "#9e9e9e"
        }

        onClicked: {
            progressBar.visible = true
            detectvideo.source = ""
            originalvideo.source = ""
            progressBar.value = 0.0
            start.down = true
            videoanalyze.process()
        }
    }

    Button {
        id: clearCache
        x: 1079
        y: 220
        contentItem: Text {
            text: qsTr("CLEAR CACHE")
            font.pointSize: 16
            opacity: enabled ? 1.0 : 0.3
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }
        background: Rectangle {
            implicitWidth: 223
            implicitHeight: 48
            opacity: enabled ? 1: 0.3
            color: clearCache.down ? "#757575" : "#9e9e9e"
        }
    }

    Rectangle {
        id: detectframe
        x: 66
        y: 289
        width: 549
        height: 230
        color: "#00000000"
        border.color: "#e65100"
        border.width: 5
        Video {
            id: detectvideo
            anchors.fill: parent
            fillMode: 0
            autoPlay: true
            source: ""
        }

    }

    Rectangle {
        id: originalframe
        x: 66
        y: 549
        width: 320
        height: 180
        color: "#00000000"
        border.color: "#e65100"
        border.width: 5
        Video {
            id: originalvideo
            anchors.fill: parent
            fillMode: 0
            autoPlay: true
            source: ""
        }

    }

    Rectangle {
        id: mugshotframe
        x: 445
        y: 549
        width: 230
        height: 180
        color: "#00000000"
        border.color: "#e65100"
        border.width: 5
        Frame {
            padding: 5
            anchors.fill: parent
            Image {
                id: mugshot
                anchors.fill: parent
                source: "images/avatar.png"
            }
        }
    }

    Rectangle {
        id: detailsframe
        x: 697
        y: 549
        width: 486
        height: 180
        color: "#00000000"
        border.color: "#e65100"
        border.width: 5
        Frame {
            padding: 5
            anchors.fill: parent
            Label {
                id: details
                text: qsTr("Label")
            }
        }
    }

    ProgressBar {
        id: progressBar
        value: 0.0
        padding: 2
        x: 1079
        y: 95
        visible: false
        background: Rectangle {
            implicitWidth: 223
            implicitHeight: 9
            color: "#00000000"
            radius: 3
        }

        contentItem: Item {
            implicitWidth: 200
            implicitHeight: 4

            Rectangle {
                width: progressBar.visualPosition * parent.width
                height: parent.height
                radius: 2
                color: "#e65100"
            }
        }
    }

    Connections {
        target: videoanalyze

        onProcessStatus: {
            progressBar.value=val/100
        }

        onProcessCompleted: {
            progressBar.visible=false
            start.down = false
            detectvideo.source="cache/detect.avi"
            originalvideo.source="cache/original.avi"
        }
    }

}
