all: pra2.asm
	dosbox -c 'ml vacas\pra2\pra2.asm' -c 'pra2.exe'

debug: pra2.asm
	dosbox -c 'ml vacas\pra2\pra2.asm' -c 'debug pra2.exe'