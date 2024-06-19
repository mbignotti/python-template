#!/usr/bin/env bash

branch_name="$(git rev-parse --abbrev-ref HEAD)"
branch_regex="^(perf|package|bench|ci|chore|experimental|test|refactor|fix|feature|hotfix|build|release|doc)\/[a-zA-Z0-9-]+$"

for arg in "$@"; do
	shift
	case $arg in
		"-r" | "--regex")
			branch_regex=$1
		;;
	esac
done

if [[ ! $branch_name =~ $branch_regex ]]; then
	echo Error, invalid branch name \"$branch_name\". Branch name must match \"$branch_regex\"
	exit 1
fi

exit 0
