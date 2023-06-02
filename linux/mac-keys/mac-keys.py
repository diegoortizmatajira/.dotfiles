# -*- coding: utf-8 -*-
# autostart = true

import re
from xkeysnail.transform import *

# Use the following for testing terminal keymaps
# terminals = [ "", ... ]
# xbindkeys -mk
terminals = [
    "gnome-terminal",
    "guake",
    "kitty",
    "st",
    "urxvt",
    "xterm",
]
terminals = [term.casefold() for term in terminals]
termStr = "|".join(str('^' + x + '$') for x in terminals)

define_keymap(None, {
    K("LSuper-X"): K("C-X"),
    K("LSuper-C"): K("C-C"),
    K("LSuper-V"): K("C-V"),
}, "terminals")
define_keymap(
    re.compile(termStr, re.IGNORECASE), {
        K("LSuper-X"): K("C-Shift-X"),
        K("LSuper-C"): K("C-Shift-C"),
        K("LSuper-V"): K("C-Shift-V"),
    }, "terminals")
