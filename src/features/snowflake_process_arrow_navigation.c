// Copyright (c) 2025 - Tygo van den Hurk
// SPDX-License-Identifier: ELP-2.0

#include "snowflake_aliases.h"
#include "snowflake_process_detected_host_os_kb.h"

bool Snowflake_process_arrow_navigation(uint16_t keycode, keyrecord_t *record) {

  if (!record->event.pressed)
    return CONTINUE;

  if (host == OS_MACOS || host == OS_IOS)
    return CONTINUE;

  const uint8_t mods = get_mods();

  /* Remap the backspace key to behave like MacOS backspace keys */ {
    if (QK_MOD_TAP_GET_TAP_KEYCODE(keycode) == KC_BACKSPACE) {

      if (mods & CTRL) {
        del_mods(mods);
        register_code(KC_LEFT_SHIFT);
        tap_code(KC_HOME);
        unregister_code(KC_LEFT_SHIFT);
        tap_code(KC_BACKSPACE);
        add_mods(mods);
        return CONCLUDE;
      }

      if (mods & ALT) {
        del_mods(mods);
        register_code(KC_LEFT_CTRL);
        tap_code(KC_BACKSPACE);
        unregister_code(KC_LEFT_CTRL);
        add_mods(mods);
        return CONCLUDE;
      }

      return CONTINUE;
    }
  }

  /* Remap the delete key to behave like MacOS delete keys */ {
    if (QK_MOD_TAP_GET_TAP_KEYCODE(keycode) == KC_DELETE) {

      if (mods & CTRL) {
        del_mods(mods);
        register_code(KC_LEFT_SHIFT);
        tap_code(KC_END);
        unregister_code(KC_LEFT_SHIFT);
        tap_code(KC_DELETE);
        add_mods(mods);
        return CONCLUDE;
      }

      if (mods & ALT) {
        del_mods(mods);
        register_code(KC_LEFT_CTRL);
        tap_code(KC_DELETE);
        unregister_code(KC_LEFT_CTRL);
        add_mods(mods);
        return CONCLUDE;
      }

      return CONTINUE;
    }
  }

  /* Remap the up arrow keys to behave like MacOS up arrow keys */ {
    if (QK_MOD_TAP_GET_TAP_KEYCODE(keycode) == KC_UP) {

      if (mods & CTRL) {
        del_mods(CTRL);
        register_code(KC_LEFT_CTRL);
        tap_code(KC_HOME);
        unregister_code(KC_LEFT_CTRL);
        add_mods(mods);
        return CONCLUDE;
      }

      if (mods & ALT) {
        del_mods(ALT);
        register_code(KC_LEFT_CTRL);
        tap_code(KC_UP);
        unregister_code(KC_LEFT_CTRL);
        add_mods(mods);
        return CONCLUDE;
      }

      return CONTINUE;
    }
  }

  /* Remap the right arrow keys to behave like MacOS right arrow keys */ {
    if (QK_MOD_TAP_GET_TAP_KEYCODE(keycode) == KC_RIGHT) {

      if (mods & CTRL) {
        del_mods(CTRL);
        tap_code(KC_END);
        add_mods(mods);
        return CONCLUDE;
      }

      if (mods & ALT) {
        del_mods(ALT);
        register_code(KC_LEFT_CTRL);
        tap_code(KC_RIGHT);
        unregister_code(KC_LEFT_CTRL);
        add_mods(mods);
        return CONCLUDE;
      }

      return CONTINUE;
    }
  }

  /* Remap the down arrow keys to behave like MacOS down arrow keys */ {
    if (QK_MOD_TAP_GET_TAP_KEYCODE(keycode) == KC_DOWN) {

      if (mods & CTRL) {
        register_code(KC_LEFT_CTRL);
        tap_code(KC_END);
        unregister_code(KC_LEFT_CTRL);
        add_mods(mods);
        return CONCLUDE;
      }

      if (mods & ALT) {
        del_mods(ALT);
        register_code(KC_LEFT_CTRL);
        tap_code(KC_DOWN);
        unregister_code(KC_LEFT_CTRL);
        add_mods(mods);
        return CONCLUDE;
      }

      return CONTINUE;
    }
  }

  /* Remap the left arrow keys to behave like MacOS left arrow keys */ {
    if (QK_MOD_TAP_GET_TAP_KEYCODE(keycode) == KC_LEFT) {

      if (mods & CTRL) {
        del_mods(CTRL);
        tap_code(KC_HOME);
        add_mods(mods);
        return CONCLUDE;
      }

      if (mods & ALT) {
        del_mods(ALT);
        register_code(KC_LEFT_CTRL);
        tap_code(KC_LEFT);
        unregister_code(KC_LEFT_CTRL);
        add_mods(mods);
        return CONCLUDE;
      }

      return CONTINUE;
    }
  }

  return CONTINUE;
}
