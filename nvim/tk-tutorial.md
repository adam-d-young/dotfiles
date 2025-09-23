# 📝 Telekasten Tutorial

A comprehensive guide to using your Neovim-based Zettelkasten note-taking system.

## 🚀 Quick Start

### Launching Telekasten
```bash
# Launch with GUI (recommended)
neovide-notes

# Or with terminal
nvim-notes
```

### Essential Keymaps
- `<space>zd` - Open today's daily note
- `<space>zn` - Create new note
- `<space>zz` - Open telekasten panel
- `<space>mp` - Preview markdown with Glow
- `<space>fd` - Find files (Telekasten)
- `<space>fde` - Find files (extended - choose directory)
- `<space>gd` - Live grep (Telekasten)
- `<space>gde` - Live grep (extended - choose directory)
- `<space>ga` - Live grep with args (advanced ripgrep)

### Template Keymaps
- `<space>zp` - Create new project
- `<space>za` - Create new area
- `<space>zw` - Create new weekly note
- `<space>zm` - Create new monthly note
- `<space>zq` - Create new quarterly note
- `<space>zy` - Create new yearly note

## 📋 Daily Workflow

### 1. Start Your Day
1. Launch `neovide-notes`
2. Press `<space>zd` to open today's daily note
3. The template will automatically load with:
   - Date-based title
   - Daily objective prompt
   - Task list section
   - Log section for time-stamped entries
   - Seeds section for ideas

### 2. Capture Ideas
- **Quick capture**: Use the daily note's "Seeds" section
- **New notes**: Press `<space>zn` for a new zettel
- **Link notes**: Use `[[note title]]` syntax for wikilinks

### 3. Process Ideas
- **Weekly review**: Process seeds from daily notes
- **Create zettels**: Convert seeds into permanent notes
- **Link building**: Connect related concepts

## 🗂️ Note Types & Templates

### Daily Notes (`daily.md`)
- **Purpose**: Daily planning and capture
- **Features**: 
  - Date-based naming (YYYY-MM-DD)
  - Task management
  - Time-stamped log
  - Idea seeds inbox

### Weekly Notes (`weekly.md`)
- **Purpose**: Weekly review and planning
- **Features**:
  - Review last week's wins/challenges
  - Plan this week's objectives
  - Process idea seeds

### Monthly Notes (`monthly.md`)
- **Purpose**: Monthly reflection
- **Features**:
  - Monthly theme
  - Progress tracking
  - Goal setting

### Quarterly Notes (`quarterly.md`)
- **Purpose**: Strategic planning
- **Features**:
  - Strategic goal review
  - Quarterly theme
  - High-level planning

### Zettels (`zettel.md`)
- **Purpose**: Permanent knowledge notes
- **Features**:
  - Atomic concepts
  - Rich linking
  - Evergreen content

### Projects (`project.md`)
- **Purpose**: Specific deliverables with clear end dates
- **Features**:
  - Clear objectives and timeline
  - Key files and resources
  - Project notes and updates
  - Links to related areas and notes

### Areas (`area.md`)
- **Purpose**: Ongoing responsibilities and domains
- **Features**:
  - Current status tracking
  - Active projects within the area
  - Regular updates and notes
  - Links to related projects and notes

## 👥 Contacts Workflow

## 🌱 Weekly Review by Stage (system tags)

We mirror note stage into system-level tags for fast surfacing:
- `stage/seed` → raw capture
- `stage/sprout` → developing
- `stage/plant` → linked to graph
- `stage/evergreen` → stable, reusable
- `stage/log` → chronological logs (daily/weekly/monthly/quarterly/yearly)

### How to review
- Open Telekasten panel `<space>zz` → Tags → pick one of the stage tags
- Or grep just the vault: `<space>gd` and search `stage/seed` (or use `<space>ga` for advanced patterns)

### Weekly checklist
- Seeds → promote promising notes to `stage/sprout`
- Sprouts → add ≥2 outbound links; aim for one inbound link; promote to `stage/plant`
- Plants → refine to atomic, timeless notes; promote to `stage/evergreen`
- Evergreen → prune/merge; archive obsolete notes (tag `stage/archived`)

