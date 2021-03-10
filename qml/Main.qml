import QtQuick 2.12
import QtQuick.Window 2.12
import QtWayland.Compositor 1.3

WaylandCompositor {
    id: compositor
    
    defaultOutput: WaylandOutput {
        sizeFollowsWindow: true

        window: Window {
            id: root
            width: 1024
            height: 720
            visible: true
            visibility: Qt.WindowFullScreen

            // Background
            Rectangle {
                anchors.fill: parent
                color: "gray"
            }

            // Show Windows
            Repeater {
                model: shellSurfaces
                ShellSurfaceItem {
                    autoCreatePopupItems: true
                    shellSurface: modelData
                    onSurfaceDestroyed: shellSurfaces.remove(index)
                }
            }
        }
    }

    // Windows...
    extensions: [
        WlShell {
            onWlShellSurfaceCreated: shellSurfaces.append({shellSurface: shellSurface})
        },
        XdgShell {
            onToplevelCreated: shellSurfaces.append({shellSurface: xdgSurface})
        },
        XdgShellV6 {
            onToplevelCreated: shellSurfaces.append({shellSurface: xdgSurface})
        }
    ]

    ListModel { id: shellSurfaces }
}
