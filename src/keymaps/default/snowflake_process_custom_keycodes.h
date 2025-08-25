// Copyright (c) 2025 - Tygo van den Hurk
// SPDX-License-Identifier: ELP-2.0

#pragma once

#include QMK_KEYBOARD_H

/**
 * @brief Processes a custom keycode, returning false if the keycode is finished
 * being processed, and true if the keycode needs to be processed further.
 */
bool Snowflake_process_custom_keycodes(uint16_t keycode, keyrecord_t *record);

/**
 * @brief Custom keycodes that are in QMK's `SAFE_RANGE`.
 */
enum Snowflake_custom_keycodes { CUSTOM_KEY_CODES = SAFE_RANGE };
