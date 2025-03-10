---
layout: page
title: Projects
icon: fas fa-toolbox
order: 4
---

<ul>
  {% for project in site.projects %}
    <li>
      <a href="{{ project.url }}">{{ project.title }}</a>
      <p>{{ project.description }}</p>
    </li>
  {% endfor %}
</ul>