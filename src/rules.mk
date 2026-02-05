
# Split keyboard and communication
SPLIT_KEYBOARD = yes

# I2C communication
I2C = yes
I2C_DRIVER_REQUIRED = yes

# Print debug information
CONSOLE_ENABLE = yes

# For enabling VIA support
VIA_ENABLE = no

# Allows for making keys act as something else when double tapped
TAP_DANCE_ENABLE = yes

# Detecting the OS
# See: https://docs.qmk.fm/features/os_detection#usage
OS_DETECTION_ENABLE = yes

# Allows for switching GUI (CMD) and CTRL in run time useful for automatically adapting to MacOS layouts.
MAGIC_ENABLE = yes

# Allows for entering the boot process etc straight from a key.
BOOTMAGIC_ENABLE = yes

# Enable Dynamic Macros
DYNAMIC_MACRO_ENABLE = yes

# Allows for overriding keys
KEY_OVERRIDE_ENABLE = yes

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ AVR Optimisations ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# AVR required optimisations because of space constraints.
# See: https://docs.qmk.fm/squeezing_avr#squeezing-the-most-out-of-avr

# Link Time Optimisation -> Longer compile time, smaller binary size
LTO_ENABLE = yes

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Extra SRC Files ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# These are the other files that the compiler needs to compile for the keyboard to work.

SRC += features/snowflake_process_detected_host_os_kb.c
SRC += features/snowflake_process_arrow_navigation.c
SRC += features/snowflake_keyboard_post_init_user.c
SRC += features/snowflake_process_custom_keycodes.c
SRC += features/snowflake_process_record_user.c
SRC += features/snowflake_tap_dance_actions.c
SRC += features/snowflake_dynamic_macros.c
SRC += features/snowflake_key_override.c

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
