#!/bin/bash
##############################
# author: shigeki tanaka <dev@shigeki.tokyo>
# since: 20191108
##############################

readonly brew_path="/usr/local/bin/brew"

exists_homebrew() {
  # shellcheck disable=SC2046
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
  echo 'brew bundle cleanup'
  ${brew_path} bundle cleanup
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
  printf "%s.\n" "${1}"
  exit 0
}

## execute
selectable 'Start execution of the homebrew install? [yes/no]: ' || call_exit 'See you'
exists_homebrew || install_homebrew
update_homebrew
selectable 'Next execution of the bundle install? [yes/no]: ' || call_exit 'See ya'
bundle_execute
call_exit 'The homebrew and application has been installed.'
