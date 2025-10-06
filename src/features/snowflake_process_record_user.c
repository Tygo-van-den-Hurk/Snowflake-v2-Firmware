// Copyright (c) 2025 - Tygo van den Hurk
// SPDX-License-Identifier: ELP-2.0

#include "snowflake_process_record_user.h"
#include "snowflake_aliases.h"
#include "snowflake_process_arrow_navigation.h"
#include "snowflake_process_custom_keycodes.h"

bool process_record_user(uint16_t keycode, keyrecord_t *record) {

  if (Snowflake_process_custom_keycodes(keycode, record) != CONTINUE)
    return CONCLUDE;

  if (Snowflake_process_arrow_navigation(keycode, record) != CONTINUE)
    return CONCLUDE;

  return CONTINUE;
}
