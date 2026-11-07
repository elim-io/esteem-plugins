# Esteem for Claude Code

Puts the `esteem` command on the PATH of Claude Code, so Claude works with Esteem from the disk: files,
estimates built from a spec, exports, and your own Slack, Notion and Google. It needs the esteem plugin,
which carries the skill, and installs it with this one.

## Use it

    /plugin marketplace add elim-io/esteem-plugins
    /plugin install esteem-code@esteem

Install it in Claude Code or the Code tab of Claude Desktop. The first session downloads the CLI for this
machine from cli.esteem.team, checks its SHA-256 and keeps it in ~/.local/bin (Windows:
%LOCALAPPDATA%\Programs\esteem); later sessions find it there. Sign in once with `esteem auth login`.

## Data

The CLI talks to api.esteem.team with your own Esteem sign-in. The plugin itself stores nothing.
