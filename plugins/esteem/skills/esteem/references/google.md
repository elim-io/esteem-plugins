```toml
[google]  # `esteem google`, part of the `esteem` CLI: Sheets, Docs, Drive; over the connector `esteem_apps_read` and `esteem_apps_write`
auth = "the person's own Google connection, through the server: `esteem apps connect google` gives the link once; no token on the machine (ADR-0710)"
cmd = "commands are written without the leading `esteem google` (`sheets tabs <id>` = `esteem google sheets tabs <id>`)"
output = "compact TSV/text by default (tabs between cells, newline between rows; no JSON noise), saves context tokens; `--json` on any command gives raw Google JSON"
id = "`<id>` accepts a bare id or a full Google URL (`…/d/<ID>/edit`)"
inputs = "`VALUES` / `REQUESTS` / `TEXT` accept an inline string, `@file`, or `-` (stdin)"

[thrifty]  # token-thrifty rules, important
read = "read NARROW ranges, never whole sheets: `\"Sheet1!A1:D50\"`, not `\"A:Z\"`"
write = "big tables: write from `@file.tsv`, not a giant inline arg"
templating = "docs templating: `docs replace`, don't fetch + diff the whole doc"
formula = "a single formula/cell: `sheets formula`, don't round-trip the table"

[sheets]
tabs = "`sheets tabs <id>`: gid, title, rows x cols (tab-separated)"
read = "`sheets read <id> \"Sheet1!A1:D\"`: TSV; `--formulas` gives =FORMULAS, not values"
write = "`sheets write <id> \"Sheet1!A1\" $'a\\tb\\nc\\td'`: TSV in; `@grid.tsv`: whole table from a file; `'[[\"x\",1,true]]'`: typed JSON 2D"
append = "`sheets append <id> \"Sheet1!A1\" $'new\\trow'`: append rows after the table"
formula = "`sheets formula <id> \"Sheet1!E2\" \"=SUM(A2:D2)\"`"
clear = "`sheets clear <id> \"Sheet1!A1:D\"`"
create = "`sheets create \"Title\"`: prints id, url"
add_tab = "`sheets add-tab <id> \"2026\"`: prints gid"
batch = "`sheets batch <id> @requests.json`: raw spreadsheets.batchUpdate; takes a bare `[...]` requests array or a full `{\"requests\":[...]}` body; for merges, formatting, conditional rules, freezing, etc."
entered = "writes default to USER_ENTERED so `=FORMULA()`, numbers and dates parse; `--raw` stores strings literally"
types = "TSV input makes every cell a string (USER_ENTERED interprets it); use JSON 2D input when you need explicit numbers/bools"

[docs]
read = "`docs read <id>`: plain text (`--json` for structure)"
append = "`docs append <id> \"text to add\"`: add to the end"
replace = "`docs replace <id> \"{{name}}\" \"Maria\"`: replace ALL occurrences, swap specific text / fill a template; `--match-case`"
update = "`docs update <id> notes.md` (file path or `-` stdin): REWRITE the whole doc from Markdown; Drive re-converts in place, so the doc id/URL stay the same while content + formatting (headings, bold, lists, tables, links) are fully replaced (\"переписать целиком из md\")"
import = "`docs import notes.md --title \"Q3 Notes\"`: a NEW doc from Markdown (Drive converts)"
clear = "`docs clear <id>`: empty the body"
create = "`docs create \"Title\"`: prints id, url"
batch = "`docs batch <id> @requests.json`: raw documents.batchUpdate; surgical / styled edits (insert at index, delete a range, format runs, tables, images)"
markdown = "`update`/`import` let Drive do the conversion; don't parse markdown yourself"
middle = "there is no \"insert markdown into the middle of an existing doc\" primitive: edit the source .md and `docs update`, or `batch` with explicit structural requests"

[drive]  # find, share, permissions, delete
find = "`find \"Q3 Budget\"`: prints id, kind, name, url (also `drive find …`); `find \"Roadmap\" --type doc` filters, sheet | doc"
ls = "`drive ls https://drive.google.com/drive/folders/<id>`: a folder by id or folder URL, `root` = My Drive; prints id, kind, name, url; folders first, `--limit 100`"
share = "`drive share <id> [scope] [--role R] [--notify]`: scope = who, `--role` = how; `<id>` is id or URL"
anyone = "`share <id> --anyone`: ALL, anyone with the link"
domain = "`share <id> --domain acme.co`: ORGANIZATION, the whole domain"
user = "`share <id> --user maria@acme.co`: PRIVATE, a specific user; repeatable: `--user a@x.co --user b@x.co --role editor`"
combine = "scope flags combine freely in one call; each becomes its own grant"
roles = "`editor` (writer), `commenter` (default), `viewer` (reader): `share <id> --user maria@acme.co --role viewer --notify`"
notify = "notifications are off by default: users get silent access unless `--notify`"
owner = "sharing with the file's owner is a no-op (returns the existing owner grant)"
perms = "`drive perms <id>`: prints permId, type, role, who"
rm = "`drive rm <id>`: to trash (recoverable in Drive); `rm <id> --hard`: permanent delete, irreversible"

[flow]  # typical: locate, inspect, act (read narrow, write narrow)
locate = "`find \"Projects\" --type sheet`"
inspect = "`sheets tabs <id>`, then the header row only: `sheets read <id> \"Projects!A1:F1\"`"
act = "`sheets append <id> \"Projects!A1\" $'NewCo\\tActive'`"

[errors]
exit = "non-zero exit on failure, message on stderr (`error: Google API 403: …`)"
auth = "the person's own Google connection, through the server: `esteem apps connect google` gives the link once; no token on the machine (ADR-0710)"
forbidden = "403 usually means the relevant API isn't enabled or the file isn't shared with the authenticated account"
```
