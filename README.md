## my setting file

# how to use

run in your home directory

```
git clone "this repository"

sh settings.sh

ln -snf ~/dotfiles/.zshrc ~/.zshrc # and so on... (.gitconfig .bashrc .vimrc)
ln -s ~/dotfiles/nvim ~/.config

source ~/.zshrc
```


# caution!
if you can't use bat coz you got this messgage

` zsh: no such file or directory: /Users/sasakiyuto/dotfiles/bat/target/release/bat`

you have to run this command in `~/dotfiles/bat`
```
cargo build --release
```
<br>
if you can't use lsd or something like that (zsh, cargo ...), you should install like this

`sudo apt install lsd` or `brew install lsd`
