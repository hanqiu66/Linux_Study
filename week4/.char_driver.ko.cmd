savedcmd_char_driver.ko := arm-linux-gnueabihf-ld -r  -EL -z noexecstack   --build-id=sha1  -T /home/uuu/linux/scripts/module.lds -o char_driver.ko char_driver.o char_driver.mod.o .module-common.o
