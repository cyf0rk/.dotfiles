# .dotfiles

## Installation

#### Prerequisites

- git
- stow

#### Requirements:

- [awesomeWM][awesomewm]
- [WezTerm][wezterm]
- zsh and [oh-my-zsh][oh-my-zsh]
- [neovim][neovim]
- [tmux][tmux]
- [Nerd Fonts][nerd-fonts] (Fira Code)
- [xscreensaver][xscreensaver]

##### Additional:

- pip
- [nvm][nvm]/npm/node
- [go][go]
- rubygems
- [ripgrep][ripgrep]
- [cargo][cargo]
- redshift
- light
- pavucontrol
- flameshot
- [docker][docker]
- setup venv in home dir and install python debugger
    - mkdir .virtualenvs
    - cd .virtualenvs
    - python -m venv debugpy
    - debugpy/bin/python -m pip install debugpy
- add user to video and docker groups

### Git + bootstrap script

Clone repo on your local machine and run bootstrap script to setup symlinks

```bash
git clone --recurse-submodules https://github.com/cyf0rk/.dotfiles && cd .dotfiles && sh bootstrap
```
[awesomewm]: https://github.com/awesomeWM/awesome
[wezterm]: https://github.com/wez/wezterm
[oh-my-zsh]: https://github.com/ohmyzsh/ohmyzsh/
[neovim]: https://github.com/neovim/neovim
[tmux]: https://github.com/tmux/tmux/wiki
[nerd-fonts]: https://github.com/ryanoasis/nerd-fonts
[nvm]: https://github.com/nvm-sh/nvm
[ripgrep]: https://github.com/BurntSushi/ripgrep
[xscreensaver]: https://www.jwz.org/xscreensaver/
[go]: https://go.dev/doc/install
[cargo]: https://doc.rust-lang.org/cargo/getting-started/installation.html
[docker]: https://docs.docker.com/desktop/install/linux-install/
