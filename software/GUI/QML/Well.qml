import QtQuick 2.0
import QtQuick.Layouts 1.3


Item {
    id: root
    property alias value: value.text
    property alias color: well.color
    property int identifier
    signal clicked(string name)
    state: "notSelected"

    states: [
        State {
            name: "analysing"
            PropertyChanges { target: well; color: "#FFDD00"}
        },
        State {
            name: "selected"
            PropertyChanges { target: well; color: "#0078D7"}
        },
        State {
            name: "notSelected"
            PropertyChanges { target: well; color: "#FFFFFF"}
        },
        State {
            name: "analysed"
            PropertyChanges { target: well; color: "#00D000"}
        }
    ]

    ColumnLayout {
        spacing: 0
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        Rectangle {
            id: well
            width: 35
            height: 35
            radius: width * .5
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            border.width: 1
            border.color: "#707070"

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                onClicked: (e) => {
                    var labels = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']
                    root.state = (root.state == "notSelected" ? "selected" : "notSelected")
                    var name = labels[Math.floor(identifier/12)] + ((identifier % 12)+1)
                    root.clicked(name)
                }
            }
        }

        Text {
            id: value
            text: qsTr("0.0")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            font.family: "Segoe UI"
            font.pixelSize: 15
        }
    }
}