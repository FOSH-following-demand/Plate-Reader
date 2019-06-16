import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Universal 2.12
import QtQuick.Layouts 1.12


Window {
    id: window
    visible: true
    width: 1920
    height: 1080
    color: "#e4e4e4"
    title: qsTr("Plate Reader")
    visibility: "Maximized"

    signal runClicked()
    signal openCloseClicked()
    signal menuClicked()
    signal playClicked()
    signal pauseClicked()
    signal stopClicked()

    Column {
        anchors.fill: parent

        Rectangle {
            id: header
            width: parent.width
            height: 67
            color: "#ffffff"

            ToolButton {
                id: menuButton
                x: 19
                width: 37
                height: 37
                text: qsTr("menu")
                display: AbstractButton.IconOnly
                icon.source: "icons/baseline-menu-24px.svg"
                anchors.verticalCenter: parent.verticalCenter
                onClicked: () => {
                    menuClicked()
                }
            }

            Text {
                id: title
                x: 113
                y: 15
                text: qsTr("Plate Reader")
                font.weight: Font.Light
                font.family: "Segoe UI"
                font.pixelSize: 25
            }

            ToolButton {
                id: playButton
                x: 1780
                width: 37
                height: 37
                icon.source: "icons/baseline-play_arrow-24px.svg"
                text: "play"
                display: AbstractButton.IconOnly
                anchors.verticalCenter: parent.verticalCenter
                onClicked: () => {
                    window.playClicked()
                }
            }

            ToolButton {
                id: stopButton
                x: 1834
                width: 37
                height: 37
                icon.source: "icons/baseline-stop-24px.svg"
                text: "stop"
                display: AbstractButton.IconOnly
                anchors.verticalCenter: parent.verticalCenter
                onClicked: () => {
                    window.stopClicked()
                }
            }
        }

        Row {
            x: 0
            y: 67
            width: window.width
            height: window.height - 67

            Rectangle {
                id: sideBar
                y: 13
                width: 300
                height: window.height - 73
                color: "#ffffff"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0

                Text {
                    id: openCloseText
                    x: 14
                    y: 20
                    font.pointSize: 14
                    font.family: "Segoe UI"
                }

                Button {
                    id: openButton
                    x: 23
                    y: 64
                    width: 120
                    height: 32
                    font.pointSize: 14
                    font.family: "Segoe UI"
                    state: "close"
                    states: [
                        State {
                            name: "open"
                            PropertyChanges { target: openButton; text: "Open"}
                            PropertyChanges { target: openCloseText; text: "Plate Reader is closed"}
                        },
                        State {
                            name: "close"
                            PropertyChanges { target: openButton; text: "Close"}
                            PropertyChanges { target: openCloseText; text: "Plate Reader is opened"}
                        }
                    ]
                    contentItem: Text {
                        id: openCloseButton
                        text: parent.text
                        font: parent.font
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                        color: parent.enabled ? "#000" : Qt.rgba(0,0,0,.4)
                    }

                    onClicked: () => {
                        openCloseClicked()
                        state = state === "open"? "close": "open"
                    }
                }

                Text {
                    x: 14
                    y: 146
                    text: qsTr("Type of test")
                    font.pointSize: 14
                    font.family: "Segoe UI"
                }

                Column {
                    id: testTypeRadioGroup
                    x: 23
                    y: 190
                    width: 240
                    height: 130

                    RadioButton {
                        id: elisa
                        width: 240
                        text: qsTr("ELISA")
                        spacing: 10
                        focusPolicy: Qt.StrongFocus
                        font.pointSize: 12
                        font.family: "Segoe UI"
                        checked: true
                    }

                    RadioButton {
                        id: nucleicAcidAmplification
                        width: 240
                        text: qsTr("Nucleic Acid Amplification")
                        font.pointSize: 12
                        spacing: 10
                        topPadding: 17
                        focusPolicy: Qt.StrongFocus
                        font.family: "Segoe UI"
                    }

                    RadioButton {
                        id: microbioticsQuantification
                        width: 240
                        text: qsTr("Microbiotics Quantification")
                        spacing: 10
                        padding: 6
                        topPadding: 17
                        font.pointSize: 12
                        font.family: "Segoe UI"
                    }
                }

                Text {
                    x: 23
                    y: 370
                    text: qsTr("Run test")
                    font.pointSize: 14
                }

                Button {
                    id: button
                    x: 23
                    y: 414
                    width: 120
                    height: 32
                    text: qsTr("Run")
                    font.pointSize: 14
                    font.family: "Segoe UI"

                    onClicked: runClicked()
                }
            }

            Rectangle {
                y: 13
                width: parent.width - sideBar.width
                height: window.height - 73
                color: Qt.rgba(0,0,0,0)

                GridLayout {
                    id: grid
                    anchors.rightMargin: 20
                    anchors.leftMargin: 20
                    anchors.bottomMargin: 20
                    anchors.topMargin: 20
                    anchors.fill: parent
                    columnSpacing: 0
                    rowSpacing: 0
                    rows: 2
                    columns: 2

                    Rectangle {
                        id: rectangle3
                        width: 70
                        height: 67
                        color: Qt.rgba(0,0,0,0)
                        Layout.fillWidth: false
                    }

                    RowLayout {
                        id: numLabelRow
                        width: wellsGrid.width
                        height: rectangle3.height
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        spacing: 0

                        Text {
                            text: qsTr("01")
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            font.pixelSize: 50
                        }

                        Text {
                            text: qsTr("02")
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            font.pixelSize: 50
                        }

                        Text {
                            text: qsTr("03")
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            font.pixelSize: 50
                        }

                        Text {
                            text: qsTr("04")
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            font.pixelSize: 50
                        }

                        Text {
                            text: qsTr("05")
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            font.pixelSize: 50
                        }

                        Text {
                            text: qsTr("06")
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            font.pixelSize: 50
                        }

                        Text {
                            text: qsTr("07")
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            font.pixelSize: 50
                        }

                        Text {
                            text: qsTr("08")
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            font.pixelSize: 50
                        }

                        Text {
                            text: qsTr("09")
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            font.pixelSize: 50
                        }

                        Text {
                            text: qsTr("10")
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            font.pixelSize: 50
                        }

                        Text {
                            text: qsTr("11")
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            font.pixelSize: 50
                        }

                        Text {
                            text: qsTr("12")
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            font.pixelSize: 50
                        }
                    }

                    ColumnLayout {
                        id: alphaLabelColumn
                        height: parent.height - 67
                        width: rectangle3.width
                        spacing: 0

                        Text {
                            text: qsTr("A")
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignTop
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            font.family: "Segoe UI"
                            font.pixelSize: 50
                        }

                        Text {
                            text: qsTr("B")
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            font.family: "Segoe UI"
                            font.pixelSize: 50
                        }

                        Text {
                            text: qsTr("C")
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            font.family: "Segoe UI"
                            font.pixelSize: 50
                        }

                        Text {
                            text: qsTr("D")
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            font.family: "Segoe UI"
                            font.pixelSize: 50
                        }

                        Text {
                            text: qsTr("E")
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            font.family: "Segoe UI"
                            font.pixelSize: 50
                        }

                        Text {
                            text: qsTr("F")
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            font.family: "Segoe UI"
                            font.pixelSize: 50
                        }

                        Text {
                            text: qsTr("G")
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            font.family: "Segoe UI"
                            font.pixelSize: 50
                        }

                        Text {
                            text: qsTr("H")
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            font.pixelSize: 50
                        }
                    }

                    GridLayout {
                        id: wellsGrid
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        columns: 12
                        rows: 8
                        columnSpacing: 0
                        rowSpacing: 0

                        Well {
                            id: a1
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }
                        Well {
                            id: a2
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }
                        Well {
                            id: a3
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }
                        Well {
                            id: a4
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }
                        Well {
                            id: a5
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }
                        Well {
                            id: a6
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }
                        Well {
                            id: a7
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }
                        Well {
                            id: a8
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }
                        Well {
                            id: a9
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }
                        Well {
                            id: a10
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }
                        Well {
                            id: a11
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }
                        Well {
                            id: a12
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            value: "0.0"
                        }

                        Well {
                            id: b1
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }

                        Well {
                            id: b2
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }

                        Well {
                            id: b3
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: b4
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: b5
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: b6
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: b7
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: b8
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }

                        Well {
                            id: b9
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: b10
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }

                        Well {
                            id: b11
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: b12
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }

                        Well {
                            id: c1
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }

                        Well {
                            id: c2
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: c3
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }

                        Well {
                            id: c4
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: c5
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: c6
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: c7
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: c8
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: c9
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: c10
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: c11
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: c12
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: d1
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: d2
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: d3
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }
                        Well {
                            id: d4
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }
                        Well {
                            id: d5
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: d6
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: d7
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: d8
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: d9
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: d10
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: d11
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: d12
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                        }
                        Well {
                            id: e1
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: e2
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: e3
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: e4
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: e5
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: e6
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: e7
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: e8
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: e9
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: e10
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: e11
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: e12
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: f1
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: f2
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: f3
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: f4
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: f5
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: f6
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: f7
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: f8
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: f9
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: f10
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: f11
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: f12
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: g1
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: g2
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                        Well {
                            id: g3
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }Well {
                            id: g4
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }
                        Well {
                            id: g5
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }
                        Well {
                            id: g6
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }
                        Well {
                            id: g7
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }
                        Well {
                            id: g8
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }
                        Well {
                            id: g9
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }
                        Well {
                            id: g10
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }
                        Well {
                            id: g11
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }
                        Well {
                            id: g12
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }
                        Well {
                            id: h1
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }
                        Well {
                            id: h2
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }
                        Well {
                            id: h3
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }Well {
                            id: h4
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }
                        Well {
                            id: h5
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }
                        Well {
                            id: h6
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }
                        Well {
                            id: h7
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }
                        Well {
                            id: h8
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }
                        Well {
                            id: h9
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }
                        Well {
                            id: h10
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }
                        Well {
                            id: h11
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            value: "0.0"
                        }
                        Well {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            id: h12
                            value: "0.0"
                        }
                    }
                }
            }
        }
    }
}