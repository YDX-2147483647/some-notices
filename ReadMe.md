# 一些通知

## 部署

### Prerequisites

- [`just`](https://just.systems/man/en/)

- （可选）`pwsh`（[PowerShell 7](https://github.com/PowerShell/PowerShell/)）。

- （可选）`rsync`

  Seunghyun Chae, [*How to use rsync on Git Bash*](https://shchae7.medium.com/how-to-use-rsync-on-git-bash-6c6bba6a03ca).

  [How do I use spaces in the Command Prompt?](https://stackoverflow.com/a/19860015/17975124), ghbarratt's first answer.

### `.env`

可在`Justfile`旁边新建`.env`文件，设定参数。

```shell
# 远程地址
REMOTE_HOST=SomeNotices  # 可在`~/.ssh/config`中设定`SomeNotices`
REMOTE_PATH="/var/www/html/"

# 虚拟环境中的 python 可执行文件
PYTHON="./.venv/Scripts/python.exe"

# 是否用 scp 替代 rsync
# 不建议设置此项。因为 scp 只会用新文件覆盖旧文件，不会单独删除旧文件。
# 仅当`true`时替代为 scp，其它值或不设置都用 rsync。
USE_SCP=true
```

### Recipes

```shell
just deploy
```

另外可在 VS Code 中运行：<kbd>Ctrl</kbd>+<kbd>P</kbd>，`task Deploy`，或<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>B</kbd>。

### On server

Nginx 配置示例如下。

```properties
server {
    # …
    location /some-notices {
        alias /var/www/html/;
        index index.html;
    }

    error_page 404 /some-notices/404.html;

    # Redirect the root if you need.
    # rewrite ^/$ /some-notices permanent;
}
```

## 通知（`notices`）

↓例子。

```yaml
# 2022-05-digital-ex.md
title: “数字电路”硬件实验
description: 请妥善保存开发板
updated_on:
  - 2022-05-04
  - 2022-05-13
  - 2022-05-16
  - 2022-05-17
  - 2022-05-18
  - 2022-05-23
  - 2022-05-28
status: active
```

### 文件名

```
YYYY-MM-:simple_title
```

### 变量

- `title`

- `description`

  一句话更新。

  可无。

- `status`
  
  这则通知当前的状态。

  `'active'|'archived'`。

- `updated_on`

  更新日期。

  `string[]`，日期按 ISO 8601 格式（`YYYY-MM-DD`）。

- `due`

  截止日期。

  `string | number`，ISO 8601 格式（`YYYY-MM-DD`）日期或最后更新日期后的天数（一般为正数）。

  可无。

- `source`

  信息来源。

  可无。
