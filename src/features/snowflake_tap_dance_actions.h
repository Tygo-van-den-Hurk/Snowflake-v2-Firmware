// Copyright (c) 2025 - Tygo van den Hurk
// SPDX-License-Identifier: ELP-2.0

#pragma once

#include QMK_KEYBOARD_H

/**
 * @brief The possible options that a Tap Dance key have.
 */
enum tap_dance_options_enum {

  TD_WIN1,
  TD_WIN2,
  TD_WIN3,
  TD_WIN4,
  TD_WIN5,
  TD_WIN6,
  TD_WIN7,
  TD_WIN8,
  TD_WIN9,
  TD_WIN0,

  TD_WSP1,
  TD_WSP2,
  TD_WSP3,
  TD_WSP4,
  TD_WSP5,
  TD_WSP6,
  TD_WSP7,
  TD_WSP8,
  TD_WSP9,
  TD_WSP0,

  TD_DIS1,
  TD_DIS2,
  TD_DIS3,
  TD_DIS4,
  TD_DIS5,
  TD_DIS6,
  TD_DIS7,
  TD_DIS8,
  TD_DIS9,
  TD_DIS0,

  TD_MEDIA,

  /**
   * @brief Used to keep track of the amount of enum options since C cannot
   * do this natively.
   */
  _TD_COUNT
};

/**
 * @brief The array of tap dance actions to take.
 */
extern tap_dance_action_t tap_dance_actions[_TD_COUNT];
