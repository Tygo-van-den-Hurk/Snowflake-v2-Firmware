// Copyright (c) 2025 - Tygo van den Hurk
// SPDX-License-Identifier: ELP-2.0

#include "snowflake_keyboard_post_init_user.h"

void keyboard_post_init_user(void) {

  uprintf("Using firmware version: %s\n", FIRMWARE_VERSION);
  
#ifdef DEBUG_ENABLE
  /* print whether this is the master or slave */ {
    if (is_keyboard_master())
      dprintf("This is the master side\n");
    else
      dprintf("This is the slave side\n");
  }
#endif
}
