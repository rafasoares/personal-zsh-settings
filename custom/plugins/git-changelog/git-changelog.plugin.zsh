function extract-issues() {
  text=$1
  link="https://$JIRA_LOGIN.atlassian.net/browse"

  while read item; do
    [[ "$item" =~ '[A-Z]+-[0-9]+' ]] && echo "[$MATCH]: $link/$MATCH"
  done <<< "$text"
}

function git-changelog() {
  ref=$1
  log=$( git log "$ref"..HEAD --pretty=format:'* %s (%h)' )
  issues=$( extract-issues "$log" )

  read -rd '' output <<OUTPUT
## CHANGELOG

$log

$issues
OUTPUT

  pbcopy <<< "$output"

  echo "$output"
  echo "\n\n** Copied changelog to the clipboard **"
}

alias gchlg='git-changelog'
