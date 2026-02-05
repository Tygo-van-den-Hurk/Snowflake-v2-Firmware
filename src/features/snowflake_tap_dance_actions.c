// Copyright (c) 2025 - Tygo van den Hurk
// SPDX-License-Identifier: ELP-2.0

#include "snowflake_tap_dance_actions.h"
#include "snowflake_aliases.h"
#include "snowflake_process_custom_keycodes.h"

/**
 * @brief Sents a really obscure keycode to the host. Namely
 * `GUI+ALT+CTRL+SHIFT+$KEYCODE`. The point is to be so unique that it has no
 * real use in the wild
 *
 * @param keycode the keycode to sent. Will only the last byte for the keycode
 * to sent.
 * @return true allow QMK to process the key event further.
 * @return false tell QMK to not process the key event any further.
 */
bool Snowflake_sent_obscure_keycode(uint16_t keycode) {

  const uint8_t mods = get_mods();

  del_mods(mods);
  register_code(KC_RIGHT_GUI);
  register_code(KC_RIGHT_ALT);
  register_code(KC_RIGHT_CTRL);
  register_code(KC_RIGHT_SHIFT);
  tap_code16(keycode);
  unregister_code(KC_RIGHT_GUI);
  unregister_code(KC_RIGHT_ALT);
  unregister_code(KC_RIGHT_CTRL);
  unregister_code(KC_RIGHT_SHIFT);
  add_mods(mods);

  return CONCLUDE;
}

#define DEFINE_TD_HANDLER(NAME, KC1, KC2)                                      \
  void Snowflake_td_##NAME##_finished(tap_dance_state_t *state,                \
                                      void *user_data) {                       \
    if (state->count == 1)                                                     \
      Snowflake_sent_obscure_keycode(KC1);                                     \
    else if (state->count == 2)                                                \
      Snowflake_sent_obscure_keycode(KC2);                                     \
  }

#define ASSIGN_TD_HANDLER(NAME)                                                \
  [NAME] = ACTION_TAP_DANCE_FN(Snowflake_td_##NAME##_finished)

//` Windows

DEFINE_TD_HANDLER(TD_WIN1, KC_F1, KC_F11);
DEFINE_TD_HANDLER(TD_WIN2, KC_F2, KC_F12);
DEFINE_TD_HANDLER(TD_WIN3, KC_F3, KC_F13);
DEFINE_TD_HANDLER(TD_WIN4, KC_F4, KC_F14);
DEFINE_TD_HANDLER(TD_WIN5, KC_F5, KC_F15);
DEFINE_TD_HANDLER(TD_WIN6, KC_F6, KC_F16);
DEFINE_TD_HANDLER(TD_WIN7, KC_F7, KC_F17);
DEFINE_TD_HANDLER(TD_WIN8, KC_F8, KC_F18);
DEFINE_TD_HANDLER(TD_WIN9, KC_F9, KC_F19);
DEFINE_TD_HANDLER(TD_WIN0, KC_F10, KC_F20);

//` Workspaces

DEFINE_TD_HANDLER(TD_WSP1, KC_1, KC_A);
DEFINE_TD_HANDLER(TD_WSP2, KC_2, KC_B);
DEFINE_TD_HANDLER(TD_WSP3, KC_3, KC_C);
DEFINE_TD_HANDLER(TD_WSP4, KC_4, KC_D);
DEFINE_TD_HANDLER(TD_WSP5, KC_5, KC_E);
DEFINE_TD_HANDLER(TD_WSP6, KC_6, KC_F);
DEFINE_TD_HANDLER(TD_WSP7, KC_7, KC_G);
DEFINE_TD_HANDLER(TD_WSP8, KC_8, KC_H);
DEFINE_TD_HANDLER(TD_WSP9, KC_9, KC_I);
DEFINE_TD_HANDLER(TD_WSP0, KC_0, KC_J);

//` Displays

DEFINE_TD_HANDLER(TD_DIS1, KC_K, KC_U);
DEFINE_TD_HANDLER(TD_DIS2, KC_L, KC_V);
DEFINE_TD_HANDLER(TD_DIS3, KC_M, KC_W);
DEFINE_TD_HANDLER(TD_DIS4, KC_N, KC_X);
DEFINE_TD_HANDLER(TD_DIS5, KC_O, KC_Y);
DEFINE_TD_HANDLER(TD_DIS6, KC_P, KC_Z);
DEFINE_TD_HANDLER(TD_DIS7, KC_Q, KC_F21);
DEFINE_TD_HANDLER(TD_DIS8, KC_R, KC_F22);
DEFINE_TD_HANDLER(TD_DIS9, KC_S, KC_F23);
DEFINE_TD_HANDLER(TD_DIS0, KC_T, KC_F24);

void Snowflake_td_media_finished(tap_dance_state_t *state, void *user_data) {
  if (state->count == 1)
    return tap_code16(KC_MEDIA_PLAY_PAUSE);
  if (state->count == 2)
    return tap_code16(KC_MEDIA_NEXT_TRACK);
  if (state->count == 3)
    return tap_code16(KC_MEDIA_PREV_TRACK);
}

tap_dance_action_t tap_dance_actions[_TD_COUNT] = {

    //` Windows

    ASSIGN_TD_HANDLER(TD_WIN1), ASSIGN_TD_HANDLER(TD_WIN2),
    ASSIGN_TD_HANDLER(TD_WIN3), ASSIGN_TD_HANDLER(TD_WIN4),
    ASSIGN_TD_HANDLER(TD_WIN5), ASSIGN_TD_HANDLER(TD_WIN6),
    ASSIGN_TD_HANDLER(TD_WIN7), ASSIGN_TD_HANDLER(TD_WIN8),
    ASSIGN_TD_HANDLER(TD_WIN9), ASSIGN_TD_HANDLER(TD_WIN0),

    //` Workspaces

    ASSIGN_TD_HANDLER(TD_WSP1), ASSIGN_TD_HANDLER(TD_WSP2),
    ASSIGN_TD_HANDLER(TD_WSP3), ASSIGN_TD_HANDLER(TD_WSP4),
    ASSIGN_TD_HANDLER(TD_WSP5), ASSIGN_TD_HANDLER(TD_WSP6),
    ASSIGN_TD_HANDLER(TD_WSP7), ASSIGN_TD_HANDLER(TD_WSP8),
    ASSIGN_TD_HANDLER(TD_WSP9), ASSIGN_TD_HANDLER(TD_WSP0),

    //` Displays

    ASSIGN_TD_HANDLER(TD_DIS1), ASSIGN_TD_HANDLER(TD_DIS2),
    ASSIGN_TD_HANDLER(TD_DIS3), ASSIGN_TD_HANDLER(TD_DIS4),
    ASSIGN_TD_HANDLER(TD_DIS5), ASSIGN_TD_HANDLER(TD_DIS6),
    ASSIGN_TD_HANDLER(TD_DIS7), ASSIGN_TD_HANDLER(TD_DIS8),
    ASSIGN_TD_HANDLER(TD_DIS9), ASSIGN_TD_HANDLER(TD_DIS0),

    [TD_MEDIA] = ACTION_TAP_DANCE_FN(Snowflake_td_media_finished)};
