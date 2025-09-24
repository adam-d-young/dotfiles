# 🗺️ Project Plan & Development Log

This document outlines the initial plan for building the modular Neovim configuration and will be updated with a development log after each iteration. The primary goal is to produce three distinct, managed configurations: one for note-taking, one for general development, and one for learning that will simply load kickstart.nvim (repo located outside of this repo).

---

## 📝 Project Plan

### Core Scaffolding & Tooling
The first part of the plan is to establish a robust project structure and set up the necessary development tools.

* **Project Structure**: The configuration will be organized as follows:
    ```
    .
    ├── init.lua
    ├── lua/
    │   └── user/
    │       ├── core/
    │       │   ├── options.lua
    │       │   └── keymaps.lua
    │       ├── plugins/
    │       │   └── ... (individual plugin configs)
    │       └── plugins.lua
    ├── templates/
    │   ├── daily.md
    │   ├── weekly.md
    │   ├── monthly.md
    │   ├── quarterly.md
    │   ├── yearly.md
    │   └── zettel.md
    ├── tests/
    └── scripts/
        └── setup.sh
    ```
* **Plugin Manager**: **lazy.nvim** will be used for all plugin management.
* **Testing Framework**: **plenary.nvim** will be integrated as a development dependency to facilitate Test-Driven Development (TDD).

### Core Note-Taking System
This section focuses on implementing `telekasten.nvim` with its complete set of templates and dependencies for the **notes-focused configuration**.

* **Complete Template Suite**: Create all templates recognized by Telekasten in the `templates/` directory, using the correct **YAML frontmatter** syntax.
* **Core Dependency Integration**:
    * **Calendar**: Integrate **`calendar-vim`** for visual date selection.
    * **Image Preview**: Integrate **`telescope-media-files.nvim`**. The setup script will check for **`viu`** or **`catimg`** as required terminal image previewers.
    * **Image Pasting**: The setup script will handle OS-specific clipboard tools (**`xclip`** for X11, **`wl-clipboard`** for Wayland).

### Extended Functionality & UX
This section will integrate additional plugins to enhance the editing and note-taking experience, with recommendations based on current best practices.

* **Academic/Research**: Integrate **`telescope-bibtex.nvim`** for managing citations.
* **UX Enhancements**:
    * **`telescope-symbols.nvim`**: For easy insertion of symbols and emojis.
    * **`glow.nvim`**: For fast, terminal-native markdown previewing.
    * **`marksman` LSP**: For superior Table of Contents and document outline functionality.
    * **`telescope-frecency.nvim`**: For intelligent, frequency-based file history.
    * **`synctodo` script**: Documented for users in the Apple ecosystem.

### Tagging Philosophy (System Tags over Topical Tags)
Tags should be functional, not topical. Use tags to indicate what a note IS in the system, not what it is ABOUT. Examples:
- Note type / cadence: `daily`, `weekly`, `monthly`, `quarterly`
- Lifecycle (areas/projects): `status/active`
- Note stage (maturity): `stage/seed`, `stage/sprout`, `stage/plant`, `stage/evergreen`, `stage/log`
Avoid topical tags like `#marketing` or `#python`—prefer links to atomic zettels instead. This keeps discovery consistent via Telekasten’s tag pickers and Telescope searches.

### Helper Scripts & Automation
This part of the plan focuses on creating a sophisticated setup script to manage the three distinct configurations. The best practice for managing separate-but-related configs is to use the `NVIM_APPNAME` environment variable, which creates isolated configuration directories.

* **`scripts/setup.sh`**: This shell script will be the primary tool for managing the configurations.
    * **OS Detection**: It **must** detect the operating system (Linux, macOS) to install the correct dependencies.
    * **Dependency Checks**: It will check for required CLI tools (`git`, `viu`, `xclip`, etc.) and instruct the user how to install them.
    * **Installation & Profile Management**: The script will create aliases and symlink the project files to manage the following three profiles:
        1.  **Notes Config**: A full-featured `telekasten` environment.
            * **Directory**: `~/.config/nvim-notes`
            * **Alias**: `alias nvim-notes='NVIM_APPNAME=nvim-notes nvim'`
        2.  **Dev Config**: A lightweight version for general coding, which will reuse most of the core setup but disable note-taking plugins like `telekasten`.
            * **Directory**: `~/.config/nvim-dev`
            * **Alias**: `alias nvim-dev='NVIM_APPNAME=nvim-dev nvim'`
        3.  **Learn Config**: A direct link to an external `kickstart.nvim` configuration for learning and reference. This uses the `-u` flag as it points to a single, standalone file.
            * **Path**: A user-defined `$KICKSTART_PATH` variable in the script.
            * **Alias**: `alias nvim-learn='nvim -u $KICKSTART_PATH/init.lua'`

---

## 📜 Development Log
*This section will be updated after each significant development iteration.*

