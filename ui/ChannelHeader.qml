// Lith
// Copyright (C) 2020 Martin Bříza
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
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

import lith 1.0

Rectangle {
    id: root
    color: palette.window

    SystemPalette {
        id: palette
    }

    height: headerLayout.height + 12

    DragHandler {
        onActiveChanged: if (active) window.startSystemMove();
        target: null
    }

    Rectangle {
        anchors {
            left: parent.left
            leftMargin: 1
            right: parent.right
            bottom: parent.bottom
        }
        height: 1
        color: palette.text
        opacity: 0.5
    }

    RowLayout {
        id: headerLayout
        x: 6
        y: 6
        width: parent.width - 12
        Button {
            id: bufferListButton
            focusPolicy: Qt.NoFocus
            Layout.preferredWidth: height
            font.pointSize: settings.baseFontSize * 1.375
            icon.source: "qrc:/navigation/"+currentTheme+"/menu.png"
            onClicked: {
                bufferDrawer.toggle()
            }
            ToolTip.text: "Open buffer list,\nAccess configuration"
            ToolTip.visible: bufferListButton.hovered
            ToolTip.delay: 800
        }
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 0
            Label {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: palette.text
                clip: true
                height: 1
                font.bold: true
                font.pointSize: lith.selectedBuffer && lith.selectedBuffer.title.length > 0 ? settings.baseFontSize * 0.875 :
                                                                                    settings.baseFontSize * 1.125
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: lith.selectedBuffer ? lith.selectedBuffer.name : "Lith"
                renderType: Text.NativeRendering
            }
            Label {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: palette.text
                visible: !lith.selectedBuffer || lith.selectedBuffer.title.length > 0
                clip: true
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                text: lith.selectedBuffer ? lith.selectedBuffer.title.toPlain() :
                      lith.status === Lith.UNCONFIGURED ? "Not configured" :
                      lith.status === Lith.CONNECTING ? "Connecting" :
                      lith.status === Lith.CONNECTED ? "Connected" :
                      lith.status === Lith.DISCONNECTED ? "Disconnected" :
                      lith.status === Lith.ERROR ? "Error: " + lith.errorString :
                                                   ""
                elide: Text.ElideRight
                maximumLineCount: 2
                font.pointSize: settings.baseFontSize * 0.75
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                renderType: Text.NativeRendering
                onLinkActivated: {
                    linkHandler.show(link, root)
                }
                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.NoButton
                    cursorShape: parent.hoveredLink.length > 0 ? Qt.PointingHandCursor : Qt.ArrowCursor
                }
            }
        }
        Item { width: 1 }
        Button {
            id: nickListButton
            focusPolicy: Qt.NoFocus
            Layout.preferredWidth: height
            font.pointSize: settings.baseFontSize * 1.375
            visible: lith.status !== Lith.UNCONFIGURED
            enabled: lith.status === Lith.CONNECTED
            onClicked: {
                nickDrawer.visible = !nickDrawer.visible
                if(!window.platform.mobile) nickDrawer.open()
            }
            icon.source: lith.status === Lith.CONNECTING   ? "qrc:/navigation/"+currentTheme+"/transfer.png" :
                         lith.status === Lith.CONNECTED    ? "qrc:/navigation/"+currentTheme+"/smile.png" :
                         lith.status === Lith.DISCONNECTED ? "qrc:/navigation/"+currentTheme+"/no-wifi.png" :
                         lith.status === Lith.ERROR        ? "qrc:/navigation/"+currentTheme+"/sleeping.png" :
                                                             "qrc:/navigation/"+currentTheme+"/dizzy.png"
            ToolTip.text: "Open channel information"
            ToolTip.visible: nickListButton.hovered
            ToolTip.delay: 800
        }
    }
}
