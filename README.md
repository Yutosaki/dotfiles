## my setting file

# how to use

run in your home directory (when you use apt)

```
apt update && apt install -y curl
```

```
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply Yutosaki
```

# caution!
if you can't use bat coz you got this messgage

` zsh: no such file or directory: /Users/sasakiyuto/dotfiles/bat/target/release/bat`

you have to run this command in `~/dotfiles/bat`
```
cargo build --release
```
<br>

# other
if you want to use multipass, you should change file name `init.yaml.template` to `init.yaml` in multipass directory and paste your ssh key!
