@echo off
@set PROJ=sdcc4farptr
@set GBDK=..\..\gbdk\
@set GBDKLIB=%GBDK%lib\small\asxxxx\
@set OBJ=build\
@set SRC=src\

@set CFLAGS=-mgbz80 --no-std-crt0 -I %GBDK%include -I %GBDK%include\asm -I src\include -c
@set CFLAGS=%CFLAGS% --max-allocs-per-node 50000

@set LFLAGS=-n -- -z -m -j -k%GBDKLIB%gbz80\ -lgbz80.lib -k%GBDKLIB%gb\ -lgb.lib 
@set LFLAGS=%LFLAGS% -yt1 -yo4 -ya0
@set LFILES=%GBDKLIB%gb\crt0.o

@set ASMFLAGS=-plosgff -I"libc"

@echo Cleanup...

@if exist %OBJ% rd /s/q %OBJ%
@if exist %PROJ%.gb del %PROJ%.gb
@if exist %PROJ%.sym del %PROJ%.sym
@if exist %PROJ%.map del %PROJ%.map

@if not exist %OBJ% mkdir %OBJ%

@echo COMPILING WITH SDCC4...

sdcc %CFLAGS% %SRC%far_ptr.c -o %OBJ%far_ptr.rel
sdcc %CFLAGS% %SRC%sdcc4bank1code.c -o %OBJ%sdcc4bank1code.rel
@set LFILES=%LFILES% %OBJ%far_ptr.rel %OBJ%sdcc4bank1code.rel


sdcc %CFLAGS% %SRC%%PROJ%.c -o %OBJ%%PROJ%.rel

@echo LINKING WITH GBDK...
%GBDK%bin\link-gbz80 %LFLAGS% %PROJ%.gb %LFILES% %OBJ%%PROJ%.rel 

@echo DONE!
