# Implementation Plan: Bananews Newsletter

## Overview

A Jekyll-based newsletter site hosted on GitHub Pages for publishing short tech/news summaries with source links. The editor writes posts manually as Markdown files in `_posts/`. Site auto-builds on push via GitHub Pages.

**URL:** `https://ignacio-arce.github.io/bananews/`

## Architecture Decisions

| Decision | Choice | Rationale |
|---|---|---|
| **Hosting** | GitHub Pages | Free, auto Jekyll build, zero ops |
| **Generator** | Jekyll (native to GH Pages) | No build config, Markdown-native |
| **Design** | Custom-built on bare Jekyll | Full control over "modern & bold" aesthetic |
| **CSS** | Single `style.css` with custom properties | Banana colors centralized in one file |
| **Logo** | Inline SVG text logo | No external assets, scales perfectly |
| **SEO** | `jekyll-seo-tag` + `jekyll-sitemap` | GH Pages compatible, zero config |
| **RSS** | `jekyll-feed` | Auto-generates Atom feed |
| **Sources** | Dedicated "Sources" list at bottom of each post | Clean separation from content |

## Nix Shell

A `shell.nix` is provided at the project root. Enter it with `nix-shell` before any Jekyll work.

```bash
nix-shell
bundle install
bundle exec jekyll serve --livereload
```

Gems are installed locally to `.gems/` (add to `.gitignore` in Task 1).

## Directory Structure

```
bananews/
├── _config.yml
├── Gemfile
├── .gitignore
├── index.html               # Homepage (latest posts)
├── archive.md               # Archive by month
├── about.md                 # About page
├── 404.html
├── _posts/
│   └── YYYY-MM-DD-title.md
├── _layouts/
│   ├── default.html
│   ├── home.html
│   └── post.html
├── _includes/
│   ├── head.html
│   ├── header.html
│   └── footer.html
├── assets/
│   ├── css/
│   │   └── style.css        # All styles (banana palette via :root vars)
│   └── images/
│       └── favicon.ico
└── _site/                   # Build output (gitignored)
```

## Post Template

```yaml
---
layout: post
title: "Short news headline"
date: 2026-06-15 09:00:00 -0400
tags: [tech, AI]
sources:
  - title: "Source Publication"
    url: "https://example.com/article"
  - title: "Another Source"
    url: "https://other.com/article"
---

Brief 2-3 sentence summary of the news item.
```

## Task List

### Phase 1: Foundation

**Task 1: Initialize Jekyll project and GitHub repo**

- Scaffold the Jekyll site, configure Gemfile, `_config.yml`, `.gitignore`
- Push to GitHub, enable GH Pages (branch: `main`, folder: `/`)
- Acceptance criteria:
  - `bundle exec jekyll serve` produces working site at `localhost:4000`
  - `_config.yml` has `title: "Bananews"`, `description`, `url: https://ignacio-arce.github.io`, `baseurl: /bananews`
  - Gemfile includes `github-pages` gem + plugins
  - Site goes live at `ignacio-arce.github.io/bananews` after push
- Dependencies: None
- Files: `_config.yml`, `Gemfile`, `.gitignore`, `index.html`

**Task 2: Configure SEO, RSS, and sitemap**

- Add `jekyll-seo-tag`, `jekyll-feed`, `jekyll-sitemap` to Gemfile and `_config.yml`
- Wire `{% seo %}` into `<head>`, `{% feed_meta %}` for RSS
- Acceptance criteria:
  - `_site/feed.xml` and `_site/sitemap.xml` generated on build
  - Each page has proper `<meta>` tags (title, description, OG)
- Dependencies: Task 1
- Files: `_config.yml`, `Gemfile`, `_includes/head.html`

---

### Phase 2: Core Layout & Design

**Task 3: Build base layout + banana-themed CSS**

- Create `default.html`, `header.html`, `footer.html`, and single `style.css`
- Banana color palette via `:root` CSS custom properties in `style.css`:
  - Primary yellow: `#F5E61D` or `#FFD700`
  - Dark charcoal: `#1a1a2e` or `#2D2D2D`
  - Accent green: `#2ecc71` (banana stem)
  - Background: off-white `#FFFDF5`
- Responsive, modern typography (Inter or system font stack)
- Inline SVG text logo "Bananews" in header
- Acceptance criteria:
  - Layout wraps all pages (header + main + footer)
  - Works on mobile (375px) through desktop (1440px)
  - Nav: Home, Archive, About
  - Footer: copyright, RSS link, GitHub link