### **2025-09-22** - Iteration 1 - Core Scaffolding, YAML Templates, Profiles
* **Changes**:
    * Scaffolded modular Neovim config with `init.lua`, `lua/user/core/*`, `lua/user/plugins/*`, and `lua/user/utils/profile.lua`.
    * Bootstrapped `lazy.nvim` and added base UX plugins (tokyonight, lualine, neo-tree, telescope, trouble, gitsigns, which-key, indent-blankline).
    * Added coding stack: Treesitter, LSP (lua_ls, marksman) via mason + lspconfig, nvim-cmp, and formatting/linting via none-ls (stylua, luacheck).
    * Implemented notes stack (conditional by profile): telekasten with calendar and media preview extension, pointing to YAML-based templates.
    * Created YAML-frontmatter note templates: `templates/zettel.md`, `templates/daily.md`, `templates/weekly.md`, `templates/quarterly.md`.
    * Added developer tooling: `.stylua.toml` and `.luacheckrc`; added a minimal example test under `tests/` using plenary harness.
    * Wrote `scripts/setup.sh` to set up aliases (`nvim-dev`, `nvim-notes`, `nvim-learn`) and link profile dirs using `NVIM_APPNAME`.
    * Updated documentation to use **YAML** frontmatter (replaced prior TOML references).
* **Status**:
    * Core scaffolding complete and runnable. Notes profile loads Telekasten when launched via `NVIM_APPNAME=nvim-notes`.
* **Next Steps**:
    * Flesh out tests for custom utilities and critical configuration functions.
    * Integrate vault automation scripts and backlinks writer.

### **2025-09-22** - Iteration 2 - Monthly/Yearly Templates, Extended UX
* **Changes**:
    * Added `templates/monthly.md` and `templates/yearly.md` with YAML frontmatter.
    * Integrated extended UX plugins: `glow.nvim` (Markdown preview), `telescope-bibtex.nvim`, `telescope-symbols.nvim`, and `telescope-frecency.nvim`.
    * Added leader keymaps: `<leader>mp` (glow), `<leader>fr` (frecency), `<leader>tb` (bibtex), `<leader>ts` (symbols).
    * Updated `scripts/setup.sh` to detect the Glow CLI and prompt installation if missing.
* **Status**:
    * Extended UX available; optional CLIs checked during setup.
* **Next Steps**:
    * Add tests for `user.utils.profile` and critical plugin setup functions using plenary.
    * Optionally add academic workflows and citation file discovery defaults for bibtex.

### **2025-09-22** - Iteration 3 - Test Coverage (Profiles, Templates, Keymaps)
* **Changes**:
    * Added tests: `tests/profile_spec.lua` (env-based profile selection), `tests/templates_spec.lua` (file existence and YAML frontmatter), `tests/keymaps_spec.lua` (core mappings presence).
* **Status**:
    * Basic test coverage in place. Future tests can mock plugin calls as needed.
* **Next Steps**:
    * Add CI to run tests and Stylua/Luacheck.
    * Expand tests around lazy plugin loading guards and error handling.

### **2025-09-22** - Iteration 4 - CI for Linting and Tests
* **Changes**:
    * Added GitHub Actions workflow `.github/workflows/ci.yml` to run Stylua (check), Luacheck, and Neovim tests headlessly with Plenary.
    * Included minimal test init (`tests/minimal_init.lua`) and vendor path for `plenary.nvim` in CI.
* **Status**:
    * CI ready; runs on pushes and PRs to `main`.
* **Next Steps**:
    * Add caching for luarocks and plugin downloads.
    * Optionally add macOS job to verify cross-platform behaviors.

### **2025-09-22** - Iteration 5 - macOS CI and setup.sh Validation
* **Changes**:
    * Extended CI with a `macos-latest` job to run Stylua, Luacheck, and Neovim tests.
    * Added a step to run `scripts/setup.sh` under a temporary HOME, validating alias writes and profile directory creation on macOS.
* **Status**:
    * macOS bits validated in CI.
* **Next Steps**:
    * Add CI caching and possibly matrix strategy for multiple Neovim versions.

### **2025-01-22** - Iteration 6 - Telekasten Integration & Error Resolution
* **Changes**:
    * Migrated from deprecated `nvim-lspconfig` to native `vim.lsp.start()` API
    * Fixed marksman LSP installation and PATH resolution
    * Resolved plugin spec errors and dependency issues
    * Implemented automated telekasten template setup in `scripts/setup.sh`
    * Enhanced test suite with plugin loading, integration, and error handling tests
    * Created comprehensive `tk-tutorial.md` documentation
    * Updated troubleshooting guide with systematic debugging approach
* **Status**:
    * All major configuration issues resolved
    * Telekasten fully functional with template loading
    * Robust error handling and graceful degradation
    * Comprehensive test coverage and documentation
* **Next Steps**:
    * Monitor for any edge cases in production use
    * Consider additional telekasten features or customizations

