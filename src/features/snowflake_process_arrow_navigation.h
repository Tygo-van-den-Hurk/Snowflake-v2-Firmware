// Copyright (c) 2025 - Tygo van den Hurk
// SPDX-License-Identifier: ELP-2.0

#pragma once

#include QMK_KEYBOARD_H

/**
 * @brief Processes Key combinations with the arrow keys to simulate MacOS arrow
 * navigation. In MacOS arrow navigation is done using modifiers and scale. So
 * the 'greater' the modifier, the 'greater' the movement.
 *
 * An examples of this are:
 * - `CMD + UP` goes to the start of the file.
 * - `CMD + RIGHT` goes to the end of the line.
 * - `CMD + DOWN` goes to the end of the file
 * - `CMD + LEFT` goes to the start of the line.
 * - `CTRL + UP` goes to the previous section.
 * - `CTRL + RIGHT` goes to the end of the next word.
 * - `CTRL + DOWN` goes to the next section
 * - `CTRL + LEFT` goes to the start of the previous word.
 *
 * Windows and Linux can also do this. But they use `END` and `HOME` in
 * combinations with modifiers. This is a little less nice to deal with which is
 * why I am making it so that the keyboard automagically remaps these under the
 * hood without involvement of the OS.
 *
 * @param keycode the keycode that was pressed. This includes modifiers, and
 * other wrappers.
 * @param record the record of the key event.
 * @return true allow QMK to process the key event further.
 * @return false tell QMK to not process the key event any further.
 */
bool Snowflake_process_arrow_navigation(uint16_t keycode, keyrecord_t *record);

// Assumptions on how QMK keys work

#include <assert.h>

_Static_assert(QK_MOD_TAP_GET_MODS(MT(MOD_LCTL, KC_A)) == MOD_LCTL,
               "Assumption of how QMK key works are violated: "
               "QK_MOD_TAP_GET_MODS(MT(MOD_LCTL, KC_A)) == MOD_LCTL");

_Static_assert(QK_MOD_TAP_GET_MODS(LCTL_T(KC_A)) == MOD_LCTL,
               "Assumption of how QMK key works are violated: "
               "QK_MOD_TAP_GET_MODS(LCTL_T(KC_A)) == MOD_LCTL");

_Static_assert(QK_MOD_TAP_GET_TAP_KEYCODE(LCTL_T(KC_A)) == KC_A,
               "Assumption of how QMK key works are violated: "
               "QK_MOD_TAP_GET_TAP_KEYCODE(LCTL_T(KC_A)) == KC_A");
