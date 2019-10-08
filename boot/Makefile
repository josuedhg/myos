

all: file.img

boot_main.o:
	gcc -m32 -c boot_main.c -o boot_main.o
boot.o:
	gcc -m32 -c  -g boot.S -o boot.o
file.img: boot.o
	ld --oformat binary -m elf_i386 -o file.img -T boot.ld boot.o
run: file.img
	qemu-system-i386 -hda file.img
clean:
	rm boot.o file.img file.elf file.lst
debug: boot.o
	ld -o file.elf -T boot.ld boot.o; objdump -lS file.elf > file.lst

