// Copyright (c) 2025 - Tygo van den Hurk
// SPDX-License-Identifier: ELP-2.0

#include "snowflake_keyboard_post_init_user.h"

void keyboard_post_init_user(void) {

  /* Sent the version */ {
    char buffer[64];
    snprintf(buffer, sizeof(buffer), "Using firmware version: %s\n",
             FIRMWARE_VERSION);
    send_string(buffer);
  }

#ifdef DEBUG_ENABLE
  /* print whether this is the master or slave */ {
    if (is_keyboard_master())
      uprintf("This is the master side\n");
    else
      uprintf("This is the slave side\n");
  }
#endif
}
