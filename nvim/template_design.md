-----

# Zettelkasten Template Design & Reference

**Version:** 1.0
**Status:** Final
**Author:** Gemini
**Date:** 2025-09-22

This document specifies the design, structure, and content for all note templates within the Telekasten vault.

-----

## Template System Design Document

### 1\. Overview & Philosophy

The template system is guided by three core principles:

  * **Composition over Configuration**: A universal base template (`zettel.md`) defines the core elements of every note. All other templates are composed by adding specialized, task-oriented sections to this base.
  * **Automation-First Syntax**: All templates are designed for reliable machine parsing. This is achieved through strict adherence to YAML frontmatter, standard Markdown task syntax, and consistent, uniquely identifiable headings.
  * **Hierarchical Review Cycle**: The periodic notes (daily, weekly, quarterly) are designed as an integrated system for goal accomplishment, cascading from high-level strategic planning down to daily execution.

### 2\. Frontmatter Specification (YAML)

All documents **must** begin with a YAML frontmatter block enclosed by `---`.

  * **Syntax**: Standard YAML key-value pairs. Lists can be defined using hyphens.
  * **Core Fields (Required)**:
      * `title`: (String) The human-readable title of the note.
      * `tags`: (List of Strings) Keywords for categorization and search.
  * **Standard Fields (Optional)**:
      * `aliases`: (List of Strings) Alternative names for linking.
      * `status`: (String) The note's lifecycle stage (e.g., `seed`, `evergreen`, `log`, `project-hub`).

#### Example:

```yaml
---
title: "The Title of Your Note"
tags:
  - knowledge-management
  - neovim
aliases:
  - nvim-notes
status: "evergreen"
---
```

### 3\. Automation Hooks

To facilitate scripting, the following elements are designated as stable, parsable hooks:

| Hook                  | Syntax / Identifier         | Purpose                                             |
| --------------------- | --------------------------- | --------------------------------------------------- |
| **Frontmatter** | `---` block at start of file | Extracting all metadata (tags, status, etc.).        |
| **Summary** | `> A one-sentence summary...` | Generating note previews or abstracts.              |
| **Tasks** | `- [ ] Task description`    | Aggregating open tasks into a global "To-Do" list.   |
| **Idea Seeds** | `## 🌱 Seeds`                 | Aggregating raw ideas for the weekly review process. |
| **Outgoing Links** | `## ▲ Links`                  | Parsing explicit dependencies and references.       |
| **Incoming Links** | `## ▼ Backlinks`              | A stable location for a script to write backlinks.   |

### 4\. Template Specifications

  * **`zettel.md` (Universal Base)**: The objective is to capture a single, atomic unit of information. It consists of the core YAML frontmatter, a summary blockquote, the main content area, and the standard link sections.
  * **`daily.md`**: The objective is to facilitate daily execution and frictionless capture. It adds sections for a `Daily Objective`, a parsable `Tasks` list, a timestamped `Log`, and an idea `Seeds` inbox.
  * **`weekly.md`**: The objective is to review past performance and plan the upcoming week. It adds sections for reviewing last week's `Wins` and `Challenges`, and planning this week's `Key Objectives`.
  * **`quarterly.md`**: The objective is to perform high-level, strategic review and planning. It adds sections to review `Progress on Strategic Goals` and plan the next quarter's `Main Theme` and `Strategic Goals`.

-----

## Template Reference Files

### `zettel.md`

```markdown
---
title: "<% title %>"
tags:
  - 
aliases:
  - 
status: "seed"
---

# <% title %>

> A one-sentence summary of the note's core idea.

---

(Your main content here. Written in your own words to ensure understanding.)

---
## ▲ Links
- 

## ▼ Backlinks
> This section is populated automatically by automation.
```

### `daily.md`

```markdown
---
title: "<% anio %>-<% mes %>-<% dia %>"
tags:
  - daily
aliases:
  - 
status: "log"
---

# Daily Note for <% anio %>-<% mes %>-<% dia %>

> What is the one thing I must accomplish today?

---
## ✅ Tasks
- [ ] 

### Done Today
> This section is populated automatically by automation.

---
## 📝 Log
* **10:08** - 

## 🌱 Seeds
* ---
## ▲ Links
- 

## ▼ Backlinks
> This section is populated automatically by automation.
```

### `weekly.md`

```markdown
---
title: "Week <% W %> of <% anio %>"
tags:
  - weekly
  - review
aliases:
  - 
status: "review"
---

# Weekly Review & Plan: Week <% W %> of <% anio %>

## ⏪ Review Last Week
### 🏆 Wins
- 

### 🚧 Challenges & Lessons Learned
- 

## ⏩ Plan This Week
### 🎯 Key Objectives (The Big Rocks)
1. 
2. 
3. 

### 📥 Process Inboxes
- [ ] Process all `🌱 Seeds` from last week's daily notes.
- [ ] Process physical and digital inboxes.

---
## ▲ Links
- 

## ▼ Backlinks
> This section is populated automatically by automation.
```

### `quarterly.md`

```markdown
---
title: "<% anio %> Q<quarter>"
tags:
  - quarterly
  - review
  - planning
aliases:
  - 
status: "review"
---

# Quarterly Review & Plan: <% anio %> Q<quarter>

## ⏪ Review Last Quarter
### 📈 Progress on Strategic Goals
- 

### 🏆 Major Accomplishments
- 

## ⏩ Plan This Quarter
### ⭐ Main Theme
> e.g., "Deep Work on Project Phoenix," "Mastering a New Skill," "Health Overhaul"

### 🎯 Strategic Goals
1. 
2. 
3. 

---
## ▲ Links
- 

## ▼ Backlinks
> This section is populated automatically by automation.
```
