import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12
import QtQuick.Dialogs 1.3


Window {

    readonly property double x_spacing: 9.0
    readonly property double y_spacing: 9.0
    readonly property point a0_position: Qt.point(0, 0)
    property var selectedWells: []
    property string url: "http://localhost:10913/"

    id: window
    visible: true
    width: 1366
    height: 768
    color: "#e4e4e4"
    title: qsTr("Plate Reader")
    visibility: "Maximized"
    onClosing:  {
        close.accepted = false
        onTriggered: messageDialogQuit.open()
    }

    MessageDialog {
        id: messageDialogQuit
        title: qsTr("Close?")
        icon: StandardIcon.Question
        text: qsTr("Do you want to quit?.")
        standardButtons: StandardButton.Yes |StandardButton.No
        onYes: Qt.quit()
    }

    FileDialog {
        id: exportDialog
        title: "Export to file"
        folder: shortcuts.documents
        nameFilters: [
            "Excel (*.xlsx)",
            "CSV (*.csv)",
            "All Files (*.*)"
        ]
        selectExisting: false
        onAccepted: {
            console.log(exportDialog.fileUrl)
        }
    }

    ColumnLayout {
        anchors.fill: parent

        Rectangle {
            id: header
            width: parent.width
            height: 67
            color: "#ffffff"
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.fillWidth: true
            state: "stopped"
            states: [
                State {
                    name: "running"
                    PropertyChanges { target: playButton; enabled: false }
                    PropertyChanges { target: pauseButton; enabled: true }
                    PropertyChanges { target: stopButton; enabled: true }
                    PropertyChanges { target: openCloseButton; enabled: false }
                    PropertyChanges { target: runButton; enabled: false }
                },
                State {
                    name: "paused"
                    PropertyChanges { target: playButton; enabled: true }
                    PropertyChanges { target: pauseButton; enabled: false }
                    PropertyChanges { target: stopButton; enabled: true }
                    PropertyChanges { target: openCloseButton; enabled: false }
                    PropertyChanges { target: runButton; enabled: false }
                },
                State {
                    name: "stopped"
                    PropertyChanges { target: playButton; enabled: true }
                    PropertyChanges { target: pauseButton; enabled: false }
                    PropertyChanges { target: stopButton; enabled: false }
                    PropertyChanges { target: openCloseButton; enabled: true }
                    PropertyChanges { target: runButton; enabled: true }
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
                        sidePanel.state = sidePanel.state === "collapsed" ? "expanded" : "collapsed"
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
                        
                    }
                }
            }
        }

        RowLayout {
            x: 0
            y: 67
            width: window.width
            height: window.height - 67

            Rectangle {
                id: sidePanel
                color: "#ffffff"
                Layout.fillHeight: true
                z: 500
                layer.enabled: true
                layer.effect: DropShadow {
                    horizontalOffset: 1
                    verticalOffset: 1
                    radius: 8.0
                    samples: 17
                    color: "#80000000"
                    source: sidePanel
                    smooth: true
                    width: sidePanel.width
                    height: sidePanel.height
                }

                Behavior on width {
                    NumberAnimation { duration: 200 }
                }

                state: "collapsed"

                states: [
                    State {
                        name: "expanded"
                        PropertyChanges {
                            target: sidePanel
                            width: 200
                        }
                        PropertyChanges {
                            target: saveButton
                            display: AbstractButton.TextBesideIcon
                        }
                        PropertyChanges {
                            target: exportButton
                            display: AbstractButton.TextBesideIcon
                        }
                    },
                    State {
                        name: "collapsed"
                        PropertyChanges {
                            target: sidePanel
                            width: 70
                        }
                        PropertyChanges {
                            target: saveButton
                            display: AbstractButton.IconOnly
                        }
                        PropertyChanges {
                            target: exportButton
                            display: AbstractButton.IconOnly
                        }
                    }
                ]

                ColumnLayout {
                    id: columnLayout
                    spacing: 10
                    width: parent.width

                    ToolButton {
                        id: exportButton
                        text: qsTr("Export Data")
                        Layout.topMargin: 10
                        Layout.leftMargin: 10
                        Layout.rightMargin: 10
                        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                        Layout.fillWidth: true
                        icon.source: "icons/baseline-import_export-24px.svg"
                        onClicked: exportDialog.open()
                    }

                    ToolButton {
                        id: saveButton
                        text: qsTr("Save")
                        Layout.leftMargin: 10
                        Layout.rightMargin: 10
                        Layout.fillWidth: true
                        icon.source: "icons/baseline-save-24px.svg"
                    }
                }
            }

            Rectangle {
                id: sideBar
                y: 13
                width: 300
                height: window.height - 73
                color: "#ffffff"
                Layout.fillHeight: true
                Layout.fillWidth: false

                Text {
                    id: openCloseText
                    x: 14
                    y: 20
                    font.pointSize: 14
                    font.family: "Segoe UI"
                }

                Button {
                    id: openCloseButton
                    x: 2
                    y: 64
                    width: 120
                    height: 32
                    font.pointSize: 14
                    font.family: "Segoe UI"
                    Component.onCompleted: ui.open.connect((value) => {
                        state = value ? 'open' : 'close'
                    })
                    state: "close"
                    states: [
                        State {
                            name: "open"
                            PropertyChanges { target: openCloseButton; text: "Open"}
                            PropertyChanges { target: openCloseText; text: "Plate Reader is closed"}
                        },
                        State {
                            name: "close"
                            PropertyChanges { target: openCloseButton; text: "Close"}
                            PropertyChanges { target: openCloseText; text: "Plate Reader is opened"}
                        }
                    ]
                    contentItem: Text {
                        text: parent.text
                        font: parent.font
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                        color: parent.enabled ? "#000" : Qt.rgba(0,0,0,.4)
                    }

                    onClicked: () => {
                        if (state === "open") {
                            request(`${url}?cmd=G1%20X8%20Y10`, (response) => {
                                console.log(response.responseText)
                                state = "close"
                            })
                        } else if  (state = "close") {
                            request(`${url}?cmd=G1%20X8%20Y10`, (response) => {
                                console.log(response.responseText)
                                state = "open"
                            })
                        }
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
                        text: qsTr("Nucleic Acid Quantification")
                        font.pointSize: 12
                        spacing: 10
                        topPadding: 17
                        focusPolicy: Qt.StrongFocus
                        font.family: "Segoe UI"
                    }

                    RadioButton {
                        id: antibioticsQuantification
                        width: 240
                        text: qsTr("AST")
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
                    id: runButton
                    x: 23
                    y: 414
                    width: 120
                    height: 32
                    text: qsTr("Run")
                    font.pointSize: 14
                    font.family: "Segoe UI"

                    onClicked: {
                        header.state = "running"
                        // Loop through all selected wells
                        selectedWells.forEach(well => {
                            var well_position = calculate_well_position(well)
                            move_to_point(well_position)
                            // TODO: Scan well and print result to screen
                            var well_index = calculate_well_index(well);
                            console.log(well_index)
                            scan_position((response) => {
                                wells.itemAt(well_index).value = response.responseText.substr(2)
                            });
                        });
                        header.state = "stopped"
                    }
                }
            }

            Item {
                y: 13
                width: parent.width - sideBar.width
                height: window.height - 73
                Layout.fillHeight: true
                Layout.fillWidth: true

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
                            id: wells
                            model: 96
                            Well {
                                id: well
                                identifier: index
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                value: "0.0"
                                onClicked: (e) => {
                                    calculate_well_position(e)
                                    var index = selectedWells.indexOf(e)
                                    if (index > 0) selectedWells.splice(index, 1)
                                    else selectedWells.push(e)

                                    selectedWells.sort()
                                }
                            }
                            Component.onCompleted: ui.result.connect(
                                (result) => {
                                    var identifier = result.identifier
                                    var num = parseInt(identifier.slice(1, identifier.length))
                                    var letter = identifier.slice(0,1).charCodeAt(0) - 'A'.charCodeAt(0)
                                    var idx = (12 * letter) + num - 1
                                    wells.itemAt(idx).value = result.result.toString()
                                }
                            )
                        }
                    }
                }
            }
        }
    }

    function request(url, callback) {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = (
            function(myxhr) {
            return function() {
                if (myxhr.readyState === 4) callback(myxhr);
            }
        })(xhr);
        xhr.open('GET', url, true);
        xhr.send('');
    }

    function calculate_well_position(well) {
        const well_char = well[0]
        const well_num = parseInt(well.substr(1))

        const x = a0_position.x + (well_char.charCodeAt(0) - 'A'.charCodeAt(0)) * x_spacing
        const y = a0_position.y + (well_num - 1) * y_spacing

        return Qt.point(x, y)
    }

    function move_to_point(point) {
        request(`${url}?cmd=G1%20X${point.x}%20Y${point.y}`, (response) => {
            console.log(response.responseText)
        })
    }

    // TODO
    function scan_position(callback) {
        request(`${url}?cmd=G95`, callback)
    }

    function calculate_well_index(well) {
        const well_char = well[0]
        const well_num = parseInt(well.substr(1));

        return (well_char.charCodeAt(0) - 'A'.charCodeAt(0)) * 12 + well_num - 1
    }
}
