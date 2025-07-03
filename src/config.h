// The configuration this keyboard needs

#pragma once

// Debugging

#define DEBUG_ENABLE
#define MATRIX_DEBUG
// #define DEBUG_MATRIX_SCAN_RATE
#define I2C_DEBUG
#define OS_DETECTION_DEBUG_ENABLE

// The master is one the left side. This means USB can only be plugged in on the left one.
// See: https://docs.qmk.fm/features/split_keyboard#handedness-by-define
#define MASTER_LEFT

// Can also be decided dynamically using `SPLIT_USB_DETECT`.
// No longer in use as something better was found
////#define SPLIT_USB_DETECT

// The communication protocol between the halves.
// See: https://docs.qmk.fm/features/split_keyboard#communication-options
#define USE_I2C
#define I2C_MASTER_SDA D1
#define I2C_MASTER_SCL D0

// For detecting the OS
// See: https://docs.qmk.fm/features/os_detection#configuration-options
#define OS_DETECTION_DEBOUNCE 250
#define OS_DETECTION_KEYBOARD_RESET
#define OS_DETECTION_SINGLE_REPORT

//

#define DYNAMIC_KEYMAP_LAYER_COUNT 8
