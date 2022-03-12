// Lith
// Copyright (C) 2020 Martin Bříza
// Copyright (C) 2020 Jakub Mach
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; If not, see <http://www.gnu.org/licenses/>.

import QtQuick 2.12
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3


Rectangle {
    id: root
    color: palette.window

    property alias currentIndex: bufferList.currentIndex
    function clear() {
        filterField.clear()
        if (mobilePlatform)
            filterField.focus = false
        else
            filterField.focus = true
    }

    SystemPalette {
        id: palette
    }


    RowLayout {
        id: controlRow
        anchors {
            left: parent.left
            right: parent.right
            top: window.mobilePlatform ? undefined : parent.top
            bottom: window.mobilePlatform ? parent.bottom : undefined
            margins: 6
        }

        spacing: 6

        Button {
            Layout.preferredWidth: height
            font.pointSize: settings.baseFontSize * 1.25
            icon.source: "qrc:/navigation/"+currentTheme+"/cogwheel.png"
            onClicked: settingsDialog.visible = true
        }
        TextField {
            id: filterField
            Layout.fillWidth: true
            placeholderText: qsTr("Filter buffers")
            text: lith.buffers.filterWord
            onTextChanged: {
                lith.buffers.filterWord = text
                if (text === "")
                    bufferList.currentIndex = lith.selectedBufferIndex
            }
            font.pointSize: settings.baseFontSize * 1.125

            Keys.onPressed: {
                if (event.key === Qt.Key_Up) {
                    bufferList.currentIndex--;
                    event.accepted = true
                }
                if (event.key === Qt.Key_Down) {
                    bufferList.currentIndex++;
                    event.accepted = true
                }
                if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                    lith.selectedBuffer = bufferList.currentItem.buffer
                    filterField.text = ""
                    bufferList.currentIndex = lith.selectedBufferIndex
                    root.close()
                }
                if (event.key === Qt.Key_Escape) {
                    filterField.text = ""
                    bufferList.currentIndex = lith.selectedBufferIndex
                }
            }
        }
    }

    Rectangle {
        id: separator
        anchors {
            left: parent.left
            right: parent.right
            top: window.mobilePlatform ? controlRow.top : undefined
            bottom: window.mobilePlatform ? undefined : controlRow.bottom
            topMargin: -6
            bottomMargin: -6
        }

        height: 1
        color: palette.text
        opacity: 0.5
    }

    ListView {
        id: bufferList

        anchors {
            left: parent.left
            right: parent.right
            top: window.mobilePlatform ? parent.top : separator.bottom
            bottom: window.mobilePlatform ? separator.top : parent.bottom
            topMargin: 6
            bottomMargin: 6
        }

        clip: true
        model: lith.buffers
        currentIndex: lith.selectedBufferIndex
        highlightMoveDuration: root.position > 0.0 ? 120 : 0

        Connections {
            target: lith
            onSelectedBufferIndexChanged: bufferList.currentIndex = lith.selectedBufferIndex
        }

        ScrollBar.vertical: ScrollBar {
            id: scrollBar
            hoverEnabled: true
            active: hovered || pressed
            orientation: Qt.Vertical
        }

        delegate: Rectangle {
            width: ListView.view.width - 1
            height: delegateLayout.height + 12
            property var buffer: modelData
            visible: buffer
            color: index == bufferList.currentIndex ? "#bb6666" : bufferMouse.pressed ? "gray" : bufferMouse.containsMouse ? "light gray" : palette.base

            Behavior on color {
                ColorAnimation {
                    duration: 100
                }
            }

            RowLayout {
                id: delegateLayout
                x: 6
                y: 6
                width: parent.width - 12

                Rectangle {
                    width: bufferName.height + 6
                    height: width
                    color: "#22000000"
                    opacity: buffer && buffer.number <= 10 && !buffer.isServer ? 1 : 0
                    radius: 2
                    Text {
                        text: buffer ? buffer.number : ""
                        anchors.centerIn: parent
                        color: disabledPalette.text
                    }
                    Behavior on opacity { NumberAnimation { duration: 100 } }
                }

                Text {
                    id: bufferName
                    Layout.fillWidth: true
                    clip: true
                    text: buffer ? buffer.short_name.toPlain() === "" ? buffer.name : buffer.short_name
                                 : ""
                    textFormat: Text.RichText
                    font.pointSize: settings.baseFontSize * 1.125
                    color: palette.windowText
                }
                Rectangle {
                    visible: modelData.hotMessages > 0 || modelData.unreadMessages > 0
                    color: modelData.hotMessages ? "red" : palette.alternateBase
                    border.color: palette.text
                    border.width: 1
                    height: bufferName.height + 6
                    width: Math.max(height, hotListItemCount.width + 6)
                    radius: 2
                    Text {
                        id: hotListItemCount
                        text: modelData.hotMessages > 0 ? modelData.hotMessages : modelData.unreadMessages
                        font.pointSize: settings.baseFontSize
                        anchors.centerIn: parent
                        color: palette.windowText
                    }
                }
            }
            MouseArea {
                id: bufferMouse
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    lith.selectedBuffer = buffer
                    if (!window.landscapeMode)
                        bufferDrawer.hide()
                }
            }
        }
    }
}
