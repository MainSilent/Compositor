import QtQuick 2.12
import QtQuick.Window 2.12
import QtWayland.Compositor 1.3
import Backend 1.0

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

            Desktop {
                shellSurfaces: shellSurfaces
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
