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

    {% assign all_last_updated_on = all_latest_update_dates_str | split: ',' | sort | last | strip %}
    <p>最后更新于<time datetime="{{ all_last_updated_on }}">{{ all_last_updated_on | date: "%Y年%m月%d日" }}</time>。</p>
</aside>

{% assign notices = site.notices | where: 'status', 'active' %}

<!-- Table of Content -->

{% for notice in notices %}
{% assign last_updated_on = notice.updated_on | last %}
{% assign delta = last_updated_on | compare_date: all_last_updated_on %}
{% capture row_heading %}
    [{{ notice.title }}](#{{ notice.title | slugify }}){% if notice.description %}：{{ notice.description }}{% endif %}
{% endcapture %}
{% assign row_heading = row_heading | strip %}
{% capture row_time %}
<time datetime="{{ last_updated_on }}">{{ last_updated_on | date: "%Y年%m月%d日" }}</time>
{% endcapture %}
{% assign row_time = row_time | strip %}

{% if delta > -7 %}
- {{ row_heading }}——**<u>{{ row_time }}</u>**
{% else %}
- {{ row_heading }}——{{ row_time }}
{% endif %}

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
