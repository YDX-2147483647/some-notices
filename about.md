---
title: 关于及文档
layout: default
---

这是“一些通知”的第二个版本，上一版本使用[有道云笔记](https://note.youdao.com/s/UIxMRZUH)。

## `notices`的变量

↓例子。

```yaml
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

- `title`

- `description`

  一句话更新。

- `status`
  
  这则通知当前的状态。

  `'active'|'archived'`。

- `updated_on`

  更新日期。

  `string[]`，日期按 ISO 8601 格式（`YYYY-MM-DD`）。
