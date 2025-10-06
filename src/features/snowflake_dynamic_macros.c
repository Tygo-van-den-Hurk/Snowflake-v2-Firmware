// Copyright (c) 2025 - Tygo van den Hurk
// SPDX-License-Identifier: ELP-2.0

#include "snowflake_dynamic_macros.h"
#include "snowflake_aliases.h"

bool dynamic_macro_record_start_user(int8_t direction) {
#ifdef DEBUG_ENABLE
  if (direction != MacroNone)
    uprintf("Starting recording of Macro %u.\n", direction == Macro1 ? 1 : 2);
#endif
  return CONTINUE;
}

bool dynamic_macro_play_user(int8_t direction) {
#ifdef DEBUG_ENABLE
  if (direction != MacroNone)
    uprintf("Playing recording of Macro %u.\n", direction == Macro1 ? 1 : 2);
#endif
  return CONTINUE;
}

bool dynamic_macro_record_key_user(int8_t direction, keyrecord_t *record) {
  return CONTINUE;
}

bool dynamic_macro_record_end_user(int8_t direction) {
#ifdef DEBUG_ENABLE
  if (direction != MacroNone)
    uprintf("Finishing recording of Macro %u.\n", direction == Macro1 ? 1 : 2);
#endif
  return CONTINUE;
}
