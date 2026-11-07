# Esteem

Esteem is the operating platform of a creative studio: deals and estimates, finance, projects with their
tasks and time, the recorded meetings and the hub. This plugin gives Claude the `esteem` skill, which says
how to enter a project, find a command and read a past call, and the Esteem connector.

## Use it

    /plugin marketplace add elim-io/esteem-plugins
    /plugin install esteem@esteem

Ask what is open in a project, what was agreed on last week's call with a client, or to log two hours on a
task. Claude reads through the connector's tools in Chat and Cowork and through the `esteem` CLI in Claude
Code (the esteem-code plugin installs it). Every write is confirmed by you first.

## Data

The connector signs in with your Esteem account (Esteem ID, OAuth) and sends the commands Claude runs to
mcp.api.esteem.team, which answers with what your role in your organization may see. The plugin stores
nothing itself.
