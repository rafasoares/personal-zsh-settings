# Git Changelog ZSH/Oh My Zsh plugin (macOS)

This function generates a nicely formatted changelog, great for GitHub releases,
from the commit summaries since the specified revision/tag.

Usage:

```zsh
$ gchlg v1.0.0
## CHANGELOG

* [PROJ-1234] Adds new feature (#12) (a8e0465a)
* [DEV-456] Fixes a nasty bug (#11) (63e650ce)
* Bump lodash from 4.17.15 to 4.17.19 (#10) (31b6491d)

[PROJ-1234]: https://myorg.atlassian.net/browse/PROJ-1234
[DEV-456]: https://myorg.atlassian.net/browse/DEV-456


** Copied changelog to the clipboard **

```

If you then paste the copied text in a release's description, it should produce
an unordered list of changes, with links to the specific commits, PRs and JIRA
issues, if any.

It's designed to work with macOS's `pbcopy` utility and to play nicely with
GitHub's "Squash and Merge" strategy for PRs.
It doesn't work well with merge commits.
Rebase merges should work, but will likely generate a verbose changelog.

To make it work in other OSes, change `pbcopy` for the appropriate "copy to the clipboard" utility (eg. 'xclip' on Linux).

> Note: I'm being explicit about ZSH/OMZ here because it's where I tested the code.
> It **should** work on other shells, as long as there's support for the `=~` regex capture syntax.
>
> Feel free to modify this for your preferred shell.
> (I'd appreciate if posted the changes here, so other users might benefit)

## Installation

1. Create a folder named `git-changelog` inside your **Oh My Zsh** custom
plugins folder (usually `~/.oh-my-zsh/custom/plugins`)
2. Copy `git-changelog.plugin.zsh` to that folder
3. Add `git-changelog` to your plugins list in `~/.zshrc`.
