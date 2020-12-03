// monitor.h -- Defines the interface for monitor.h
// From JamesM's kernel development tutorials.

#ifndef MONITOR_H
#define MONITOR_H

#include "../../utils/common.h"

void monitor_put(char c);
void monitor_clear();
void monitor_write(char *c);
void monitor_write_hex(u32int n);
void monitor_write_dec(u32int n);

#endif // MONITOR_H