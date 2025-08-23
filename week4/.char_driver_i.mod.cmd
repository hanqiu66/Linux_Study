savedcmd_char_driver_i.mod := printf '%s\n'   char_driver_i.o | awk '!x[$$0]++ { print("./"$$0) }' > char_driver_i.mod
