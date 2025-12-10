## my setting file

# how to use

run in your home directory

```
git clone git@github.com:Yutosaki/dotfiles.git
```
```
./settings.sh
```

# caution!
if you can't use bat coz you got this messgage

` zsh: no such file or directory: /Users/sasakiyuto/dotfiles/bat/target/release/bat`

you have to run this command in `~/dotfiles/bat`
```
cargo build --release
```
<br>

if you want to use multipass, you should change file name `init.yaml.template` to `init.yaml` in multipass directory and paste your ssh key!
