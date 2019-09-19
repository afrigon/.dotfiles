# Require variable for the gpg signing tool
export GPG_TTY=$(tty);

# ~/bin
export PATH=$PATH:/usr/local/sbin:$HOME/bin

# 010 Editor
export PATH="$PATH:/Applications/010 Editor.app/Contents/CmdLine"

# fastlane
export PATH=$PATH:$HOME/.fastlane/bin

# temp
export PATH=$PATH:$HOME/.local/bin

# Go
export PATH=$PATH:$(go env GOPATH)/bin

# Rust
export PATH=$PATH:$HOME/.cargo/bin
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# Cross compilers
export PATH="$HOME/opt/cross/bin:$PATH"

for file in ~/.{path,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# The next line enables shell command completion for gcloud.
if [ -f '/Users/frigon/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/frigon/google-cloud-sdk/completion.bash.inc'; fi

rm -Rf "$HOME/.config/SweetScape"

#if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#	exec tmux
#fi

