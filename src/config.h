// Copyright (c) 2025 - Tygo van den Hurk
// SPDX-License-Identifier: ELP-2.0

#pragma once

// Keyboard firmware version
#define FIRMWARE_VERSION "v0.0.0"
#define KEYMAP_VERSION "unknown"

#define SNOWFLAKE_KEYBOARD_H "features/includes.h"

// Activates the double-tapping of the reset button triggers the bootloader.
#define RP2040_BOOTLOADER_DOUBLE_TAP_RESET 

// Timeout window in ms in which the double tap can occur.
#define RP2040_BOOTLOADER_DOUBLE_TAP_RESET_TIMEOUT 400U

// Specify a optional status led by GPIO number which blinks when entering the bootloader
#define RP2040_BOOTLOADER_DOUBLE_TAP_RESET_LED GP17

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
#define SERIAL_DEBUG
#define I2C_DEBUG
#define OS_DETECTION_DEBUG_ENABLE

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Handiness ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //

// The master is one that is plugged in. We use a pin to differentiate sides.
// - https://docs.qmk.fm/features/split_keyboard#hardware-configuration-options
// - https://docs.qmk.fm/features/split_keyboard#handedness-by-define
//
//
// Enabling this option changes the startup behavior to listen for an active USB
// communication to delegate which part is master and which is slave. With this
// option enabled and active USB communication, then that half assumes it is the
// master, otherwise it assumes it is the slave.
//
// Without this option, the master is the half that can detect voltage on the
// physical USB connection (VBUS detection).
#define SPLIT_USB_DETECT
#define SPLIT_HAND_PIN GP21
//#define	SPLIT_HAND_PIN_LOW_IS_LEFT
#define SPLIT_USB_TIMEOUT_POLL 10

#define SPLIT_WPM_ENABLE
#define SPLIT_OLED_ENABLE
#define SPLIT_ACTIVITY_ENABLE
#define SPLIT_TRANSPORT_MIRROR

#define SPLIT_WATCHDOG_ENABLE

// This set the maximum slave timeout when waiting for communication from master
// when using `SPLIT_WATCHDOG_ENABLE`.
#define SPLIT_WATCHDOG_TIMEOUT 3000

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Communication ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //

// // The communication protocol between the halves, or OLED screen.
// // See: https://docs.qmk.fm/features/split_keyboard#communication-options

// // Enables the I2C on the microcontroller.
// // #define USE_I2C

// // The pin to use for SDA.
// #define I2C_MASTER_SDA D1

// // The pin to use for SCL.
// #define I2C_MASTER_SCL D0

// // https://docs.qmk.fm/platformdev_rp2040#generic-pro-micro-rp2040

#define I2C_DRIVER    I2CD1
#define I2C1_SDA_PIN  GP2
#define I2C1_SCL_PIN  GP3

// #define SPI_DRIVER    SPID0
// #define SPI_SCK_PIN   GP18
// #define SPI_MISO_PIN  GP20
// #define SPI_MOSI_PIN  GP19

// // Force the usage of PIO1 peripheral, by default the Serial implementation uses
// // the PIO0 peripheral: 
// #define SERIAL_PIO_USE_PIO1 


// Enable full duplex operation mode.
#define SERIAL_USART_FULL_DUPLEX
// #define SERIAL_USART_DRIVER SIOD0
#define SERIAL_USART_TX_PIN GP0
#define SERIAL_USART_RX_PIN GP1

// #define SERIAL_USART_TX_PAL_MODE 2
// #define SERIAL_USART_RX_PAL_MODE 2

// // #define UART_DRIVER  UART0
// // #define UART_TX_PIN  GP0
// // #define UART_RX_PIN  GP1

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

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ OLED Display ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //

#define OLED_DRIVER_ENABLE
#define OLED_DISPLAY_ADDRESS 0x3C

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Tap Dance ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //

// For tap dance feature. See: https://docs.qmk.fm/features/tap_dance

#define TAPPING_TERM 175
#define TAPPING_TERM_PER_KEY

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Recording Macros ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //

// QMK supports temporary macros created on the fly. We call these Dynamic
// Macros. They are defined by the user from the keyboard and are lost when the
// keyboard is unplugged or otherwise rebooted. See:
// https://docs.qmk.fm/features/dynamic_macros#customization

// Sets the amount of memory that Dynamic Macros can use. This is a limited
// resource, dependent on the controller.
#define DYNAMIC_MACRO_SIZE 512

// Sets the waiting time (ms unit) when sending each key.
#define DYNAMIC_MACRO_DELAY 1

// ~~~~~~~~~~~~~~~~~~~~~~~~~~ Suppressing Modifiers ~~~~~~~~~~~~~~~~~~~~~~~~~ //

// Disables Home row mods while typing for `FLOW_TAP_TERM` milliseconds until
// after you stop typing.
#define FLOW_TAP_TERM 150

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
