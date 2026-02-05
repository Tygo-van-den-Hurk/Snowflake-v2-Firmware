// Copyright (c) 2025 - Tygo van den Hurk
// SPDX-License-Identifier: ELP-2.0

#include "snowflake_process_detected_host_os_kb.h"
#include "quantum/process_keycode/process_magic.h"
#include "snowflake_aliases.h"

os_variant_t host = OS_UNSURE;

bool process_detected_host_os_kb(os_variant_t os) {

  if (!process_detected_host_os_user(os))
    return CONCLUDE;

#ifdef OS_DETECTION_DEBUG_ENABLE
  switch (os) {
  case OS_MACOS:
    uprintf("I think the OS is MacOS\n");
    break;
  case OS_IOS:
    uprintf("I think the OS is iOS\n");
    break;
  case OS_WINDOWS:
    uprintf("I think the OS is Windows\n");
    break;
  case OS_LINUX:
    uprintf("I think the OS is Linux\n");
    break;
  case OS_UNSURE:
    uprintf("I am unsure which OS this is.\n");
    break;
  default:
    uprintf("I know which OS this is, but there is no case for it.\n");
    break;
  }
#endif

  host = os;

  static keyrecord_t record = {
      .event =
          {
              .pressed = true,
          },
  };

#ifdef OS_DETECTION_DEBUG_ENABLE
  if (os == OS_MACOS || os == OS_IOS)
    uprintf("Swapping CTRL and GUI.\n");
  else
    uprintf("Unswaping CTRL and GUI.\n");
#endif

  if (os == OS_MACOS || os == OS_IOS)
    process_magic(QK_MAGIC_SWAP_CTL_GUI, &record);
  else
    process_magic(QK_MAGIC_UNSWAP_CTL_GUI, &record);

  return CONTINUE;
}
