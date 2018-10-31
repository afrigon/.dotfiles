ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"

function echo_ok() {
    echo -e "$COL_GREEN[ok]$COL_RESET "$1
}

function echo_running() {
    echo -en "$COL_YELLOW ⇒ $COL_RESET"$1": "
}

function echo_warn() {
    echo -e "$COL_YELLOW[warning]$COL_RESET "$1
}

function echo_error() {
    echo -e "$COL_RED[error]$COL_RESET "$1
}

function echo_fatal() {
    echo_error $1
    exit 1
}

function can_exec() {
    if type "$1" >/dev/null 2>&1; then
      return 0
    else
      return 1
    fi
}

function is_macos() {
    if [[ "$OSTYPE" =~ ^darwin ]]; then
        return 0
    else
        return 1
    fi
}

