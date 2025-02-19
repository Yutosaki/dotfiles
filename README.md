### my zsh setting file

# how to use

run in your home directory

```
git clone "this repository"

sh settings.sh

ln -snf ~/dotfiles/.zshrc ~/.zshrc # and so on...

source ~/.zshrc
```

# caution!
if you can't use bat coz you got this messgage

` zsh: no such file or directory: /Users/sasakiyuto/dotfiles/bat/target/release/bat`

you have to run this command in `~/dotfiles/bat`
```
cargo build --release
```
