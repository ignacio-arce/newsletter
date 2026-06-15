---
layout: page
title: Tags
permalink: /tags/
---

<div class="tag-index">
  {% assign sorted_tags = site.tags | sort: "title" %}
  {% for tag in sorted_tags %}
    {% assign post_count = site.posts | where_exp: "post", "post.tags contains tag.title" | size %}
    <a href="{{ tag.url | relative_url }}">
      {{ tag.title }}
      <span class="tag-count">{{ post_count }}</span>
    </a>
  {% endfor %}
</div>
