# RISC-V OS Project

## 用户态系统调用接口

- `user/usys.pl` 根据 `kernel/syscall.h` 中的系统调用号生成 `user/usys.S`，为每个调用提供装配封装。
- 当新增系统调用时，更新脚本列表并重新运行 `user/usys.pl > user/usys.S` 即可。
- `user/user.h` 暴露了这些封装的函数声明，未来用户态程序只需 `#include "user/user.h"` 即可使用。
