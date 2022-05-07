{
    "_": "", 
    "buttons": {
        "A": {
            "action": "button(Keys.KEY_X)"
        }, 
        "B": {
            "action": "button(Keys.KEY_L)"
        }, 
        "BACK": {
            "action": "button(Keys.KEY_BACKSPACE)"
        }, 
        "C": {
            "action": "hold(menu('Default.menu'), menu('Default.menu'))"
        }, 
        "CPADPRESS": {
            "action": "button(Keys.BTN_MOUSE)"
        }, 
        "LB": {
            "action": "button(Keys.BTN_TL)"
        }, 
        "RB": {
            "action": "button(Keys.BTN_TR)"
        }, 
        "RPAD": {
            "action": "button(Keys.BTN_MOUSE)"
        }, 
        "START": {
            "action": "button(Keys.KEY_LEFTSHIFT)"
        }, 
        "X": {
            "action": "button(Keys.KEY_W)"
        }, 
        "Y": {
            "action": "button(Keys.KEY_B)"
        }
    }, 
    "cpad": {
        "action": "sens(1.8, 1.8, mouse())"
    }, 
    "gyro": {}, 
    "is_template": false, 
    "menus": {}, 
    "pad_left": {
        "action": "feedback(LEFT, 4096, 16.0, dpad(button(Keys.KEY_UP), button(Keys.KEY_DOWN), button(Keys.KEY_LEFT), button(Keys.KEY_RIGHT)))"
    }, 
    "pad_right": {
        "action": "smooth(8, 0.75, 2, feedback(RIGHT, 256, sens(2.2, 2.2, mouse())))"
    }, 
    "stick": {
        "action": "dpad(button(Keys.KEY_UP), button(Keys.KEY_DOWN), button(Keys.KEY_LEFT), button(Keys.KEY_RIGHT))"
    }, 
    "trigger_left": {
        "action": "button(Keys.BTN_RIGHT)"
    }, 
    "trigger_right": {
        "action": "button(Keys.BTN_MOUSE)"
    }, 
    "version": 1.4
}