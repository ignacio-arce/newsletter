---
layout: page
title: Archive
permalink: /archive/
---

{% assign posts_by_year = site.posts | group_by_exp: "post", "post.date | date: '%Y'" %}

<ul class="archive-list">
{% for year_group in posts_by_year %}
  <li>
    <h2 class="archive-year">{{ year_group.name }}</h2>
    {% assign posts_by_month = year_group.items | group_by_exp: "post", "post.date | date: '%B'" %}
    {% for month_group in posts_by_month %}
      <h3 class="archive-month">{{ month_group.name }}</h3>
      {% for post in month_group.items %}
        <div class="archive-item">
          <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%b %d" }}</time>
          <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
        </div>
      {% endfor %}
    {% endfor %}
  </li>
{% else %}
  <li class="empty-state">No posts yet. Stay tuned!</li>
{% endfor %}
</ul>
