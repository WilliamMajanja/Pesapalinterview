#!/bin/bash

function usage() {
  echo "Usage: sourcectrl <command> [args]"
  echo "Available commands:"
  echo "  init      Initialize a new Git repository"
  echo "  status    Show the working tree status"
  echo "  add       Add files to the staging area"
  echo "  commit    Commit changes to the repository"
  echo "  push      Push commits to a remote repository"
  echo "  pull      Pull changes from a remote repository"
  echo "  branch    Create, list, or delete branches"
  echo "  checkout  Switch branches or restore working tree files"
  echo "  log       Show commit history"
}

case "$1" in
  init)
    git init
    ;;
  status)
    git status
    ;;
  add)
    git add "$2"
    ;;
  commit)
    git commit -m "$2"
    ;;
  push)
    git push origin "$2"
    ;;
  pull)
    git pull origin "$2"
    ;;
  branch)
    case "$2" in
      -a|--all)
        git branch -a
        ;;
      *)
        git branch "$2"
        ;;
    esac
    ;;
  checkout)
    git checkout "$2"
    ;;
  log)
    git log
    ;;
  *)
    usage
    ;;
esac
