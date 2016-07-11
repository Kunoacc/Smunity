import QtQuick 2.6
import QtQuick.Layouts 1.3
import Qt.labs.controls 1.0
import Qt.labs.controls.universal 1.0
import Qt.labs.settings 1.0


ApplicationWindow {
    id: window
    width: 360
    height: 520
    visible: true
    title: "Smunity"

    Settings {
        id: settings
        property string style: "Universal"
    }

    header: ToolBar {
        id: toolBar
        RowLayout {
            spacing: 20
            anchors.fill: parent

            ToolButton {
                label: Image {
                    anchors.centerIn: parent
                    source: "qrc:/images/drawer.png"
                }
                onClicked: drawer.open()
            }

            Label {
                id: headerLabel
                text: "Home"
                font.pixelSize: 20
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }

            ToolButton {
                label: Image {
                    anchors.centerIn: parent
                    source: "qrc:/images/action.png"
                }
                onClicked: options.open()

                Menu {
                    id: options
                    x: parent.width - width
                    transformOrigin: Menu.TopRight

                    MenuItem {
                        text:  "About"
                        onTriggered: aboutDialog.open()
                    }
                    MenuItem {
                        text: "About dev"
                        onTriggered: devDialog.open()
                    }
                    MenuItem {
                        text: "Exit"
                        onTriggered: Qt.quit()
                    }
                }
            }
        }
    }

    Drawer {
        id: drawer

        Pane {
            padding: 0
            width: Math.min(window.width, window.height) / 3*2
            height: window.height

            ListView {
                id: listView
                currentIndex: -1
                anchors.fill: parent
                header: ToolBar {
                    anchors.bottomMargin: 30
                    width: listView.width
                    height: toolBar.height

                   RowLayout {
                       spacing: 20
                       anchors.fill: parent

                       ToolButton {
                           label: Image {
                               anchors.centerIn: parent
                               source: "qrc:/images/closeDrawer.png"
                           }
                           onClicked: drawer.close()
                       }

                       Label {
                           id: drawerLabel
                           text: "Menu"
                           font.pixelSize: 20
                           elide: Label.ElideRight
                           horizontalAlignment: Qt.AlignLeft
                           verticalAlignment: Qt.AlignVCenter
                           Layout.fillWidth: true
                       }
                   }
                }

                delegate: ItemDelegate{
                    width: parent.width
                    text: model.title
                    highlighted: ListView.isCurrentItem
                    onClicked: {
                        if (listView.currentIndex != index) {
                            listView.currentIndex = index
                            headerLabel.text = model.title
                            stackView.replace(model.source)
                        }
                        drawer.close()
                    }
                }

                model: ListModel {
                    ListElement {title: "<img src=\"qrc:/images/portal.png\" align=\"middle\"/>   SU Portal"; source:"qrc:/Portal.qml"}
                    ListElement {title: "<img src=\"qrc:/images/website.png\" align=\"middle\"/>   SU Website"; source: "qrc:/Website.qml"}
                    ListElement {title: "<img src=\"qrc:/images/airtime.png\" align=\"middle\"/>   Purchase Airtime"; source: "qrc:/Airtime.qml"}
                }
            }
        }
        onClicked: close()
    }
    StackView {
        id: stackView
        anchors.fill: parent

        initialItem: Pane {
            id: pane
            anchors.fill: parent

            Image {
                id: logo
                width: pane.availableWidth / 2
                height: pane.availableHeight / 2
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -50
                fillMode: Image.PreserveAspectFit
                source: "qrc:/images/slogo.png"
            }

            Label {
                color: "#26282a"
                text: "Welcome to Smunity, you one stop to all of salem's online resources and more."
                anchors.margins: 20
                anchors.top: logo.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
                wrapMode: Label.Wrap
            }
        }
    }

    Popup {
        id: aboutDialog
        modal: true
        focus: true
        x: (window.width - width) / 2
        y: window.height / 6
        width: Math.min(window.width, window.height) / 3 * 2
        contentHeight: settingsColumn.height
        closePolicy: Popup.OnEscape | Popup.OnPressOutside

        Column {
            id: settingsColumn
            spacing: 20

            Label {
                text: "About"
                font.bold: true
            }

            Label {
                width: aboutDialog.availableWidth
                text: "Smunity is an app designed for easy access to SU online resources \n as later versions become avalible so will bug fixes and new features."
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }
        }
    }

    Popup {
        id: devDialog
        modal: true
        focus: true
        x: (window.width - width) / 2
        y: window.height / 6
        width: Math.min(window.width, window.height) / 3 * 2
        contentHeight: devColumn.height
        closePolicy: Popup.OnEscape | Popup.OnPressOutside

        Column {
            id: devColumn
            spacing: 20

            Label {
                text: "About the developer"
                font.bold: true
            }

            Label {
                width: devDialog.availableWidth
                text: "It is what it is"
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }
        }
    }
}
