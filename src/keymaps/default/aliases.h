/** This file will contain aliases to the QMK key codes. */

// LETTERS

#define _A_ KC_A
#define _B_ KC_B
#define _C_ KC_C
#define _D_ KC_D
#define _E_ KC_E
#define _F_ KC_F
#define _G_ KC_G
#define _H_ KC_H
#define _I_ KC_I
#define _J_ KC_J
#define _K_ KC_K
#define _L_ KC_L
#define _M_ KC_M
#define _N_ KC_N
#define _O_ KC_O
#define _P_ KC_P
#define _Q_ KC_Q
#define _R_ KC_R
#define _S_ KC_S
#define _T_ KC_T
#define _U_ KC_U
#define _V_ KC_V
#define _W_ KC_W
#define _X_ KC_X
#define _Y_ KC_Y
#define _Z_ KC_Z

// NUMBERS

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

// SYMBOLS

#define _DOT_    KC_DOT            // '.' | Period
#define _COMMA_  KC_COMMA          // ',' | Comma
#define _SLASH_  KC_SLASH          // '/' | Slash
#define _SEM_C_  KC_SEMICOLON      // ';' | Semicolon
#define _B_SLS_  KC_BACKSLASH      // '\' | Backslash
#define _L_BRC_  KC_LEFT_BRACKET   // '[' | square bracket (Left)
#define _R_BRC_  KC_RIGHT_BRACKET  // ']' | square bracket (Right)
#define _L_CBR_  KC_LCBR           // '{' | curly brace (Left)
#define _R_CBR_  KC_RCBR           // '}' | curly brace (Right)
#define _L_PRN_  KC_LPRN           // '(' | parenthesis (Left)
#define _R_PRN_  KC_RPRN           // ')' | parenthesis (Right)
#define _L_T_    KC_LT             // '<' | Less than
#define _G_T_    KC_GT             // '>' | Greater than
#define _MINUS_  KC_MINUS          // '-' | Minus sign
#define _EQUAL_  KC_EQUAL          // '=' | Equal sign
#define _GRAVE_	 KC_GRAVE          // '~' | Tilde
#define _QUOTE_	 KC_QUOTE          //  '  | Single Quote

// SPACIAL CHARACTERS

#define _ESC_    LT(_BRACKETS, KC_ESCAPE)
#define _DEL_    KC_DELETE
#define _B_SPC_  KC_BACKSPACE
#define ___      KC_NO


#define _RIGHT_  KC_RIGHT
#define _LEFT__  KC_LEFT
#define __UP___  KC_UP
#define _DOWN__  KC_DOWN

// WHITE SPACE

#define _TAB_    LT(_BRACKETS, KC_TAB)
#define _ENTER_  LT(_NUMBERS, KC_ENTER)
#define _SPACE_  LT(_NUMBERS, KC_SPACE)

// FUNCTION KEYS

#define _F01_  KC_F1
#define _F02_  KC_F2
#define _F03_  KC_F3
#define _F04_  KC_F4
#define _F05_  KC_F5
#define _F06_  KC_F6
#define _F07_  KC_F7
#define _F08_  KC_F8
#define _F09_  KC_F9
#define _F10_  KC_F10
#define _F11_  KC_F11
#define _F12_  KC_F12
#define _F13_  KC_F13
#define _F14_  KC_F14
#define _F15_  KC_F15
#define _F16_  KC_F16
#define _F17_  KC_F17
#define _F18_  KC_F18
#define _F19_  KC_F19
#define _F20_  KC_F20
#define _F21_  KC_F21
#define _F22_  KC_F22
#define _F23_  KC_F23
#define _F24_  KC_F24
