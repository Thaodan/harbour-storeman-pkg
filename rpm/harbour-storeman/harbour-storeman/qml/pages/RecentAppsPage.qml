import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.orn 1.0
import "../components"

Page {
    id: page
    allowedOrientations: defaultAllowedOrientations

    onStatusChanged: {
        if (status === PageStatus.Active) {
            if (!pageStack._currentContainer.attachedContainer) {
                pageStack.pushAttached(Qt.resolvedUrl("CategoriesPage.qml"))
            }
        }
    }

    OrnRecentAppsModel {
        id: appsModel
    }

    SilicaListView {
        id: appsList
        anchors.fill: parent
        model: networkManager.state === "online" ? appsModel : null

        header: PageHeader {
            //% "Recently updated"
            title: qsTrId("orn-recently-updated")
        }

        delegate: AppListDelegate { }

        section {
            property: "appData.sinceUpdate"
            delegate: SectionHeader {
                text: section
            }
        }

        PullDownMenu {
            id: menu

            MenuItem {
                text: qsTrId("orn-about")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }

            MenuItem {
                text: qsTrId("orn-thisdevice")
                onClicked: pageStack.push(Qt.resolvedUrl("DevicePage.qml"))
            }

            RefreshMenuItem {
                model: appsModel
            }

            MenuItem {
                visible: networkManager.state === "online" &&
                         !appsModel.apiRequest.networkError
                text: qsTrId("orn-search")
                onClicked: pageStack.push(Qt.resolvedUrl("SearchPage.qml"))
            }
        }

        VerticalScrollDecorator { }

        BusyIndicator {
            size: BusyIndicatorSize.Large
            anchors.centerIn: parent
            running: !viewPlaceholder.text &&
                     appsList.count === 0 &&
                     !menu.active
        }

        ViewPlaceholder {
            id: viewPlaceholder
            enabled: text
            text: {
                hintText = ""
                if (networkManager.state === "idle") {
                    //% "Network is unavailable"
                    return qsTrId("orn-network-idle")
                }
                if (appsModel.apiRequest.networkError) {
                    //% "Pull down to refresh"
                    hintText = qsTrId("orn-pull-refresh")
                    //% "A network error occurred"
                    return qsTrId("orn-network-error")
                }
                return ""
            }
        }
    }
}
