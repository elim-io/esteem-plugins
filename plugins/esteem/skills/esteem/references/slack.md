```toml
[slack]  # `esteem slack`, part of the `esteem` CLI; over the connector `esteem_apps_read` and `esteem_apps_write`
auth = "the person's own Slack connection, through the server: `esteem apps connect slack` gives the link once; no token on the machine (ADR-0710)"
output = "compact text: one line per message, names instead of ids, dates in the person's time zone; `--json` on any command gives the raw Slack JSON"
whoami = "`whoami`: who the connection belongs to and the time zone used for output"
cmd = "commands are written without the leading `esteem slack` (`read ...` = `esteem slack read ...`)"

[read]
channel = "`read '#finance'`: newest 50, oldest first"
window = "`read '#general' -n 200 --since 2d`: since takes 2d 6h 30m 1w, 2026-10-01 or a ts; also `--until`"
link = "`read 'https://acme.slack.com/archives/C0…/p1760…'`: a link gives that whole thread"
ts_form = "`read C0123ABCD/1760270580.123456`: the same, CHANNEL/TS form"
dm = "`read @maria`: DM with a person (@handle, name, email, U… or D…)"
ts = "`read '#general' --ts`: every message's ts (to react/edit/reply to one)"
threads = "`read '#general' --threads`: each thread's replies printed under its message"
links = "`read '#general' --links`: each message ends with its permalink"
info = "`info '#general'`: topic, purpose, creator, members, canvases, pins, bookmarks"
replies = "a message with replies prints `↳ 5 replies, last 15:10 → read C0…/1760…`: run exactly that to open the thread, or read the channel with `--threads`"
files = "files show as `[file F0… name.pdf pdf 240 KB]`; a Google Drive file shared into Slack as `[gdrive name https://drive.google.com/…]`: Slack has only the link, open it with `esteem google`"
bots = "bot posts (alerts, form leads, Better Stack) print their full blocks, not just the notification line"
big = "big reads go to a file and get Read from there, not dumped into the conversation"

[watch]  # what is new since the last look
cmd = "`read '#esteem-feedback' --threads --ts --since \"$(< last-ts)\"`"
effect = "with `--threads` and `--since` together, read returns only what came after that ts: new messages, and new replies in old threads too"
old = "an old message prints as one line `(earlier) …` with just its new replies under it, so you see what each reply answers"
newest = "the header ends with `· newest <ts>`: the newest message in the channel, replies included; save it and pass it as `--since` next time"
empty = "`0 messages` means nothing new"
scan = "covers the latest 200 messages (`-n` changes that) and warns when older ones went unscanned"

[recipes]  # what agents actually needed
answer = "'what did he answer', everything after a message you already saw: `read D0123ABCD --since 1789469980.659299`"
research = "a client channel to the bottom, the full history with every thread, quotable: `read '#client-acme' -n 100000 --threads --links > acme-slack.txt`, then Read the file"
canvases = "`info '#client-acme'`: its canvases (open with `file F…`) and pinned recaps"
form = "did the site form / alert reach Slack: `search 'in:#new-requests after:2026-10-01' -n 5`, `read '#status' -n 10`"
find = "a channel by name, archived ones too: `channels --archived acme`; a bot user: `users 'better stack'` (bots are listed with (bot))"

[search]
usage = "`search 'invoice in:#finance after:2026-09-01'`; `search 'from:@anton \"exact phrase\"' -n 50 --relevance`; `search 'report' --files`"
syntax = "Slack's own query syntax: `in:#chan in:@person from:@person to:me after:/before:/on:YYYY-MM-DD during:month has:link has:pin is:thread`"
hits = "each hit ends with `→ read C…/TS` (for a reply, its thread root); newest first by default, `--relevance` for best match; text is cut at 500 chars: `read` the hit for the whole message"

[lists]  # channels, people, files
channels = "`channels [filter]`: what the person is in: channels, DMs (@name), group DMs"
all = "`channels --all [filter]`: every public + private channel, marks (not a member)"
archived = "`channels --archived [f]`: the same plus archived ones, marked (archived)"
members = "`members '#general'`: bots marked (bot)"
users = "`users [filter]`: id, @handle, name, title, email; bots marked (bot)"
file = "`file F0123ABCD`: downloads, prints the local path (~/.cache/esteem/slack/files); `file '<slack file url>' -o ./x.pdf`"
canvas = "a canvas (`[file F… … quip]`) is saved as Markdown-ish text: Read the printed path; images come out as files you can Read too"

[write]  # only when the person asked for it
rule = "messages go out AS the person, under their name, to real people: post only what they asked to post; a request for a draft = show the text and wait"
send = "`send '#general' 'Deploy is done'`; the text is mrkdwn: *bold* _it_ `code` <https://x|label>; prints the permalink"
reply = "`send 'https://…/archives/C…/p…' 'On it'`: a link replies in that thread; `send C0…/1760….123456 'Fixed in a1b2c3'`: the same, CHANNEL/TS"
dm = "`send @maria - <<'EOF' … EOF`: DM, long text from stdin"
upload = "`upload C0…/1760….123456 shot.png rec.mp4 --comment 'Готово'`: files as the person, all in one message, the target as `send` (a link or CHANNEL/TS = into that thread, `@me` = his own DM, `--thread TS`); prints each file's link; the message's own link: `read <target> --links` (Slack shares the files a moment after the command returns)"
edit = "`edit C0…/1760….123456 'corrected text'`: only the person's own messages"
react = "`react C0…/1760….123456 white_check_mark`"
mentions = "in text: `<@U0123>` (ids from `users`), `<!here>`"

[api]
call = "`api <method> key=value …`: any Web API method through the same connection, prints JSON; `api pins.list channel=C…`, `api bookmarks.list channel_id=C…`, `api canvases.edit …`, `api reminders.add text=… time=…` (scopes permitting)"

[fails]
revoked = "not connected or needs a reconnect: the error gives the link; open it, then repeat the command"
scope = "`missing_scope … needs X`: the connection does not hold it; say so to the person, an Owner adds it to the app"

[traps]
mcp = "do not use the claude.ai Slack MCP tools; this CLI replaces them"
grep = "never grep or awk the full channel for what is new: without `--threads`, `--since` drops a reply that lands in an old thread"
test = "never send \"test\" messages"
```
