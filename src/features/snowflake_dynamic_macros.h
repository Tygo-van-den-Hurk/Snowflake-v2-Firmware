// Copyright (c) 2025 - Tygo van den Hurk
// SPDX-License-Identifier: ELP-2.0

#pragma once

#include QMK_KEYBOARD_H

/**
 * @brief The possible Macro direction options.
 */
enum MacroDirection {
  Macro2 = -1,
  MacroNone = 0,
  Macro1 = 1,
};

/**
 * @brief User hook triggered when you start recording a macro.
 */
bool dynamic_macro_record_start_user(int8_t direction);

/**
 * @brief User hook triggered when you play back a macro.
 */
bool dynamic_macro_play_user(int8_t direction);

/**
 * @brief User hook triggered on each keypress while recording a macro.
 */
bool dynamic_macro_record_key_user(int8_t direction, keyrecord_t *record);

/**
 * @brief User hook triggered on each keypress while recording a macro.
 */
bool dynamic_macro_record_end_user(int8_t direction);
