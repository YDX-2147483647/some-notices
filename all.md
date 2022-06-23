---
layout: home
title: 所有通知
permalink: /all/
---

{% assign notices = site.notices | sort_notices | reverse %}

{% for notice in notices %}
- [{{ notice.title }}]({{ notice.url | relative_url }}){% if notice.description %}：{{ notice.description }}{% endif %}

  {{ notice.status }}，<time datetime="{{ notice.updated_on | last }}">{{ notice.updated_on | last | date: "%Y年%m月%d日" }}</time>

{% endfor %}
