// Copyright (c) 2025 - Tygo van den Hurk
// SPDX-License-Identifier: ELP-2.0

#pragma once

#include QMK_KEYBOARD_H

/**
 * @brief This overwrites the process that QMK uses to process keys. You can
 * turn keys here into other keys, intercepting them, changing them, or
 * modifying the global state of the program in any way that the standard
 * functions don't allow for. The reason I use it is to catch 6 keys that work
 * differently on Windows/Linux VS MacOS. I prefer the way MacOS handles them
 * thus I rewrite these keys on Windows and Linux as they handle it poorer in my
 * opinion.
 *
 * @param keycode the keycode that was pressed. This includes modifiers, and
 * other wrappers.
 * @param record the record of the key event.
 * @return true allow QMK to process the key event further.
 * @return false tell QMK to not process the key event any further.
 */
bool process_record_user(uint16_t keycode, keyrecord_t *record);
