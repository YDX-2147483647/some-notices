---
layout: home
title: 半月内更新过的通知
permalink: /recent/
---

{% assign notices = site.notices | sort_notices | reverse %}

<aside class='remark'>
    {% assign all_latest_notice = notices | first %}
    {% assign all_last_updated_on = all_latest_notice.updated_on | last %}
    <p>“半月内”是指<time datetime="{{ all_last_updated_on }}">{{ all_last_updated_on | date: "%Y年%m月%d日" }}</time>以前的 15 天内。</p>
    {% assign all_latest_notice = nil %}
</aside>

{% for notice in notices %}
{% assign delta = notice.updated_on | last | compare_date %}
{% if delta < -15 %}
    {% break %}
{% endif %}

- [{{ notice.title }}]({{ notice.url | relative_url }}){% if notice.description %}：{{ notice.description }}{% endif %}

  {{ notice.status }}，<time datetime="{{ notice.updated_on | last }}">{{ notice.updated_on | last | date: "%Y年%m月%d日" }}</time>
{% endfor %}
