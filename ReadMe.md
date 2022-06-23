# 一些通知

## 部署

> 要求`~/.ssh/config`中已配置好`SomeNotices`。

<kbd>Ctrl</kbd>+<kbd>P</kbd>，`task Deploy`。

`SomeNotices:/etc/nginx/conf.d/some-notices.conf`如下。

```properties
server {
  listen 80;
  server_name 139.224.63.88;
  access_log logs/access.log;
  error_log logs/error.log error;
  
  location /some-notices {
    alias /var/www/html/;
    index index.html;
  }

  error_page 404 /some-notices/404.html;

  rewrite ^/$ /some-notices permanent;
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
YYYY-DD-:simple_title
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