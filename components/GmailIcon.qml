import QtQuick
import qs.Commons
import qs.Ui

// The official Gmail mark. Keep state indicators as native QML overlays so
// their colours continue to follow the active Omarchy theme.
Item {
  id: root

  property real iconSize: Style.font.icon
  property color color: Color.foreground
  property color backgroundColor: Color.background
  property color badgeColor: Color.urgent
  // A dot, not a count: the bar says "something arrived", the tooltip says
  // how much, and the window says what.
  property bool dot: false
  property bool open: false
  property bool crossed: false

  width: iconSize
  height: iconSize
  implicitWidth: iconSize
  implicitHeight: iconSize

  // Selfh.st names these assets by glyph colour. Pick the contrasting mark
  // from the surface behind it, independently of connection-state dimming.
  readonly property bool lightGlyph: (backgroundColor.r * 0.2126
    + backgroundColor.g * 0.7152 + backgroundColor.b * 0.0722) < 0.5

  Image {
    anchors.fill: parent
    source: Qt.resolvedUrl(root.lightGlyph
      ? "../assets/gmail-light.svg"
      : "../assets/gmail-dark.svg")
    sourceSize.width: root.iconSize
    sourceSize.height: root.iconSize
    fillMode: Image.PreserveAspectFit
    smooth: true
    mipmap: true
  }

  Rectangle {
    visible: root.crossed
    anchors.centerIn: parent
    width: parent.width * 1.22
    height: Math.max(2, parent.height * 0.13)
    radius: height / 2
    color: root.color
    rotation: -45
  }

  // On the corner rather than beside the icon, so the bar slot stays one
  // square whether or not anything is waiting.
  BorderSurface {
    visible: root.dot
    width: Math.max(Style.space(5), parent.width * 0.34)
    height: width
    radius: width / 2
    color: root.badgeColor
    anchors.right: parent.right
    anchors.rightMargin: -parent.width * 0.06
    anchors.top: parent.top
    anchors.topMargin: -parent.height * 0.04
    borderSpec: Border.flat(Color.popups.background, 1)
  }
}
