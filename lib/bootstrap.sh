#!/bin/sh

readonly brew_path="/usr/local/bin/brew"

exists_homebrew() {
  return $(type "brew" >/dev/null 2>&1)
}

install_homebrew() {
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

update_homebrew() {
  echo 'brew update'
  ${brew_path} update
  echo 'brew doctor'
  ${brew_path} doctor
  echo 'brew cleanup'
  ${brew_path} cleanup
  return 0
}

bundle_execute() {
  echo 'brew bundle'
  ${brew_path} bundle
}

selectable() {
  while true; do
    echo "${1}"
    read -r answer
    case ${answer} in
    'yes' | 'y')
      return 0
      ;;
    'no' | 'n')
      return 1
      ;;
    *)
      printf "cannot understand %s.\n" "${answer}"
      ;;
    esac
  done
}

call_exit() {
  echo "${1}"
  exit 0
}

## execute
selectable 'Starting dotfiles installation? [yes/no]: ' || call_exit 'See you.'
exists_homebrew || install_homebrew
update_homebrew
call_exit 'completed.'
