#assemble boot.s file
as --32 boot/boot.s -o build/boot.o
nasm -felf kernel/CPU/gdt.s -o build/gdt.o
nasm -felf kernel/CPU/interrupt.s -o build/interrupt.o

#compile kernel.c file
gcc -m32 -c kernel/kernel.c -o build/kernel.o -std=gnu99 -ffreestanding -O1 -Wall -Wextra
gcc -m32 -c kernel/utils/common.c -o build/common.o -std=gnu99 -ffreestanding -O1 -Wall -Wextra
#gcc -m32 -c kernel/drivers/keyboard/char.c -o build/char.o -std=gnu99 -ffreestanding -O1 -Wall -Wextra
gcc -m32 -c kernel/drivers/screen/screen.c -o build/screen.o -std=gnu99 -ffreestanding -O1 -Wall -Wextra
gcc -m32 -c kernel/CPU/descriptor_tables.c -o build/descriptor_tables.o -std=gnu99 -ffreestanding -O1 -Wall -Wextra
gcc -m32 -c kernel/CPU/isr.c -o build/isr.o -std=gnu99 -ffreestanding -O1 -Wall -Wextra
gcc -m32 -c kernel/CPU/timer.c -o build/timer.o -std=gnu99 -ffreestanding -O1 -Wall -Wextra
gcc -m32 -c kernel/CPU/kheap.c -o build/kheap.o -std=gnu99 -ffreestanding -O1 -Wall -Wextra
gcc -m32 -c kernel/CPU/paging.c -o build/paging.o -std=gnu99 -ffreestanding -O1 -Wall -Wextra
#gcc -m32 -c kernel/drivers/keyboard/keyboard.c -o build/keyboard.o -std=gnu99 -ffreestanding -O1 -Wall -Wextra
#gcc -m32 -c kernel/drivers/ports/ports.c -o build/ports.o -std=gnu99 -ffreestanding -O1 -Wall -Wextra

#linking the kernel with kernel.o and boot.o files
ld -m elf_i386 -T boot/linker.ld build/*.o -o ShinOS.bin -nostdlib

#check MyOS.bin file is x86 multiboot file or not
grub-file --is-x86-multiboot ShinOS.bin

#building the iso file
mkdir -p isodir/boot/grub
cp ShinOS.bin isodir/boot/ShinOS.bin
cp boot/grub.cfg isodir/boot/grub/grub.cfg
grub-mkrescue -o ShinOS.iso isodir

#run it in qemu
qemu-system-x86_64 -d guest_errors,int -cdrom ShinOS.iso
