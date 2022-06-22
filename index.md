---
layout: home
title: 当前通知
---

<aside class='remark'>
    {% capture all_latest_update_dates_str %}
    {% for notice in site.notices %}
        {{ notice.updated_on | last }}
        {% if forloop.last == false %},{% endif %}
    {% endfor %}
    {% endcapture %}

    {% assign latest_update_date = all_latest_update_dates_str | split: ',' | sort | last | strip %}
    <p>最后更新于<time datetime="{{ latest_update_date }}">{{ latest_update_date | date: "%Y年%m月%d日" }}</time>。</p>
</aside>

{% assign notices = site.notices | where: 'status', 'active' %}

<!-- Table of Content -->

{% for notice in notices %}
- [{{ notice.title }}](#{{ notice.title | slugify }}){% if notice.description %}：{{ notice.description }}{% endif %}
{% endfor %}

<!-- Main Content -->

{% for notice in notices %}

## [{{ notice.title }}]({{ notice.url | relative_url }}){% if notice.description %}：{{ notice.description }}{% endif %}
{:id="{{ notice.title | slugify }}"}

<p>
    <small>最后更新于<time datetime="{{ notice.updated_on | last }}">{{ notice.updated_on | last | date: "%Y年%m月%d日" }}</time>。</small>
</p>

{{ notice.content | markdownify }}

{% endfor %}
