# Source all scripts in ~/.zshrc.d/

```bash
if [ -d "$HOME/.zshrc.d" ]; then
    for script in "$HOME/.zshrc.d/"*; do
        if [ -f "$script" ] && [ -r "$script" ]; then
            source "$script"
        fi
    done
fi
```
