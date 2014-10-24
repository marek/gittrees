#!/usr/bin/env bash

# disoover GIT_WORK_TREE if git did not provide it
#if [ -z "$GIT_WORK_TREE"] && [ `basename "$GIT_DIR"` -eq ".git" ]; then
if [ -z "$GIT_WORK_TREE"] && [ `basename "$GIT_DIR"` == ".git" ]; then
    export GIT_WORK_TREE=`dirname "$GIT_DIR"`
fi

HOOK=`basename $0`                      # the name of the hook being called
HOOK_DIR=`dirname "$0"`                 # real .git/hooks directory
LOCAL_HOOK_DIR="$HOOK_DIR/local"        # .git/hooks/local subdirectory
DEFAULT_HOOK_DIR="$HOOK_DIR/default"    #.git/hooks/default

if [ -n "$GIT_WORK_TREE" ]; then
    # <project root>/hooks directory
    PROJ_HOOK_DIR="$GIT_WORK_TREE/hooks"
fi

# some hooks recieve data via standard in
HOOK_STDIN=`cat`


function run_hooks () {
    hook_dir="$1"
    hook_name="$2"

    for hook in "$hook_dir/$hook_name" "$hook_dir/$hook_name."*
    do
        echo "$hook"
        if [ -x "$hook" ]; then
            echo "running hook: $hook"
            echo "$HOOK_STDIN" | $hook "$@"
            if $?; then
                echo "Error running hook: `$hook`"
                exit 1
            fi
        fi
    done
}

# first run all the local, then project level then default
run_hooks "$LOCAL_HOOK_DIR" "$HOOK"
if [ -n "$PROJ_HOOK_DIR" ]; then
    run_hooks "$PROJ_HOOK_DIR" "$HOOK"
fi
run_hooks "$DEFAULT_HOOK_DIR" "$HOOK"