### **2025-01-22** - Iteration 7 - Project & Area Templates with Snippet Support
* **Changes**:
    * Created project template (`project.md`) for specific deliverables with clear end dates
    * Created area template (`area.md`) for ongoing responsibilities and domains
    * Added monthly and yearly templates (`monthly.md`, `yearly.md`) for comprehensive time-based planning
    * Integrated LuaSnip for template injection with custom meeting snippet
    * Added comprehensive keymaps for all template types (`<space>zp`, `<space>za`, etc.)
    * Updated tutorial with project/area workflow, linking strategies, and snippet usage
    * Removed separate meeting template in favor of daily note snippets
    * Enhanced linking documentation with backlink search commands
* **Status**:
    * Complete template suite for project management and knowledge organization
    * Snippet-based template injection for flexible daily note workflows
    * Comprehensive keymap system for all note types
    * Updated documentation covering project/area relationships and atomic note philosophy
* **Next Steps**:
    * User testing and refinement based on actual usage patterns
    * Consider additional snippet templates for common workflows

### **2025-09-22** - Iteration 0 - Project Plan Finalized
* **Changes**:
    * Initial `heuristics.md` and `PROJECT_PLAN.md` created.
    * Researched and selected all core and extended plugins.
    * Defined the full suite of note-taking templates, including quarterly.
    * Clarified the goal to produce three distinct configurations (notes, dev, learn) and the script-based approach for managing them.
* **Status**:
    * Planning and research complete. Ready to begin development.
* **Next Steps**:
    * Begin work on Core Scaffolding & Tooling.

### **2025-09-23** - Iteration 11 - Zettels dir, UUID frontmatter, simplified filenames
* **Changes**:
    * Switched new-note filename policy to title-based to keep wikilinks simple (`[[Title]]`).
    * Kept unique identifiers via YAML `uuid:` injected in all templates (daily/weekly/monthly/yearly/zettel/area/project) using datetime (`%Y%m%d%H%M%S`).
    * Added `zettels/` directory and routed `<space>zn` to create new zettels there by default.
    * Ensured clean links by setting `subdirs_in_links = false`.
    * Added Telekasten highlight overrides in Lua (`tkLink`, `tkBrackets`, `tkTag`, etc.) with ColorScheme autocmd to persist across themes.
    * Inserted "Quarter Progress" section into new monthly notes automatically, indicating month 1–3 within the quarter.
    * Added keymaps: `<space>zl` (insert link), `<space>zf` (follow/create link), preserved existing daily/weekly/monthly/yearly mappings.
* **Status**:
    * Title-only filenames and vault-wide resolution mean links stay path-free and robust.
    * UUIDs live in frontmatter for traceability without polluting filenames.
* **Next Steps**:
    * Optionally add a `--link` mode to setup.sh to symlink profiles for live edits.
    * Consider a wrapper for `<space>zl` that routes new-note creation into `zettels/` explicitly.

### **2025-01-22** - Iteration 12 - Organized Note Structure with Clean Titles
* **Changes**:
    * Reorganized vault structure with shorter directory names: `zet/`, `area/`, `proj/` for better organization.
    * Fixed Telekasten note creation to properly place notes in subdirectories using `dir` parameter.
    * Updated templates to use `{{shorttitle}}` variable to display clean titles without directory prefixes in frontmatter and headings.
    * Added daily note navigation keymaps: `<leader>z<` (previous day), `<leader>z>` (next day) for browsing existing daily notes.
    * Removed non-functional area and project keymaps, keeping only working `<leader>zn` for zettel creation.
    * Enhanced template system to handle directory-prefixed titles while maintaining clean display.
* **Status**:
    * Organized note structure with proper subdirectory placement.
    * Clean title display in templates using Telekasten's built-in `{{shorttitle}}` variable.
    * Functional daily note navigation and zettel creation workflows.
* **Next Steps**:
    * Consider adding back area/project keymaps once directory placement issues are resolved.
    * Add test coverage for Telekasten-specific keymaps and template functionality.

### **2025-01-22** - Iteration 13 - Simplified Tag System and Link Completion
* **Changes**:
    * Switched to `yaml-bare` tag format (`tags: [tag1, tag2]`) for reliable Telekasten integration.
    * Simplified tag search to use built-in `tk.show_tags()` function instead of complex custom regex patching.
    * Added `[[` auto-completion keymap for insert mode (complementing Marksman LSP completion).
    * Enhanced Telescope configuration with proper navigation keymaps and missing extensions.
    * Added daily note review section with tomorrow planning todos.
    * Cleaned up code by removing unused functions and fixing linting issues.
    * Removed personal paths from documentation for privacy.
* **Status**:
    * Reliable tag search using Telekasten's native functionality.
    * Clean, maintainable code with comprehensive test coverage.
    * Enhanced user experience with proper picker navigation and link completion.
* **Next Steps**:
    * Test `[[` auto-completion with Marksman LSP in real usage.
    * Consider adding area/project keymaps with working directory placement.
    * Monitor tag search performance with large note collections.
