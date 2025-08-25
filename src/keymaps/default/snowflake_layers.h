// Copyright (c) 2025 - Tygo van den Hurk
// SPDX-License-Identifier: ELP-2.0

#pragma once

/**
 * @brief The layers that this keyboard has. For example a number layer for
 * numbers, a bracket layer for brackets etc. etc. Used to access indexes in the
 * keymaps variable.
 */
enum SNOWFLAKE_LAYERS {
  SNOWFLAKE_LAYER_COLMAK = 0,
  SNOWFLAKE_LAYER_NUMBERS,
  SNOWFLAKE_LAYER_BRACKETS,
  SNOWFLAKE_LAYER_NAVIGATION,
  SNOWFLAKE_LAYER_ARROWS,
  SNOWFLAKE_LAYER_MISCELLANEOUS
};
