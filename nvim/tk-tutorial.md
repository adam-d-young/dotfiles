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

## 🔗 Linking System

### Wikilinks
```markdown
[[Note Title]]           # Link to another note
[[Note Title|Display]]   # Link with custom display text
```

### Backlinks
- Automatically generated in the "Backlinks" section
- Shows all notes that link to the current note
- Helps discover connections

### Link Navigation
- `gd` on a wikilink to follow it
- `gr` to find references to current note
- `gi` to find similar notes

## 🎯 Advanced Features

### Calendar Integration
- Press `<space>zz` to open the telekasten panel
- Navigate dates visually
- Jump to specific daily notes

### Search & Discovery
- `<space>ff` - Find files (telescope)
- `<space>fg` - Live grep search
- `<space>fr` - Frecency (frequently used files)

### Media Support
- Paste images directly into notes
- Preview images with telescope-media-files
- Supports PNG, JPG, JPEG, GIF, WebP

### Markdown Preview
- `<space>mp` - Preview with Glow
- Real-time markdown rendering
- Terminal-native preview

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
```

### Custom Templates
Templates are located in `~/Dropbox/Apps/zettelkasten/templates/`:
- `daily.md` - Daily note template
- `weekly.md` - Weekly note template
- `monthly.md` - Monthly note template
- `quarterly.md` - Quarterly note template
- `zettel.md` - Zettel template

## 🎨 Template Variables

Templates support these variables:
- `<% anio %>` - Year (2025)
- `<% mes %>` - Month (01)
- `<% dia %>` - Day (22)
- `<% W %>` - Week number
- `<quarter>` - Quarter number

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
5. Review backlinks to discover new connections

---

*Happy note-taking! 🎉*
