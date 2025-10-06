// Copyright (c) 2025 - Tygo van den Hurk
// SPDX-License-Identifier: ELP-2.0

#pragma once

#include "snowflake_layers.h"

//` Mod bits

#define SHIFT (MOD_BIT(KC_LEFT_SHIFT) | MOD_BIT(KC_RIGHT_SHIFT))
#define CTRL (MOD_BIT(KC_LEFT_CTRL) | MOD_BIT(KC_RIGHT_CTRL))
#define ALT (MOD_BIT(KC_LEFT_ALT) | MOD_BIT(KC_RIGHT_ALT))
#define GUI (MOD_BIT(KC_LEFT_GUI) | MOD_BIT(KC_RIGHT_GUI))

//` QMK Return Codes

#define CONTINUE true
#define CONCLUDE false

//` Arrow keys

#define __UP___ KC_UP    // '' | The UP arrow to move 1 character UP.
#define _RIGHT_ KC_RIGHT // '' | The RIGHT arrow to move 1 character RIGHT.
#define _DOWN__ KC_DOWN  // '' | The DOWN arrow to move 1 character DOWN.
#define _LEFT__ KC_LEFT  // '' | The LEFT arrow to move 1 character LEFT.

//` LETTERS

#define _A_ KC_A // 'A' | The letter A
#define _B_ KC_B // 'B' | The letter B
#define _C_ KC_C // 'C' | The letter C
#define _D_ KC_D // 'D' | The letter D
#define _E_ KC_E // 'E' | The letter E
#define _F_ KC_F // 'F' | The letter F
#define _G_ KC_G // 'G' | The letter G
#define _H_ KC_H // 'H' | The letter H
#define _I_ KC_I // 'I' | The letter I
#define _J_ KC_J // 'J' | The letter J
#define _K_ KC_K // 'K' | The letter K
#define _L_ KC_L // 'L' | The letter L
#define _M_ KC_M // 'M' | The letter M
#define _N_ KC_N // 'N' | The letter N
#define _O_ KC_O // 'O' | The letter O
#define _P_ KC_P // 'P' | The letter P
#define _Q_ KC_Q // 'Q' | The letter Q
#define _R_ KC_R // 'R' | The letter R
#define _S_ KC_S // 'S' | The letter S
#define _T_ KC_T // 'T' | The letter T
#define _U_ KC_U // 'U' | The letter U
#define _V_ KC_V // 'V' | The letter V
#define _W_ KC_W // 'W' | The letter W
#define _X_ KC_X // 'X' | The letter X
#define _Y_ KC_Y // 'Y' | The letter Y
#define _Z_ KC_Z // 'Z' | The letter Z

//` NUMBERS

#define _1_ KC_1 // '1' | The number one
#define _2_ KC_2 // '2' | The number two
#define _3_ KC_3 // '3' | The number three
#define _4_ KC_4 // '4' | The number four
#define _5_ KC_5 // '5' | The number five
#define _6_ KC_6 // '6' | The number six
#define _7_ KC_7 // '7' | The number seven
#define _8_ KC_8 // '8' | The number eight
#define _9_ KC_9 // '9' | The number nine
#define _0_ KC_0 // '0' | The number zero

//` SYMBOLS

#define _DOT_ KC_DOT             // '.' | Period
#define _COMMA_ KC_COMMA         // ',' | Comma
#define _SLASH_ KC_SLASH         // '/' | Slash
#define _SEM_C_ KC_SEMICOLON     // ';' | Semicolon
#define _B_SLS_ KC_BACKSLASH     // '\' | Backslash
#define _L_BRC_ KC_LEFT_BRACKET  // '[' | square bracket (Left)
#define _R_BRC_ KC_RIGHT_BRACKET // ']' | square bracket (Right)
#define _L_CBR_ KC_LCBR          // '{' | curly brace (Left)
#define _R_CBR_ KC_RCBR          // '}' | curly brace (Right)
#define _L_PRN_ KC_LPRN          // '(' | parenthesis (Left)
#define _R_PRN_ KC_RPRN          // ')' | parenthesis (Right)
#define _L_T_ KC_LT              // '<' | Less than
#define _G_T_ KC_GT              // '>' | Greater than
#define _MINUS_ KC_MINUS         // '-' | Minus sign
#define _EQUAL_ KC_EQUAL         // '=' | Equal sign
#define _GRAVE_ KC_GRAVE         // '~' | Tilde
#define _QUOTE_ KC_QUOTE         //  '  | Single Quote

//` SPACIAL CHARACTERS

#define _ESC_ LT(SNOWFLAKE_LAYER_BRACKETS, KC_ESCAPE)
#define _DEL_ LT(SNOWFLAKE_LAYER_MISCELLANEOUS, KC_DELETE)
#define _B_SPC_ LT(SNOWFLAKE_LAYER_ARROWS, KC_BACKSPACE)
#define ___ KC_NO

//` WHITE SPACE

#define _TAB_ LT(SNOWFLAKE_LAYER_BRACKETS, KC_TAB)
#define _ENTER_ LT(SNOWFLAKE_LAYER_NUMBERS, KC_ENTER)
#define _SPACE_ LT(SNOWFLAKE_LAYER_NUMBERS, KC_SPACE)

//` FUNCTION KEYS

#define _F01_ KC_F1
#define _F02_ KC_F2
#define _F03_ KC_F3
#define _F04_ KC_F4
#define _F05_ KC_F5
#define _F06_ KC_F6
#define _F07_ KC_F7
#define _F08_ KC_F8
#define _F09_ KC_F9
#define _F10_ KC_F10
#define _F11_ KC_F11
#define _F12_ KC_F12
#define _F13_ KC_F13
#define _F14_ KC_F14
#define _F15_ KC_F15
#define _F16_ KC_F16
#define _F17_ KC_F17
#define _F18_ KC_F18
#define _F19_ KC_F19
#define _F20_ KC_F20
#define _F21_ KC_F21
#define _F22_ KC_F22
#define _F23_ KC_F23
#define _F24_ KC_F24

#define _MEDIA_ TD(TD_MEDIA)
#define _VOL_U_ KC_AUDIO_VOL_UP
#define _VOL_D_ KC_AUDIO_VOL_DOWN

#define _WWW_FWD_ KC_WWW_FORWARD
#define _WWW_BCK_ KC_WWW_BACK

#define _MACRO_R_1_ QK_DYNAMIC_MACRO_RECORD_START_1
#define _MACRO_R_2_ QK_DYNAMIC_MACRO_RECORD_START_2
#define _MACRO_P_1_ QK_DYNAMIC_MACRO_PLAY_1
#define _MACRO_P_2_ QK_DYNAMIC_MACRO_PLAY_2
#define _MACRO_STOP QK_DYNAMIC_MACRO_RECORD_STOP

//` Layers

#define _NAV(key) LT(SNOWFLAKE_LAYER_NAVIGATION, key)
#define _ARW(key) LT(SNOWFLAKE_LAYER_ARROWS, key)
