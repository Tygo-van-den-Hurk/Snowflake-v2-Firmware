// Copyright (c) 2025 - Tygo van den Hurk
// SPDX-License-Identifier: ELP-2.0

#pragma once

#include QMK_KEYBOARD_H

/**
 * @brief is called when QMK has made a guess on what OS is behind the USB
 * controller. I use it to change the global state of the keyboard. Assigning
 * the `host` global variable the true host. I use this in key remapping as I
 * don't want some keys to be remapped on some OSes.
 *
 * @param os the OS that QMK thinks is currently connected behind the USB
 * controller.
 * @return true allow QMK to process further.
 * @return false tell QMK to not process any further.
 */
bool process_detected_host_os_kb(os_variant_t os);

/**
 * @brief This is what QMK thinks is the host connected to the computer. Starts
 * off as `OS_UNKNOWN` and is changed when the OS has been detected to the OS
 * that was detected.
 */
extern os_variant_t host;
