{
    "_": "", 
    "buttons": {
        "A": {
            "action": "button(Keys.BTN_GAMEPAD)"
        }, 
        "B": {
            "action": "button(Keys.BTN_EAST)"
        }, 
        "BACK": {
            "action": "button(Keys.BTN_SELECT)"
        }, 
        "C": {
            "action": "hold(menu('Default.menu'), menu('Default.menu'))"
        }, 
        "LB": {
            "action": "button(Keys.BTN_TL)"
        }, 
        "RB": {
            "action": "button(Keys.BTN_TR)"
        }, 
        "START": {
            "action": "button(Keys.BTN_START)"
        }, 
        "X": {
            "action": "button(Keys.BTN_NORTH)"
        }, 
        "Y": {
            "action": "button(Keys.BTN_WEST)"
        }
    }, 
    "cpad": {
        "action": "dpad(hatup(Axes.ABS_HAT0Y), hatdown(Axes.ABS_HAT0Y), hatleft(Axes.ABS_HAT0X), hatright(Axes.ABS_HAT0X))"
    }, 
    "gyro": {}, 
    "is_template": false, 
    "menus": {}, 
    "pad_left": {
        "action": "feedback(LEFT, 4096, 16.0, dpad(button(Keys.KEY_J), button(Keys.KEY_L), button(Keys.KEY_K), button(Keys.KEY_SEMICOLON)))"
    }, 
    "pad_right": {
        "action": "feedback(RIGHT, 256, dpad(button(Keys.KEY_A), button(Keys.KEY_D), button(Keys.KEY_S), button(Keys.KEY_F)))"
    }, 
    "stick": {
        "action": "dpad(None, None, button(Keys.BTN_TL), button(Keys.KEY_SEMICOLON))"
    }, 
    "trigger_left": {
        "action": "trigger(254, 255, button(Keys.KEY_J) and button(Keys.KEY_K) and button(Keys.KEY_L) and button(Keys.KEY_SEMICOLON))"
    }, 
    "trigger_right": {
        "action": "trigger(254, 255, button(Keys.KEY_J) and button(Keys.KEY_K) and button(Keys.KEY_L) and button(Keys.KEY_SEMICOLON))"
    }, 
    "version": 1.4
}