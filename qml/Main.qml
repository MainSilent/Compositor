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

            Repeater {
                model: shellSurfaces
                ShellSurfaceItem {
                    shellSurface: modelData
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
            onPopupCreated: shellSurfaces.append({shellSurface: xdgSurface})
        },
        XdgShellV5 {
            onXdgSurfaceCreated: shellSurfaces.append({shellSurface: xdgSurface})
            onXdgPopupCreated: shellSurfaces.append({shellSurface: xdgPopup})
        },
        XdgShellV6 {
            onToplevelCreated: shellSurfaces.append({shellSurface: xdgSurface})
            onPopupCreated: shellSurfaces.append({shellSurface: xdgSurface})
        },
        IviApplication {
            onIviSurfaceCreated: shellSurfaces.append({shellSurface: iviSurface})
        }
    ]

    ListModel { id: shellSurfaces }
}
