# VideoRecompress Studio plugin

Use **VideoRecompress Studio** from your AI agent on your Windows PC: shrinking video files with H.265/AV1 and GPU encoding, one file or a whole folder. The agent calls the app's tools
on files on your computer; nothing is uploaded to the model provider or to ContentaSoft to do the work. It works
with any agent that runs local MCP servers: Cursor, Claude Code, Codex, VS Code, Windsurf and others.

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

- **MCP server** `videorecompress-studio` with the tools `recompress_video`, `batch_recompress`, `analyze_video`, `estimate_savings`, `list_presets`. Each tool
  says whether it only reads files, writes new files, may overwrite files, or uses the internet.
- **Skill** `contenta-video`: how and when the agent should use those tools and the `videorecompress` command line.

## What runs and what is sent

- As a Claude plugin it runs `server/launch.cmd` from the plugin folder, which looks for `videorecompress.exe` in the app's
  install folder (`%LOCALAPPDATA%\Programs\VideoRecompressStudio`), on your `PATH` or in `Program Files`, and runs
  `videorecompress serve`. Nothing is downloaded. If the app is missing, the bundled Node launcher (`server/index.js`, the same
  bytes as the npm package `@contentasoft/videorecompress-mcp`, MIT, no dependencies; source: https://github.com/contentasoftware/mcp-launcher)
  or, without Node.js, the Windows PowerShell stub `server/stub.ps1` serves one tool, `get_started`. Neither sends
  anything over the network.
- The skill may only run the app's own command-line tool (`allowed-tools: Bash(videorecompress:*)`).
- The app processes local files only. It sends anonymous usage telemetry (which tools ran, which MCP client
  connected, trial state) to ContentaSoft; turn it off in the app's settings. Privacy policy: https://www.contenta-software.com/videorecompress/privacy.php
- The free trial has no end date: the first 10 files per PC are unrestricted, later ones are watermarked and cut at 10 minutes. `videorecompress status` shows how many free files are left; a batch spends one per file. Nothing stops working; a licence removes the limits.

## License

This plugin and the launcher are MIT-licensed (see LICENSE). VideoRecompress Studio itself is commercial software by
ContentaSoft AB.
