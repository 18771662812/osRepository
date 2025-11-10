# entry.S
# 启动代码入口点

.section .text.entry
.global _entry

_entry:
    # 设置所有hart除了hart 0之外都进入等待状态（单核）
    csrr a0, mhartid     # 读取hart id
    bnez a0, park        

    # 设置栈指针
    la sp, _stack_top    # 加载栈顶地址

    # 清零bss段
    la a0, _bss_start    # bss段起始地址
    la a1, _bss_end      # bss段结束地址
    call clear_bss       # 调用清零函数

    # 跳转到C代码
    tail start           # 跳转到start函数

# 其他hart等待
park:
    wfi                  # 进入等待状态
    j park               # 循环等待

# 清零bss段函数
clear_bss:
    bgeu a0, a1, bss_done  # 如果起始地址>=结束地址，完成清零
1:  
    sd zero, (a0)        # 将8字节置0
    addi a0, a0, 8      # 指针加8
    bltu a0, a1, 1b     # 如果未到结束地址，继续循环
bss_done:
    ret                 # 返回
