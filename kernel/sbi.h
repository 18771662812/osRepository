// 简单的 SBI 时间接口头文件
#ifndef _SBI_H
#define _SBI_H

#include "types.h"

// 使用 SBI TIME extension 设定下一次定时器中断，stime_value 为目标时间（mtime 单位）
void sbi_set_timer(uint64_t stime_value);

// 读取当前时间（mtime），返回 uint64_t
uint64_t get_time(void);

#endif /* _SBI_H */
