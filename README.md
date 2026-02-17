# 🎛️ oc-disco

## OpenClaw -- Disco Command Alias Manager

**oc-disco** is a lightweight alias distribution and update system
designed primarily for OpenClaw ecosystems, homelab power users,
developers, and automation-heavy workflows.

It lets you:

-   Maintain a centralized set of shell aliases on GitHub
-   Install them once on any machine
-   Pull updates anytime with a single command
-   Keep user dotfiles clean and manageable
-   Support Zsh, Bash, and future shells easily

------------------------------------------------------------------------

## ✨ Why oc-disco Exists

Managing aliases across multiple machines gets messy fast. Copy/pasting
aliases leads to:

-   Drift between machines
-   Outdated commands
-   Difficult updates
-   Broken environments

**oc-disco solves this by acting like a mini package manager for shell
aliases.**

Install once → update anytime.

------------------------------------------------------------------------

## 🚀 Installation

Run this installer:

``` bash
curl -fsSL https://raw.githubusercontent.com/aldodelgado/oc-disco/main/install.sh | bash
```

This will:

1.  Download aliases into:

```{=html}
<!-- -->
```
    ~/.config/oc-disco/

2.  Add a managed loader block to:

-   `~/.zshrc`
-   `~/.bashrc`

3.  Install the `oc-disco` command into:

```{=html}
<!-- -->
```
    ~/.local/bin/

------------------------------------------------------------------------

## 🔄 Updating Aliases

Anytime you want the latest aliases:

``` bash
oc-disco update
```

Then restart your shell or run:

``` bash
source ~/.zshrc
```

or

``` bash
source ~/.bashrc
```

------------------------------------------------------------------------

## 📂 Repository Structure

    oc-disco/
      aliases/
        aliases.zsh
        aliases.bash
      install.sh
      README.md

### aliases/

Contains the distributable alias sets.

Keep these files clean:

-   aliases
-   functions
-   exports
-   minimal logic

Avoid install logic here.

------------------------------------------------------------------------

## 🧠 How It Works

1.  Installer fetches aliases from GitHub.
2.  Saves them locally in a managed config folder.
3.  Adds a small loader snippet to your shell config.
4.  Updates simply overwrite the managed alias file.

This avoids repeatedly modifying user dotfiles.

------------------------------------------------------------------------

## 🔒 Security Notes

Best practices:

-   Review aliases before installing.
-   Prefer tagged releases in production environments.
-   Avoid blindly executing unknown scripts.

Future roadmap:

-   Checksum verification
-   Signed releases
-   Version pinning

------------------------------------------------------------------------

## 🧑‍💻 Contributing

We welcome contributions.

### Ways to Help

-   New aliases
-   Documentation improvements
-   Installer enhancements
-   Cross-shell support
-   OpenClaw integrations

### Contribution Workflow

1.  Fork repo
2.  Create feature branch:

``` bash
git checkout -b feature/amazing-alias
```

3.  Commit clearly:

```{=html}
<!-- -->
```
    feat: add docker cleanup aliases
    fix: correct zsh completion issue
    docs: update install instructions

4.  Push and open a Pull Request.

------------------------------------------------------------------------

## 📜 Alias Contribution Guidelines

Please ensure:

-   Aliases are broadly useful
-   Names are descriptive
-   No destructive commands without warnings
-   Comments explain purpose
-   Works on macOS/Linux unless noted

Example:

``` bash
# Quickly show listening ports
alias ports='lsof -i -P -n | grep LISTEN'
```

------------------------------------------------------------------------

## 🧩 OpenClaw Integration

oc-disco is designed to complement:

-   OpenClaw agents
-   Homelab automation
-   AI workflow orchestration
-   Developer productivity stacks

It can distribute:

-   Agent helper commands
-   Debug tooling
-   Monitoring shortcuts
-   Deployment helpers

------------------------------------------------------------------------

## 🛣️ Roadmap

Planned:

-   Fish shell support
-   Alias version pinning
-   Remote config profiles
-   Plugin architecture
-   Auto-update scheduler
-   Secure signature verification

------------------------------------------------------------------------

## 💬 Support

Open an issue:

https://github.com/YOUR_GITHUB_USERNAME/oc-disco/issues

------------------------------------------------------------------------

## 🧠 Philosophy

Aliases should:

-   Reduce cognitive load
-   Prevent repeated mistakes
-   Increase velocity
-   Remain transparent and editable

oc-disco keeps your workflow fast, reproducible, and shareable.

------------------------------------------------------------------------

## ⭐ If You Like It

Give the repo a star.\
It helps others discover the project.
