@ECHO OFF
ECHO Setting AVR tool paths
SET TOOLS_DIR=D:\AVR

SET PATH=%PATH%;%TOOLS_DIR%\avr8-gnu-toolchain\bin
SET PATH=%PATH%;%TOOLS_DIR%\avrdude

cd %CD%\firmware\src
echo Complie file path: %CD%
echo Bulding now.....

avr-gcc -o "oled.o" "oled.c" -Wall -Os -Wno-deprecated-declarations -Wno-strict-aliasing -D__PROG_TYPES_COMPAT__ -D_SDISK_OLED_  -fpack-struct -fshort-enums -std=gnu99 -funsigned-char -funsigned-bitfields -mmcu=atmega328p -DF_CPU=27000000UL -MMD -MP -c 
avr-gcc -o "SPI_routines.o" "SPI_routines.c" -Wall -Os -Wno-deprecated-declarations -Wno-strict-aliasing -D__PROG_TYPES_COMPAT__ -D_SDISK_OLED_  -fpack-struct -fshort-enums -std=gnu99 -funsigned-char -funsigned-bitfields -mmcu=atmega328p -DF_CPU=27000000UL -MMD -MP -c 
avr-gcc -o "SD_routines.o" "SD_routines.c" -Wall -Os -Wno-deprecated-declarations -Wno-strict-aliasing -D__PROG_TYPES_COMPAT__ -D_SDISK_OLED_  -fpack-struct -fshort-enums -std=gnu99 -funsigned-char -funsigned-bitfields -mmcu=atmega328p -DF_CPU=27000000UL -MMD -MP -c 
avr-gcc -o "FAT32.o" "FAT32.c" -Wall -Os -Wno-deprecated-declarations -Wno-strict-aliasing -D__PROG_TYPES_COMPAT__ -D_SDISK_OLED_  -fpack-struct -fshort-enums -std=gnu99 -funsigned-char -funsigned-bitfields -mmcu=atmega328p -DF_CPU=27000000UL -MMD -MP -c 
avr-gcc -x assembler-with-cpp -mmcu=atmega328p -MMD -MP -D_SDISK_OLED_ -c -o "sub.o" "sub.S"
avr-gcc -o "main.o" "main.c" -Wall -Os -Wno-deprecated-declarations -Wno-strict-aliasing -D__PROG_TYPES_COMPAT__ -D_SDISK_OLED_ -fpack-struct -fshort-enums -std=gnu99 -funsigned-char -funsigned-bitfields -mmcu=atmega328p -DF_CPU=27000000UL -MMD -MP -c 
avr-gcc -Wl,-Map,sdisk2_oled.map -mmcu=atmega328p -D_SDISK_OLED_ -o "../out/sdisk2_oled.elf" "main.o" "oled.o" "SPI_routines.o" "SD_routines.o" "FAT32.o" "sub.o"  
avr-objcopy -R .eeprom -O ihex "../out/sdisk2_oled.elf" "../out/sdisk2.hex"
avr-size --format=avr --mcu=atmega328p "sdisk2_oled.elf"

echo Remove object files now.....
REM Remove-Item "*.d", "*.map", "*.o", "*.elf" -Force -ErrorAction "SilentlyContinue"
del *.o
del *.map
del *.d
REM del *.elf

echo Hex files buld success!!!!