- Dependencies: Task 1
- Files: `assets/css/style.css`, `_layouts/default.html`, `_includes/head.html`, `_includes/header.html`, `_includes/footer.html`

**Task 4: Build homepage (post card grid)**

- `index.html` uses `home.html` layout rendering latest 10 posts
- Responsive card grid: 1 column mobile, 2 columns desktop
- Each card: date, title, auto-excerpt (~150 chars), first source as "Read more" badge
- Pagination: "Older Posts" / "Newer Posts"
- Empty state: "No posts yet"
- Acceptance criteria:
  - Cards render correctly with 3 test posts
  - Sources appear as styled badges
  - Pagination works when > 10 posts exist
- Dependencies: Task 3
- Files: `index.html`, `_layouts/home.html`

**Task 5: Build single post page**

- `post.html` layout: title (`<h1>`), date, tags as links, full content, sources list, prev/next navigation
- Sources rendered as a styled `<ul>` with `target="_blank"` links
- SEO meta populated from front matter
- Acceptance criteria:
  - Post with multiple sources renders correctly
  - Tags link to tag filter pages
  - Prev/next navigation links to adjacent posts
- Dependencies: Task 3
- Files: `_layouts/post.html`

---

### Phase 3: Content Features

**Task 6: Build archive page**

- `archive.md` groups posts by month/year chronologically
- Compact list: date + title per item
- Empty state: "No posts yet"
- Acceptance criteria:
  - Posts across multiple months grouped correctly under month headings
- Dependencies: Task 4
- Files: `archive.md`

**Task 7: Build tags system**

- Tag index at `/tags/` listing all tags with post counts
- Per-tag pages at `/tags/<tag>/` listing matching posts
- Acceptance criteria:
  - Clicking a tag on a post navigates to filtered view
  - Tag index shows all tags with counts
- Dependencies: Task 5
- Files: `tags.md`, `_layouts/tag-page.html`, `_layouts/tags-index.html`, `_config.yml` (tag config)

**Task 8: Build About and 404 pages**

- `about.md` with newsletter description
- `404.html` with on-brand design and link back to homepage
- Acceptance criteria:
  - `/about/` renders markdown content
  - 404 page looks intentional, not a default
- Dependencies: Task 3
- Files: `about.md`, `404.html`

---

### Phase 4: Polish & Launch

**Task 9: Accessibility and performance audit**

- Semantic HTML (`<main>`, `<nav>`, `<article>`, `<time>`)
- Skip-to-content link, proper `lang` attribute, viewport meta
- All images have `alt` text
- Acceptance criteria:
  - Lighthouse ≥ 90 on all axes (desktop)
  - Keyboard-navigable
- Dependencies: Tasks 3–8
- Files: `assets/css/style.css`, `_layouts/default.html`

**Task 10: Final build and GH Pages deployment**

- `bundle exec jekyll build` succeeds with zero warnings
- Verify live site at `ignacio-arce.github.io/bananews`
- Check all internal links, RSS, sitemap are reachable
- Acceptance criteria:
  - Build is clean (no errors/warnings)
  - Live site renders all pages correctly
  - RSS feed and sitemap return 200
- Dependencies: All prior tasks
- Files: N/A (verification only)

---

### Checkpoints

**Checkpoint A (after Task 2):** Jekyll builds, plugins work — green light for design work.
**Checkpoint B (after Task 5):** Core reading experience done — review design with human.
**Checkpoint C (after Task 10):** Site live, everything verified.

## Risks and Mitigations

| Risk | Impact | Mitigation |
|---|---|---|
| GH Pages plugin version lag | Medium | Pin `github-pages` gem; test locally first |
| Custom design doesn't feel "modern & bold" | Medium | Checkpoint B for early design review |
| GH Pages deprecating Jekyll | Low | Static output is portable |

## Dependencies Graph

```
Task 1 (scaffold)
   │
   ├── Task 2 (SEO/plugins)
   │
   ├── Task 3 (layout + CSS)
   │     │
   │     ├── Task 4 (homepage) ── Task 6 (archive)
   │     │
   │     ├── Task 5 (post page) ── Task 7 (tags)
   │     │
   │     └── Task 8 (about/404)
   │
   └── Task 9 (a11y/perf) ── Task 10 (deploy)
```
