---
layout: home
title: 所有通知
---

{% assign notices = site.notices %}

{% for notice in notices %}
- [{{ notice.title }}]({{ notice.url | relative_url }}){% if notice.description %}：{{ notice.description }}{% endif %}（{{ notice.status }}）
{% endfor %}
