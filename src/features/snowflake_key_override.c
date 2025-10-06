// Copyright (c) 2025 - Tygo van den Hurk
// SPDX-License-Identifier: ELP-2.0

#include "snowflake_key_override.h"
#include "snowflake_aliases.h"

/**
 * @brief Key overrides allow you to override modifier-key combinations to send
 * a different modifier-key combination or perform completely custom actions.
 * Don't want `shift + 1` to type `!` on your computer? Use a key override to
 * make your keyboard type something different when you press `shift + 1`. The
 * general behavior is like this: If `modifiers w + key x` are pressed, replace
 * these keys with `modifiers y + key z` in the keyboard report.
 */
const key_override_t *key_overrides[AMOUNT_OF_OVERRIDES] = {

};
