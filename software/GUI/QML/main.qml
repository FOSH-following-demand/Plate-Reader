import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Universal 2.12
import QtQuick.Layouts 1.12


Window {
    id: window
    visible: true
    width: 640
    height: 480
    color: "#e4e4e4"
    title: qsTr("Plate Reader")
    visibility: "Maximized"

    signal runClicked()
    signal openCloseClicked()
    signal menuClicked()
    signal playClicked()
    signal pauseClicked()
    signal stopClicked()
    signal wellSelected(string name)

    Column {
        anchors.fill: parent

        Rectangle {
            id: header
            width: parent.width
            height: 67
            color: "#ffffff"
            state: "stopped"
            states: [
                State {
                    name: "running"
                    PropertyChanges { target: playButton; enabled: false }
                    PropertyChanges { target: pauseButton; enabled: true }
                    PropertyChanges { target: stopButton; enabled: true }
                },
                State {
                    name: "paused"
                    PropertyChanges { target: playButton; enabled: true }
                    PropertyChanges { target: pauseButton; enabled: false }
                    PropertyChanges { target: stopButton; enabled: true }
                },
                State {
                    name: "stopped"
                    PropertyChanges { target: playButton; enabled: true }
                    PropertyChanges { target: pauseButton; enabled: false }
                    PropertyChanges { target: stopButton; enabled: false }
                }
            ]
            
            RowLayout {
                width: parent.width
                height: parent.height

                ToolButton {
                    id: menuButton
                    width: 37
                    height: 37
                    text: qsTr("menu")
                    display: AbstractButton.IconOnly
                    Layout.alignment: Qt.AlignVCenter
                    icon.source: "icons/baseline-menu-24px.svg"
                    Layout.leftMargin: 19
                    onClicked: () => {
                        menuClicked()
                    }
                }

                Text {
                    id: title
                    text: qsTr("Plate Reader")
                    font.weight: Font.Light
                    font.family: "Segoe UI"
                    font.pixelSize: 25
                    Layout.alignment: Qt.AlignVCenter
                    Layout.leftMargin: 20 
                }

                Item {
                    Layout.fillWidth: true
                }

                ToolButton {
                    id: playButton
                    width: 37
                    height: 37
                    icon.source: "icons/baseline-play_arrow-24px.svg"
                    text: "play"
                    display: AbstractButton.IconOnly
                    Layout.alignment: Qt.AlignVCenter
                    Layout.rightMargin: 20
                    onClicked: () => {
                        window.playClicked()
                        console.log(header.state)
                        if (header.state !== "running") {
                            console.log("Something weird is happening...")
                            header.state = "running"
                        }
                        console.log(header.state)
                    }
                }

                ToolButton {
                    id: pauseButton
                    width: 37
                    height: 37
                    icon.source: "icons/baseline-pause-24px.svg"
                    text: "play"
                    display: AbstractButton.IconOnly
                    Layout.alignment: Qt.AlignVCenter
                    Layout.rightMargin: 20
                    onClicked: () => {
                        window.pauseClicked()
                        if (header.state !== "paused") {
                            header.state = "paused"
                        }
                    }
                }

                ToolButton {
                    id: stopButton
                    width: 37
                    height: 37
                    icon.source: "icons/baseline-stop-24px.svg"
                    text: "stop"
                    display: AbstractButton.IconOnly
                    Layout.alignment: Qt.AlignVCenter
                    Layout.rightMargin: 20
                    onClicked: () => {
                        window.stopClicked()
                        if (header.state !== "stopped") {
                            header.state = "stopped"
                        }
                    }
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

            Item {
                y: 13
                width: parent.width - sideBar.width
                height: window.height - 73

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

                    Item {
                        id: rectangle3
                        width: 70
                        height: 67
                        Layout.fillWidth: false
                    }

                    RowLayout {
                        id: numLabelRow
                        width: wellsGrid.width
                        height: rectangle3.height
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        spacing: 0

                        Repeater {
                            model: ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12']
                            Text {
                                text: qsTr(modelData)
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                font.family: "Segoe UI"
                                font.pixelSize: 50
                            }
                        }
                    }

                    ColumnLayout {
                        id: alphaLabelColumn
                        height: parent.height - 67
                        width: rectangle3.width
                        spacing: 0

                        Repeater {
                            model: ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']
                            Text {
                                text: qsTr(modelData)
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignTop
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                font.family: "Segoe UI"
                                font.pixelSize: 50
                            }
                        }
                    }

                    GridLayout {
                        id: wellsGrid
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        columns: 12
                        rows: 8
                        columnSpacing: 0
                        rowSpacing: 0

                        Repeater {
                            model: 96
                            Well {
                                identifier: index
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                value: "0.0"
                                onClicked: (e) => {
                                    window.wellSelected(e)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}