### Create a contact note (title = contact name)
```markdown
---
title: "Ada Lovelace"
tags:
  - contact
---
```
- Press `<space>zn` and title the note with the person’s name
- Add the system tag `contact` in frontmatter
- Optional quick fields in the body: email, org, role

### Link contact to an Area
- In the contact note (under “Links”), add: `[[Area: Client X Consulting]]`
- Optional: in the Area note, add back a link to the contact (explicit surfacing)

### Capture meetings with the contact
- In the daily note `<space>zd>`, add a line like: `[[Ada Lovelace]] – notes / action items`
- Backlinks in the contact note will show all daily notes referencing them

### Surface all contacts
- Telekasten panel `<space>zz` → pick Tags → enter `contact`
- Telescope (Telekasten vault only):
  - `<space>gd` and search for `- contact` or `tags: contact`
  - Advanced (`<space>ga`):
    ```
    --type md -e '(^tags:.*\bcontact\b)|(^\s*-\s*\bcontact\b)'
    ```

### Fast-path creation from anywhere
- Type `[[Ada Lovelace]]` and follow the link; if the note doesn’t exist, Telekasten offers to create it
- Add the `contact` tag and link to the Area

### Meeting Notes
- **Purpose**: Quick meeting note templates within daily notes
- **Usage**: Copy and paste the meeting template below as needed
- **Features**:
  - Structured meeting format
  - Action items with checkboxes
  - Easy to insert anywhere in daily notes

**Meeting Template**:
```markdown
## 📝 Meeting Notes

**With**: 

### 📝 Notes
- 

### ✅ Action Items
- [ ] 
```

## 🔗 Linking System

### Wikilinks
```markdown
[[Note Title]]           # Link to another note
[[Note Title|Display]]   # Link with custom display text
```

### Inserting Links
- **Easiest way**: `<leader>zl` - Opens link picker to search and select notes
- **Manual**: Type `[[` and start typing note title for autocomplete
- **From search**: Use `<space>ff` to find files, then link to them

### Backlinks
- Automatically generated in the "Backlinks" section
- Shows all notes that link to the current note
- Helps discover connections

### Link Navigation
- `gd` on a wikilink to follow it
- `gr` to find references to current note
- `gi` to find similar notes

### Backlink Search
- `:Telekasten backlinks` - Show all notes linking to current note
- `:Telekasten backlinks_here` - Show backlinks for note under cursor
- `:Telekasten search_links` - Search for notes containing specific link patterns

## 🏷️ Tagging Philosophy

Use tags as functional system markers, not topical labels:
- What a note IS: `daily`, `weekly`, `monthly`, `quarterly`, `status/active`, `stage/seed|sprout|plant|evergreen|log`
- What a note is ABOUT should be expressed via links to atomic zettels, not tags. Link concepts with `[[Concept]]` and let backlinks surface relationships.

Benefits:
- Predictable discovery via tag pickers (Telekasten) and Telescope
- Cleaner graph: concepts are nodes (notes), not tags
- Easier reviews (e.g., weekly stage review, active areas/projects)
## 🎯 Advanced Features

### Calendar Integration
- Press `<space>zz` to open the telekasten panel
- Navigate dates visually
- Jump to specific daily notes

### Search & Discovery
- `<space>ff` - Find files (telescope - searches current directory)
- `<space>fg` - Live grep search (telescope - searches current directory)
- `<space>fr` - Frecency (frequently used files)
- `<space>fd` - Find files (Telekasten vault)
- `<space>gd` - Live grep (Telekasten vault)
- `<space>ga` - Live grep with args (advanced ripgrep)

**Search Workflow**:
- **Telekasten search**: Use `<space>fd` and `<space>gd` for instant notes search
- **Other directories**: Change to directory with `:cd /path/to/dir` then use `<space>ff` and `<space>fg`
- **Ripgrep powered**: All searches use ripgrep for lightning-fast results

### Media Support
- Paste images directly into notes
- Preview images with telescope-media-files
- Supports PNG, JPG, JPEG, GIF, WebP

### Markdown Preview
- `<space>mp` - Preview with Glow
- Real-time markdown rendering
- Terminal-native preview

### Snippets
- **Meeting notes**: Copy and paste the meeting template from the Meeting Notes section above
- **Expand snippets**: Use `<Tab>` to expand snippets (for built-in snippets)
- **Navigate snippets**: Use `<Tab>` to jump between fields

