#include "kernel.h"
#include "drivers/screen/screen.h"
#include "CPU/descriptor_tables.h"

void kernel_entry(){

  // Initialise all the ISRs and segmentation
  init_descriptor_tables();
  // Initialise the screen (by clearing it)
  monitor_clear();
  // Write out a sample string
  monitor_write("Hello, world!\n");

  asm volatile("int $0x3");
  asm volatile("int $0x4");

}
