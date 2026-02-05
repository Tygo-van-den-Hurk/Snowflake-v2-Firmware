// Copyright (c) 2025 - Tygo van den Hurk
// SPDX-License-Identifier: ELP-2.0

#include "snowflake_process_custom_keycodes.h"
#include "snowflake_aliases.h"

/**
 * @brief This function deals with custom keycodes I created.
 *
 * @param keycode the keycode to sent. Will only the last byte for the keycode
 * to sent.
 * @param record the record of the key event.
 * @return true allow QMK to process the key event further.
 * @return false tell QMK to not process the key event any further.
 */
bool Snowflake_process_custom_keycodes(uint16_t keycode, keyrecord_t *record) {

  if (keycode < SAFE_RANGE)
    return CONTINUE;

  if (!record->event.pressed)
    return CONTINUE;

  return CONTINUE;
}
