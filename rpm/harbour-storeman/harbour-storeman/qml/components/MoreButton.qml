import QtQuick 2.0
import Sailfish.Silica 1.0

BackgroundItem {
    property alias text: label.text
    property alias textAlignment: label.horizontalAlignment
    property int depth: 0

    height: Theme.itemSizeSmall

    Label {
        id: label
        anchors {
            left: parent.left
            right: image.left
            verticalCenter: parent.verticalCenter
            leftMargin: Theme.horizontalPageMargin + depth * Theme.paddingLarge
            rightMargin: Theme.paddingMedium
        }
        horizontalAlignment: Text.AlignRight
        truncationMode: TruncationMode.Fade
        color: parent.highlighted ? Theme.highlightColor : Theme.primaryColor
    }

    Image {
        id: image
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
            rightMargin: Theme.horizontalPageMargin
        }
        source: "image://theme/icon-m-right?" +
                (parent.highlighted ? Theme.highlightColor : Theme.primaryColor)
    }
}
