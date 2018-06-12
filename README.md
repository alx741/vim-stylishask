# vim-stylishask

Integrates with [stylish-haskell](https://github.com/jaspervdj/stylish-haskell)
so every time you save a Haskell source file it gets automatically prettified.

Simply using `:%!stylish-haskell` replaces your whole source file with an error
message from **stylish-haskell** when you happen to have a syntax error in your
code, this plugin manages that annoyance.

*Note:* If you prefer *hindent* use
[vim-hindent](https://github.com/alx741/vim-hindent) instead.

## Installation

Compatible with `Vundle`, `Pathogen`, `Vim-plug`.


## Usage

By default, *vim-stylishask* will format your code automatically when saving a
Haskell source file, but you can use the `:Stylishask` command at any time to
format the current file.

To apply *stylish-haskell* on a range, either write the range manually or
visually select the desired code and then invoke `:Stylishask`.

Use `:StylishaskEnable`, `:StylishaskDisable`, `:StylishaskToggle` to enable,
disable, or toggle running `stylish-haskell` on save.


## Configuration

Trigger *stylish-haskell* when saving (default = 1):

```vim
g:stylishask_on_save = 1
```

*stylish-haskell* configuration file to use (default = "" == Use default .stylish-haskell.yaml):

```vim
g:stylishask_config_file = "/path/to/.stylish-haskell.yaml"
```
