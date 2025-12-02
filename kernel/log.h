#ifndef LOG_H
#define LOG_H

#include "types.h"
#include "bio.h"

void log_init(uint dev);
void begin_op(void);
void end_op(void);
void log_write(struct buf *b);
void log_recover(void);

#endif // LOG_H
