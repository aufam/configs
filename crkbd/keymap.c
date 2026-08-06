#include QMK_KEYBOARD_H

enum {
    // via v12
    FN_MO13 = 0x7c77,
    FN_MO23 = 0x7c78,

    // home row mods
    A_SFT = MT(MOD_LSFT, KC_A),
    S_CTL = MT(MOD_LCTL, KC_S), // QWERTY
    D_SUP = MT(MOD_LGUI, KC_D),
    F_ALT = MT(MOD_LALT, KC_F),

    R_CTL = MT(MOD_LCTL, KC_R), // COLEMAK
    S_SUP = MT(MOD_LGUI, KC_S),
    T_ALT = MT(MOD_LALT, KC_T),

    M_ALT   = MT(MOD_RALT, KC_M),
    COM_SUP = MT(MOD_LGUI, KC_COMM),
    DOT_CTL = MT(MOD_RCTL, KC_DOT),
    SLS_SFT = MT(MOD_RSFT, KC_SLSH),

    // layer tap
    ESC_L2  = LT(2, KC_ESC),
    SPC_L3  = LT(3, KC_SPACE),
    BSPC_L4 = LT(4, KC_BACKSPACE),

#ifdef RGB_MATRIX_ENABLE
    LED_TOG = RM_TOGG,
    LED_NXT = RM_NEXT,
    LED_PRV = RM_PREV,
    LED_HU  = RM_HUEU,
    LED_HD  = RM_HUED,
    LED_SU  = RM_SATU,
    LED_SD  = RM_SATD,
    LED_VU  = RM_VALU,
    LED_VD  = RM_VALD,
#endif
#ifdef RGBLIGHT_ENABLE
    LED_TOG = UG_TOGG,
    LED_NXT = UG_NEXT,
    LED_PRV = UG_PREV,
    LED_HU  = UG_HUEU,
    LED_HD  = UG_HUED,
    LED_SU  = UG_SATU,
    LED_SD  = UG_SATD,
    LED_VU  = UG_VALU,
    LED_VD  = UG_VALD,
#endif

};

// clang-format off
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    // QWERTY
    [0] = LAYOUT(
        //,--------------------------------------------.                    ,--------------------------------------------.
               KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,                         KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,
        //|--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------|
              A_SFT,   S_CTL,   D_SUP,   F_ALT,    KC_G,                         KC_H,    KC_J,    KC_K,    KC_L, KC_SCLN,
        //|--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------|
               KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,                         KC_N,   M_ALT, COM_SUP, DOT_CTL, SLS_SFT,
        //|--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------|
                                         TO(2),  ESC_L2,  SPC_L3,    SC_SENT, BSPC_L4,   TO(4)
                                   //`--------------------------'  `--------------------------'
        ),

    // COLEMAK
    [1] = LAYOUT(
        //,--------------------------------------------.                    ,--------------------------------------------.
               KC_Q,    KC_W,    KC_F,    KC_P,    KC_G,                         KC_J,    KC_L,    KC_U,    KC_Y, KC_SCLN,
        //|--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------|
              A_SFT,   R_CTL,   S_SUP,   T_ALT,    KC_D,                         KC_H,    KC_N,    KC_E,    KC_I,    KC_O,
        //|--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------|
               KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,                         KC_K,   M_ALT, COM_SUP, DOT_CTL, SLS_SFT,
        //|--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------|
                                         TO(0), _______, _______,    _______, _______,   TO(0)
                                   //`--------------------------'  `--------------------------'
        ),

    [2] = LAYOUT(
        //,--------------------------------------------.                    ,--------------------------------------------.
               KC_1,    KC_2,    KC_3,    KC_4,    KC_5,                         KC_6,    KC_7,    KC_8,    KC_9,    KC_0,
        //|--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------|
               KC_6,    KC_7,    KC_8,    KC_9,    KC_0,                      KC_LEFT, KC_DOWN,   KC_UP,KC_RIGHT, XXXXXXX,
        //|--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------|
            KC_BRID, KC_BRIU, KC_VOLD, KC_VOLU, KC_MUTE,                      KC_MSTP, KC_MPLY, KC_MPRV, KC_MNXT, XXXXXXX,
        //|--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------|
                                         TO(0), _______, _______,    _______, _______,   TO(0)
                                   //`--------------------------'  `--------------------------'
        ),

    [3] = LAYOUT(
        //,--------------------------------------------.                    ,--------------------------------------------.
             KC_GRV, KC_TILD,   KC_UP, XXXXXXX,  KC_TAB,                      KC_HOME,  KC_END, KC_PGUP, KC_PGDN, KC_PSCR,
        //|--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------|
             LED_VU, KC_LEFT, KC_DOWN, KC_RGHT,  KC_DEL,                      KC_MINS,  KC_EQL, KC_LBRC, KC_RBRC, KC_BSLS,
        //|--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------|
             LED_VD,  LED_SD,  LED_SU,  LED_HD,  LED_HU,                      KC_LPRN, KC_RPRN, KC_LCBR, KC_RCBR, KC_QUOT,
        //|--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------|
                                         TO(0), _______, _______,    _______, _______,   TO(0)
                                   //`--------------------------'  `--------------------------'
        ),

    [4] = LAYOUT(
        //,--------------------------------------------.                    ,--------------------------------------------.
              KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,                      LED_TOG, MS_BTN1,   MS_UP, MS_BTN2,  KC_ESC,
        //|--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------|
              KC_F6,   KC_F7,   KC_F8,   KC_F9,  KC_F10,                      LED_NXT, MS_LEFT, MS_DOWN, MS_RGHT, MS_WHLU,
        //|--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------|
            XXXXXXX, XXXXXXX, XXXXXXX,  KC_F11,  KC_F12,                      LED_PRV, XXXXXXX, MS_WHLL, MS_WHLR, MS_WHLD,
        //|--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------|
                                         TO(0), _______, _______,    _______, _______,   TO(1)
                                   //`--------------------------'  `--------------------------'
        ),
};
// clang-format on
