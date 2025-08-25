// Copyright (c) 2025 - Tygo van den Hurk
// SPDX-License-Identifier: ELP-2.0

#pragma once

// Keyboard firmware version
#define FIRMWARE_VERSION "v0.0.0"

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ VIA support ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //

// Defines how many key layers should be kept in RAM Only useful if I wanna
// change them without compiling. Not our workflow. Uses a lot of RAM as well.
#define DYNAMIC_KEYMAP_LAYER_COUNT 0

// Remove VIA support
#undef VIA_ENABLE

// Remove VIAL support
#undef VIAL_ENABLE

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Debugging ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //

#define DEBUG_ENABLE
#define MATRIX_DEBUG
// #define DEBUG_MATRIX_SCAN_RATE
#define I2C_DEBUG
#define OS_DETECTION_DEBUG_ENABLE

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Handiness ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //

// The master is one the left side. This means USB can only be plugged in on the
// left one. See:
// https://docs.qmk.fm/features/split_keyboard#handedness-by-define
#define MASTER_LEFT

// Can also be decided dynamically using `SPLIT_USB_DETECT`.
// No longer in use as something better was found
////#define SPLIT_USB_DETECT

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Communication ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //

// The communication protocol between the halves.
// See: https://docs.qmk.fm/features/split_keyboard#communication-options

// Enables the I2C on the microcontroller.
#define USE_I2C

// The pin to use for SDA.
#define I2C_MASTER_SDA D1

// The pin to use for SCL.
#define I2C_MASTER_SCL D0

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ OS Detection ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //

// For detecting the OS
// See: https://docs.qmk.fm/features/os_detection#configuration-options

// Defined the debounce time for OS detection, in milliseconds. Defaults to
// 250ms.
#define OS_DETECTION_DEBOUNCE 250

// Enables the keyboard reset upon a USB device reinitialization.
// This setting may help with detection issues when switching between devices on
// some KVMs.
#define OS_DETECTION_KEYBOARD_RESET

// Allows the report callbacks to be called only once, when the OS detection
// result is considered stable. Subsequent changes in the detection results, if
// any, are ignored. This setting may help with delayed stability issues when
// switching devices on some KVMs.
#define OS_DETECTION_SINGLE_REPORT

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Tap Dance ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //

// For tap dance feature
// See: https://docs.qmk.fm/features/tap_dance

//
#define TAPPING_TERM 175

//
#define TAPPING_TERM_PER_KEY

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Recording Macros ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //

// QMK supports temporary macros created on the fly. We call these Dynamic
// Macros. They are defined by the user from the keyboard and are lost when the
// keyboard is unplugged or otherwise rebooted. See:
// https://docs.qmk.fm/features/dynamic_macros#customization

// Sets the amount of memory that Dynamic Macros can use. This is a limited
// resource, dependent on the controller.
#define DYNAMIC_MACRO_SIZE 128

// Sets the waiting time (ms unit) when sending each key.
#define DYNAMIC_MACRO_DELAY 10

// ~~~~~~~~~~~~~~~~~~~~~~~~~~ Suppressing Modifiers ~~~~~~~~~~~~~~~~~~~~~~~~~ //

// Disables Home row mods while typing for `FLOW_TAP_TERM` milliseconds until
// after you stop typing.
#define FLOW_TAP_TERM 150

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