### List Management
- **Auto bullets**: Press `Enter` after `-` to create new bullet point
- **Auto numbering**: Press `Enter` after `1.` to create numbered list
- **Auto indentation**: Bullets automatically indent after colons
- **Renumbering**: Numbered lists automatically renumber when items are added/removed
- **Empty cleanup**: Empty bullet points are automatically removed

### Timestamp Shortcuts
- **Insert time**: Press `<Ctrl-g><Ctrl-t>` in insert mode to insert current time (HH:MM)
- **Log entries**: Use in daily note log section for quick time-stamped entries
- **Note**: `<Ctrl-t>` is used by bullets.vim for indenting, so we use `<Ctrl-g><Ctrl-t>` for timestamps

## 📁 File Organization

### Directory Structure
```
~/Dropbox/Apps/zettelkasten/
├── daily/           # Daily notes (YYYY-MM-DD.md)
├── weekly/          # Weekly notes
├── monthly/         # Monthly notes
├── quarterly/       # Quarterly notes
├── templates/       # Note templates
└── [other notes]    # Regular zettels
```

### Naming Conventions
- **Daily**: `2025-01-22.md`
- **Weekly**: `2025-W04.md`
- **Monthly**: `2025-01.md`
- **Quarterly**: `2025-Q1.md`
- **Zettels**: `Descriptive Title.md`

## 🔧 Configuration

### Environment Variables
```bash
export TELEKASTEN_HOME="/path/to/your/zettelkasten"
# or
export ZK_HOME="/path/to/your/zettelkasten"
# For cross-vault search with Logseq
export LOGSEQ_HOME="/path/to/your/logseq/vault"
```

### Custom Templates
Templates are located in `~/Dropbox/Apps/zettelkasten/templates/`:
- `daily.md` - Daily note template
- `weekly.md` - Weekly note template
- `monthly.md` - Monthly note template
- `quarterly.md` - Quarterly note template
- `yearly.md` - Yearly note template
- `zettel.md` - Zettel template
- `project.md` - Project template
- `area.md` - Area template

## 🎨 Template Variables

Templates support these variables (use `{{variable}}` syntax):
- `{{date}}` - Date in ISO format (2025-01-22)
- `{{year}}` - Year (2025)
- `{{time24}}` - Time with 24-hour clock (19:12:23)
- `{{time12}}` - Time with 12-hour clock (07:12:23 PM)
- `{{hdate}}` - Date in long format (Sunday, January 22nd, 2025)
- `{{week}}` - Week of the year (46)
- `{{title}}` - Note title
- `{{shorttitle}}` - Short title (filename without path)
- `{{uuid}}` - Unique identifier
- `{{prevday}}` - Previous day (2025-01-21)
- `{{nextday}}` - Next day (2025-01-23)

For a complete list, run `:h telekasten.template_files` in Neovim.

## 🚨 Troubleshooting

### Daily Note Not Loading Template
1. Check if a blank daily note already exists
2. Delete the blank file: `rm ~/Dropbox/Apps/zettelkasten/daily/YYYY-MM-DD.md`
3. Try `<space>zd` again

### Templates Not Found
1. Run the setup script: `./nvim/scripts/setup.sh`
2. Check templates exist: `ls ~/Dropbox/Apps/zettelkasten/templates/`

### LSP Errors
- Ensure marksman is installed: `brew install marksman`
- Check LSP configuration in `lua/user/plugins/coding.lua`

## 💡 Best Practices

### Note Creation
1. **Start with daily notes** - capture everything there first
2. **Process regularly** - move ideas from daily to permanent notes
3. **Link everything** - build a web of connections
4. **Keep atomic** - one concept per zettel

### Linking Strategy
1. **Link to concepts**, not just topics
2. **Use descriptive titles** for easy linking
3. **Create index notes** for major topics
4. **Review backlinks** to discover connections

### Maintenance
1. **Weekly reviews** - process seeds and plan ahead
2. **Monthly reviews** - reflect on progress and themes
3. **Quarterly reviews** - strategic planning and goal setting
4. **Regular cleanup** - archive or delete outdated notes

## 🎯 Workflow Examples

