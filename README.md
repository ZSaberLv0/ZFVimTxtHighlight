# ZFVimTxtHighlight

vim script to highlight plain text files

here is a screenshot with [xterm16](https://github.com/vim-scripts/xterm16.vim) colorscheme

![screenshot](https://raw.githubusercontent.com/ZSaberLv0/ZFVimTxtHighlight/master/screenshot.png)

if you like my work, [check here](https://github.com/ZSaberLv0?utf8=%E2%9C%93&tab=repositories&q=ZFVim) for a list of my vim plugins,
or [buy me a coffee](https://github.com/ZSaberLv0/ZSaberLv0)

# How to use

1. use [Vundle](https://github.com/VundleVim/Vundle.vim) or any other plugin manager you like to install

    ```
    Plugin 'ZSaberLv0/ZFVimTxtHighlight'
    ```

1. by default, all `text` files or any other file that have no `syntax` specified,
    would be set to `zftxt` as `syntax`

    you can disable it by setting:

    ```
    let g:zf_txt_auto_highlight=0
    ```

    or, set the file type to auto enable:

    ```
    let g:zf_txt_auto_syntax = ['', 'txt', 'text']
    ```

    or, you may want to set `syntax` manually when necessary:

    ```
    set syntax=zftxt
    ```

    or, replace original file type detect:

    ```
    autocmd FileType html,markdown set syntax=zftxt
    ```

1. by default, files that larger than 5MB would be ignored from highlight,
    you may change this setting by

    ```
    let g:zf_txt_large_file=5*1024*1024
    ```

# Add your custom keyword

* to add your custom syntax or keyword,
    add `*.vim` file to your `rtp` (`:h rtp`),
    with this directory structure:

    ```
    rtp/
        zftxt/
            your_syntax.vim
    ```

    the `*.vim` file would be sourced (`:h :source`) during highlighting,
    see `zftxt.vim` itself for examples

# Functions

* `:call ZF_VimTxtHighlightToggle()` : toggle current file syntax
* `:call ZF_VimTxtHighlightEcho()` or `:ZFHIGHLIGHT` : echo the highlight info of the word under cursor

