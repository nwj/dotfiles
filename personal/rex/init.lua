-- cmd+k clears the terminal (by choice); the session picker moves to shift+cmd+k.
rex.bind("cmd+k", "com.superlogical.terminal.clear")
rex.bind("shift+cmd+k", "session.switch")

-- Splits move to ctrl+cmd+arrows (alongside cmd+alt = focus, cmd+alt+shift = move);
-- shift+cmd+arrows are left to Rectangle for window management.
rex.bind("ctrl+cmd+left",  "pane.split.left")
rex.bind("ctrl+cmd+right", "pane.split.right")
rex.bind("ctrl+cmd+up",    "pane.split.up")
rex.bind("ctrl+cmd+down",  "pane.split.down")
rex.unbind("shift+cmd+left",  "pane.split.left")
rex.unbind("shift+cmd+right", "pane.split.right")
rex.unbind("shift+cmd+up",    "pane.split.up")
rex.unbind("shift+cmd+down",  "pane.split.down")

-- Zoom moves to ctrl+cmd+enter; shift+cmd+enter is Rectangle's maximize.
rex.bind("ctrl+cmd+enter", "pane.zoom")
rex.unbind("shift+cmd+enter", "pane.zoom")
