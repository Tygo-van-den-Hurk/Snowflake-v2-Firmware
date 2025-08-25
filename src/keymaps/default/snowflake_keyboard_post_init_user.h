// Copyright (c) 2025 - Tygo van den Hurk
// SPDX-License-Identifier: ELP-2.0

#pragma once

#include QMK_KEYBOARD_H

/**
 * @brief function called when the keyboard has been initialised. Mostly used to
 * get the keyboard to spit out version information about the keyboard firmware
 * so I can check if it is up to date.
 */
void keyboard_post_init_user(void);
