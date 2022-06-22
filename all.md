---
layout: home
title: 所有通知
---

{% assign notices = site.notices %}

{% for notice in notices %}
- （{{ notice.status }}）[{{ notice.title }}]({{ notice.url | relative_url }}){% if notice.description %}：{{ notice.description }}{% endif %}——<time datetime="{{ notice.updated_on | last }}">{{ notice.updated_on | last | date: "%Y年%m月%d日" }}</time>
{% endfor %}