# VideoRecompress Studio plugin

Use **VideoRecompress Studio** from your AI agent on your Windows PC: shrinking video files with H.265/AV1 and GPU encoding, one file or a whole folder. You ask in plain words and the
agent does the work on files on your computer. It works with any agent that runs local MCP servers: Cursor,
Claude Code, Codex, VS Code, Windsurf and others.

## Ask your agent

- "Shrink the videos in my phone backup folder and tell me how much space I got back."
- "Compress my drone footage, but test one clip first and show me the quality score."
- "Make this video small enough to send on WhatsApp."

VideoRecompress Studio also works without an agent: open it from the Start menu and work in its own window.

## Price and trial

- $79, a one-time purchase. No subscription needed. Prices: https://www.contenta-software.com/videorecompress/buy.php
- The free trial has no end date: the first 10 files per PC are unrestricted, later ones are watermarked and cut at 10 minutes. `videorecompress status` shows how many free files are left; a batch spends one per file. Nothing stops working; a licence removes the limits.

## Install

**Claude Code** (Windows): two commands, typed inside Claude Code. This repository is its own one-plugin
marketplace, named after the repository:

```
/plugin marketplace add contentasoftware/videorecompress-studio-plugin
/plugin install videorecompress-studio@videorecompress-studio-plugin
```

From a terminal the same is `claude plugin marketplace add contentasoftware/videorecompress-studio-plugin` and `claude plugin install videorecompress-studio@videorecompress-studio-plugin`.
Cowork and the Claude.ai directory: install **VideoRecompress Studio** from the directory once it is listed.

**Cursor, Claude Desktop, VS Code, Codex and other MCP clients** (`mcpServers` JSON):
`"videorecompress-studio": { "command": "cmd", "args": ["/c", "npx", "-y", "@contentasoft/videorecompress-mcp"] }` (needs Node.js 18+), or,
once the app is installed, `"videorecompress-studio": { "command": "videorecompress", "args": ["serve"] }` with no Node.js at all.
Client-by-client instructions: https://www.npmjs.com/package/@contentasoft/videorecompress-mcp

## What you need

- Windows 10 or 11 with **VideoRecompress Studio** installed. It has a free trial: https://www.contenta-software.com/videorecompress/download.php
  (if it is not installed yet, the `get_started` tool gives the agent the download link and the steps).
- Nothing else for the Claude Code plugin: its launcher is a Windows batch file (`server/launch.cmd`) that starts the
  app's own MCP server. Node.js is not required; only the `npx` route for other clients needs it.
- An agent that runs on that computer. Browser chat apps cannot start local programs, so they cannot use these
  tools.

## What is included

- **MCP server** `videorecompress-studio` with the tools `recompress_video`, `batch_recompress`, `get_file_info`, `estimate_savings`, `list_presets`, `list_formats`, `get_license_status`. Each tool
  says whether it only reads files, writes new files, may overwrite files, or uses the internet.
- **Skill** `contenta-video`: how and when the agent should use those tools and the `videorecompress` command line.

## For developers

- Windows 10 and 11, 64-bit only. There is no macOS or Linux version.
- `videorecompress` never waits for input or shows a dialog, so it runs unattended from Task Scheduler or a script.
  To compress each new video saved to a folder while you are signed in, start `watch` at logon; it runs until you sign out or close its window:

  ```
  schtasks /create /tn "VideoRecompress Studio watch" /sc onlogon /tr "videorecompress watch D:\Camera -o D:\Compressed --preset phone_archive"
  ```
- Every command takes `--json` and prints one JSON object on stdout (logs go to stderr): `success`, `exitCode`, `error`, `warnings`, `errors` and `outputs`, plus the trial fields when they apply. Add `--progress` for one `{"type":"progress",...}` line per finished file before that object.
- Exit codes: 0 done · 1 unexpected error · 2 invalid arguments · 3 input not found or unreadable · 4 some items failed (the others are written) · 5 nothing succeeded · 6 the licence or trial refused the run · 130 cancelled. The four ContentaSoft command lines share this table.
- The skill (`skills/contenta-video/SKILL.md`) tells the agent which commands to use.

## Full CLI and MCP reference

Every `videorecompress` command, option and exit code, the JSON output and every MCP tool with its parameters:

- Command line: https://github.com/brunojanvier77/ContentaSoft/blob/main/videorecompress/cli.md
- MCP server: https://github.com/brunojanvier77/ContentaSoft/blob/main/videorecompress/mcp-server.md

## Privacy

- Videos are compressed on this PC. They are not uploaded, and compressing needs no internet connection.
- The app sends usage statistics (which tools ran, which MCP client connected, trial state) and crash reports to
  ContentaSoft, tagged with a hashed machine ID. They never contain your files; a crash report can contain a file
  name, but folder paths are removed. To turn them off, open the app and
  go to Settings, Privacy: Send usage statistics and crash reports. The same switch covers the command line and the
  MCP server. On a PC where nobody opens the app, set `"allowUsageMetrics": false` in `%APPDATA%\VideoRecompressStudio\settings.json`.
- Privacy policy, with the full list of what is sent: https://www.contenta-software.com/videorecompress/privacy.php

## What runs

- As a Claude plugin it runs `server/launch.cmd` from the plugin folder, which looks for `videorecompress.exe` in the app's
  install folder (`%LOCALAPPDATA%\Programs\VideoRecompressStudio`), on your `PATH` or in `Program Files`, and runs
  `videorecompress serve`. Nothing is downloaded. If the app is missing, the bundled Node launcher (`server/index.js`, the same
  bytes as the npm package `@contentasoft/videorecompress-mcp`, MIT, no dependencies; source: https://github.com/contentasoftware/mcp-launcher)
  or, without Node.js, the Windows PowerShell stub `server/stub.ps1` serves one tool, `get_started`. Neither sends
  anything over the network.
- While Claude Code uses the skill, it can use the plugin's MCP tools and run the app's own command-line tool in Bash or
  PowerShell without asking (`allowed-tools: Bash(videorecompress *) PowerShell(videorecompress *) Bash(videorecompress.exe *) PowerShell(videorecompress.exe *) mcp__plugin_videorecompress-studio_videorecompress-studio`). That permission ends when you send your next message.
  Other commands follow your own Claude Code permission settings.

## License

This plugin and the launcher are MIT-licensed (see LICENSE). VideoRecompress Studio itself is commercial software by
ContentaSoft AB.
