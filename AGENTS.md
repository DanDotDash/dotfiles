# AGENTS.md - Dotfiles Development Guide

This is a dotfiles repository containing shell scripts and configuration files for macOS development environment setup.

## Repository Structure

```
dotfiles/
├── .aliases           # Shell aliases
├── .zshrc             # Zsh configuration
├── .gitignore         # Git ignore rules
├── install.sh         # Main installation script
├── brew.sh            # Homebrew package installer
├── macos.sh           # macOS settings configuration
├── mas.sh             # Mac App Store installer
├── vscode.sh          # VS Code setup script
├── vscode/            # VS Code settings and keybindings
├── settings/          # Editor settings and profiles
├── rectangle/        # Rectangle window manager config
├── starship/          # Starship prompt config
├── wezterm/           # WezTerm terminal config
└── affinity/          # Affinity app settings
```

## Build/Lint/Test Commands

Since this is a configuration repository (not a software project), there are no traditional build/test commands. However, the scripts can be validated and executed as follows:

### Running the Main Installation

```sh
# Run the full installation (creates symlinks, installs packages, configures macOS)
./install.sh

# Or run individual scripts
./brew.sh      # Install Homebrew packages and casks
./macos.sh     # Configure macOS settings
./mas.sh       # Install App Store apps
./vscode.sh    # Setup VS Code
```

### Shell Script Linting

```sh
# Check shell script syntax (bash/zsh)
shellcheck brew.sh install.sh macos.sh vscode.sh mas.sh

# Format shell scripts
shfmt -w brew.sh install.sh macos.sh vscode.sh mas.sh
```

### VS Code Settings Validation

```sh
# Validate JSON syntax in VS Code settings
cat vscode/VSCode-Settings.json | python3 -m json.tool > /dev/null
```

### Creating Symlinks Manually

```sh
# Symlink dotfiles to home directory
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.aliases ~/.aliases
```

## Code Style Guidelines

### Shell Scripts (.sh)

- **Shebang**: Use `#!/usr/bin/env zsh` for scripts (this repo uses zsh)
- **Variable Naming**: Use lowercase with underscores (`dotfiledir`, `git_user_name`)
- **Constants**: Use uppercase (`BREW_ZSH`, `PATH`)
- **Array Declaration**: Use `packages=(...)` syntax for lists
- **Conditionals**: Use `[[ ]]` for zsh conditionals, not `[ ]`
- **Command Substitution**: Use `$()` instead of backticks
- **Error Handling**: Use `|| exit 1` after critical commands
- **Quoting**: Quote variables with double quotes (`"${variable}"`) to handle spaces
- **Comments**: Use `#` for comments, include brief explanations for non-obvious logic

**Example**:
```zsh
#!/usr/bin/env zsh

# Check if brew is installed
if ! command -v brew &>/dev/null; then
    echo "Homebrew not installed. Installing Homebrew."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
```

### Zsh Configuration (.zshrc)

- **Sourcing**: Use `source` for loading additional config files
- **Path**: Add Homebrew path with `export PATH=/opt/homebrew/bin:$PATH`
- **History**: Configure with `HISTFILE`, `SAVEHIST`, `HISTSIZE`
- **Options**: Use `setopt` for zsh-specific options

### Aliases (.aliases)

- **Naming**: Use short, memorable names (`l`, `ll`, `la`, `grep`)
- **Organization**: Group by category with comments
- **Safety**: Use `command` prefix to avoid alias recursion
- **Functions**: Prefer functions over aliases for complex commands

### JSON Configuration Files

- **Formatting**: 2-space indentation
- **Keys**: Double-quoted keys and string values
- **Trailing Commas**: Avoid trailing commas
- **Comments**: Use `//` for comments (VS Code allows this)

**Example**:
```json
{
  "editor.fontSize": 16,
  "editor.tabSize": 4,
  "editor.formatOnSave": true
}
```

### VS Code Settings

- **Organization**: Group related settings with comments
- **Language-specific**: Use language identifiers (`[python]`, `[shellscript]`)
- **Recording Mode**: Keep recording-specific settings commented out separately

## Naming Conventions

- **Files**: Use descriptive names (e.g., `brew.sh`, `macos.sh`, `VSCode-Settings.json`)
- **Aliases**: Short and memorable (`ll`, `la`, `grep`)
- **Variables**: Descriptive (`current_email` not `ce`)
- **Functions**: Descriptive for complex aliases

## Error Handling

- **Exit Codes**: Use `|| exit 1` for fatal errors
- **Verification**: Check command availability with `command -v`
- **User Input**: Use `read` for interactive prompts
- **Logging**: Echo status messages before operations

## Git Conventions

- **Private Data**: Never commit sensitive data; use `.gitignore` for secrets
- **Backups**: The repo includes `.private` for personal config (gitignored)
- **Branch**: Work on feature branches for non-trivial changes

## Important Notes

- This repository is highly personalized - modifications will overwrite existing configs
- Review scripts before running; they make system-wide changes
- The `.private` file contains personal settings and should not be committed
- Some scripts (like `macos.sh`) modify system settings that may require restart

## Agent Guidelines

When modifying this repository:
1. Always review existing conventions in similar files before making changes
2. Test shell scripts locally before committing (use `zsh -n` for syntax check)
3. Validate JSON files after editing
4. Avoid adding personal preferences - keep changes objective and minimal
5. Consider whether changes apply to all machines or are machine-specific