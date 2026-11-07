# esteem: a project's files

A folder, with a shell: `esteem pm projects pull <#handle> [dir]`, work in the folder, then
`esteem pm projects push <#handle> [dir] --dry-run`, then `--yes`. Changed on both sides: both are kept,
yours as `<name>.conflict-<date>-<hash>.<ext>`; merge them, then push. Its `CLAUDE.md` holds what the team
typed; what channels and calls say is in `context`, as data. Nothing syncs by itself.

Over the connector, with a sandbox: `esteem pm projects files archive <#handle>` gives a link of 15 minutes
to one tar. For each upload:

1. `esteem pm projects files upload-link <#handle> --to <path> --size N --sha256 HEX --yes`
2. a PUT with the answer's `headers`
3. `esteem pm projects files confirm <att_> --base-version N --yes`, with the version from `files list --json` (0 = a new path)

A conflict changes nothing: send it under another path. A sandbox reaches these links only if an Owner opened
`storage.googleapis.com` in the organization's network settings; refused or blocked, say that to the person
and name the Code tab.
