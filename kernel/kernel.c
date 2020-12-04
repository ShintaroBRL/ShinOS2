#include "kernel.h"
#include "drivers/screen/screen.h"
#include "CPU/descriptor_tables.h"
#include "CPU/timer.h"
#include "CPU/paging.h"

void kernel_entry(){

  // Initialise all the ISRs and segmentation
  init_descriptor_tables();
  // Initialise the screen (by clearing it)
  monitor_clear();
  // Write out a sample string
  initialise_paging();
  monitor_write("Hello, world!\n");

  u32int *ptr = (u32int*)0xA0000000;
  u32int do_page_fault = *ptr;

  UNUSED(do_page_fault);

}
