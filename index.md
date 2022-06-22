---
layout: home
title: 所有通知
---

{% assign notices = site.notices | where: 'status', 'active' %}

<!-- Table of Content -->

{% for notice in notices %}
- [{{ notice.title }}](#{{ notice.title | slugify }}){% if notice.description %}：{{ notice.description }}{% endif %}
{% endfor %}

<!-- Main Content -->

{% for notice in notices %}

## [{{ notice.title }}]({{ notice.url | relative_url }}){% if notice.description %}：{{ notice.description }}{% endif %}
{:id="{{ notice.title | slugify }}"}

{{ notice.content | markdownify }}

{% endfor %}
