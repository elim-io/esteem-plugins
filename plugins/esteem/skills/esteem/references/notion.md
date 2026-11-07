```toml
[notion]  # `esteem notion`, part of the `esteem` CLI; over the connector `esteem_apps_read` and `esteem_apps_write`
auth = "the person's own Notion connection, through the server: `esteem apps connect notion` gives the link once; it reaches the pages chosen at that connect; no token on the machine (ADR-0710)"
links = "any Notion link works wherever a page or database is asked for (`?v=` view links and `?p=` peek links too)"
output = "compact text; anything over 30 KB goes to a file and the command prints its path: Read that file"
me = "`me`: who the connection is"
cmd = "commands are written without the leading `esteem notion` (`get <link>` = `esteem notion get <link>`)"

[read]
get = "`get <link>`: page title, row properties, Markdown (file links cut short), ALL comments (or \"none\")"
deep = "`get <link> --deep`: + every subpage (4 levels) and rows of databases inside"
db = "`get <database link>`: schema, views, first 50 rows"
find = "`find <words>`: title search, prints kind id title edited (the API has no full-text search)"
comments = "`comments <page>`: time author (on «commented text / image name»): text [discussion id]"
files = "`files <page>`: downloads every image/file of the page, prints local paths (Read them)"
all_comments = "\"all comments\" = the page's own thread and inline ones on text, images and files inside, each with the place it is pinned to; reply in that thread with `comment <page> \"…\" --reply <discussion id>`"

[databases]
schema = "`schema <db>`: columns, types, select options"
query = "`query <db> 'Status!=Done' 'Сторона=Acme' -c '№,Task name,Status' -s '№'`"
ops = "conditions: `a|b` either (`'№=8|14|17'`); `Prop~text` contains; `Prop>n` `Prop<n`; `Prop?` set; `Prop!?` empty"
export = "`query <db> --all --csv > rows.csv`: export; `--json` for raw"
board = "`board <db link> [conditions]`: every card, properties + content + all comments, images downloaded, one file to Read (~15 s for 30 cards)"
set = "`set <row> Status=Done \"Task type=💬 Feature request,💅 Polish\" Due=2026-10-20 Owner=`: an empty value clears"
new_row = "`new <db> -t \"Title\" Status=Todo -c @body.md`: new row (properties + Markdown body)"
new_page = "`new <page> -t \"Recap 13.10\" -c - <<'EOF' … EOF`: new subpage, body from stdin"
prop = "`prop <db> \"Сторона\" \"multi=Acme:green,Globex:blue\"`: add/change a column; `--rename X`, `--delete`"
newdb = "`newdb <page> \"Tickets\" \"Task:title\" \"Status:select=Todo,Done:green\" \"Due:date\"`"
views = "`views <db>`"
view = "`view <db> \"Ждут Acme\" --type table --show \"№,Task name,Status\" -w \"Сторона=Acme\" -w \"Status!=Done\" -s Priority`; `view <db> \"Доска\" --type board --group Status --update <view id>`"
types = "conditions and values follow each column's type (select, status, multi-select, number, date, checkbox, people, relation, unique id like `№`)"
view_link = "a view link (`?v=`) in `query`/`board` applies that view's own filter and sort"

[relayout]  # write and re-lay out a page: three calls
pull = "`pull <link>`: prints the page as Notion Markdown with a header; saves a backup"
push = "`push -`: the WHOLE edited text on stdin, header kept (`---` / `notion_page: <id from pull>` / `---`), only changed parts are sent; a local file line `![screenshot](/path/local.png)` is uploaded and placed right there"
shot = "`shot <link>`: screenshots (frames of the page, `shot-<n>.jpg`), Read the first; drives the browser through `er`, so the box only - elsewhere it refuses"
combined = "`push --shot` does push and shot together"
media = "keep every media line exactly as pulled (images, files, PDFs, with their captions): they never get re-created"
free = "everything else can change: callouts (`<callout icon=\"🏦\" color=\"gray_bg\">`), `<columns><column>…`, `<table header-row=\"true\">`, `<h2 color=\"blue\">`, toggles, colors"
syntax = "developers.notion.com/guides/data-apis/notion-flavored-markdown.md"
guards = "push refuses if the page changed since pull (`--force` overrides), prints which numbers/e-mails/links the edit removed or added (catch typos in requisites), re-reads the page and checks them"
undo = "the backup is the undo: `~/.cache/esteem/notion/<id>/backups/`"
time = "a re-layout of one page is a 3-4 minute job: no scratch-page rehearsal"

[small]  # smaller edits without pull
append = "`append <page> \"text, @file or -\"`"
comment = "`comment <page> \"Сделано, см. …\"`; `--reply <discussion id>` answers in a thread"
attach = "`attach <page> shot1.png shot2.png --after \"Плашка наезжает\" --caption \"после\"`"
move = "`mv <page> <new parent page or db>`; `trash <page>`"
api = "`api PATCH pages/<id> '{\"icon\":{\"emoji\":\"🏦\"}}'`: anything else; GET/POST/PATCH/DELETE, body @file or -"

[fails]
unauthorized = "not connected or needs a reconnect: the error gives the link; open it, then repeat the command"
not_found = "`404 object_not_found`: a page not chosen at the connect, or a block id instead of a page"

[traps]
mcp = "do not use the claude.ai Notion MCP (denied) or hand-written `ntn api` calls for what is here"
voice = "comments, pages and rows appear under the person's name to the team and clients: write only what they asked for"
```