### Daily Workflow
1. Open daily note (`<space>zd`)
2. Set daily objective
3. Add tasks to task list
4. Capture ideas in seeds section
5. Log important events with timestamps

### Weekly Workflow
1. Open weekly note
2. Review last week's daily notes
3. Process seeds from daily notes
4. Plan this week's objectives
5. Create zettels from processed ideas

### Research Workflow
1. Create a new zettel (`<space>zn`)
2. Take notes and add links
3. Create related zettels as needed
4. Build a network of connected concepts

## 🔄 Cross-Vault Workflow: Logseq → Telekasten

### Finding Content in Logseq
1. **Change to Logseq directory**:
   ```vim
   :cd ~/Dropbox/Apps/Logseq
   ```
   (Adjust path to your Logseq vault)

2. **Search for files**:
   - `<space>ff` - Find specific note files
   - Use fuzzy search to locate notes by title

3. **Search content**:
   - `<space>fg` - Live grep across all Logseq notes
   - Search for specific concepts, quotes, or ideas
   - Use ripgrep patterns: `"exact phrase"` or `\bword\b`

4. **Advanced search**:
   - `<space>ga` - Live grep with arguments
   - Examples:
     - `--type md` - Only markdown files
     - `--ignore-case` - Case insensitive
     - `--word-regexp` - Whole word matches
     - `--include="*.md"` - Specific file patterns

### Transferring Content to Telekasten

#### Method 1: Copy and Link
1. **Find the Logseq note** using the search above
2. **Open the note** and select the content you want
3. **Create new Telekasten note**: `<space>zn`
4. **Paste and adapt** the content
5. **Add backlink**: `[[Logseq Note Title]]` in the Links section

#### Method 2: Reference and Extract
1. **Create a Telekasten note** about the topic: `<space>zn`
2. **Add reference** in Links section: `[[Logseq Note Title]]`
3. **Extract key insights** and write them in your own words
4. **Link to related Telekasten notes** using `[[Note Title]]`

#### Method 3: Atomic Note Creation
1. **Search Logseq** for a specific concept: `<space>fg` in Logseq directory
2. **Find the relevant section** in the search results
3. **Create atomic zettel**: `<space>zn` with focused title
4. **Extract the core idea** and write it concisely
5. **Link back to source**: `[[Logseq Note Title]]`

### Advanced Telescope Features

#### Using Frecency for Recent Notes
- `<space>fr` - Shows recently accessed files
- Great for finding notes you were just working on

#### Using Symbols for Code/Structured Content
- `<space>ts` - Search for symbols (functions, classes, etc.)
- Useful if your Logseq notes contain code snippets

#### Using BibTeX for References
- `<space>tb` - Search bibliography entries
- If you have academic references in your notes

### Telekasten Integration Features

#### Calendar Integration
- `<space>zz` - Open Telekasten panel
- Navigate to specific dates to see what you were working on
- Link daily notes to Logseq content: `[[2024-01-15]] - Found this in Logseq`

#### Template System
- Use project templates: `<space>zp` for Logseq-related projects
- Use area templates: `<space>za` for ongoing Logseq workflows
- Link Logseq notes to projects/areas

#### Backlink Discovery
- After linking to Logseq notes, use Telekasten's backlink features
- See which Telekasten notes reference your Logseq content
- Build bidirectional knowledge networks

### Example: Migrating a Research Note

1. **Search Logseq**: `:cd ~/Logseq` → `<space>fg` → search "machine learning"
2. **Find relevant note**: Open the most relevant result
3. **Create Telekasten zettel**: `<space>zn` → "Machine Learning Concepts"
4. **Extract key points**: Write atomic notes for each concept
5. **Link back**: Add `[[Logseq ML Research]]` to Links section
6. **Connect ideas**: Link to other Telekasten notes with `[[Related Concept]]`
7. **Update daily note**: `<space>zd` → log the migration work

### Pro Tips

- **Use ripgrep patterns** for precise searches: `"exact phrase"` or `\bword\b`
- **Combine searches**: Search Logseq, then search Telekasten for related content
- **Create index notes**: Make Telekasten notes that catalog your Logseq content
- **Use timestamps**: `<Ctrl-g><Ctrl-t>` to track when you migrated content
- **Build bridges**: Create Telekasten notes that connect Logseq concepts

---

*Happy note-taking! 🎉*
