# VideoRecompress Studio plugin

Use **VideoRecompress Studio** from your AI agent on your Windows PC: shrinking video files with H.265/AV1 and GPU encoding, one file or a whole folder. The agent calls the app's tools
on files on your computer; nothing is uploaded to the model provider or to ContentaSoft to do the work. It works
with any agent that runs local MCP servers: Cursor, Claude Code, Codex, VS Code, Windsurf and others.

## Install

- **Cursor and other MCP clients** (`mcpServers` JSON): add
  `"videorecompress-studio": { "command": "npx", "args": ["-y", "@contentasoft/videorecompress-mcp"] }`. Or install it from
  cursor.directory.
- **Claude Code / Cowork**: install this repository as a plugin. It runs the bundled launcher in `server/`.
- More clients and options: https://www.npmjs.com/package/@contentasoft/videorecompress-mcp

## What you need

- Windows 10 or 11 with **VideoRecompress Studio** installed. It has a free trial: https://www.contenta-software.com/videorecompress/download.php
  (if it is not installed yet, the `get_started` tool gives the agent the download link and the steps).
- Node.js 18 or later, which runs the small launcher (MIT, no dependencies; the npm package `@contentasoft/videorecompress-mcp`,
  also bundled here as `server/index.js`; source: https://github.com/contentasoftware/mcp-launcher). The
  launcher starts the app's own MCP server (`videorecompress serve`) and passes its messages through; it sends nothing
  over the network itself.
- An agent that runs on that computer. Browser chat apps cannot start local programs, so they cannot use these
  tools.

## What is included

- **MCP server** `videorecompress-studio` with the tools `recompress_video`, `batch_recompress`, `analyze_video`, `estimate_savings`, `list_presets`. Each tool
  says whether it only reads files, writes new files, may overwrite files, or uses the internet.
- **Skill** `contenta-video`: how and when the agent should use those tools.

## What runs and what is sent

- As a Claude plugin it runs `node server/index.js` from the plugin folder, so nothing is downloaded; through
  `npx` the same launcher comes from npm. The launcher looks for
  `videorecompress.exe` in the app's install folder (`%LOCALAPPDATA%\Programs\VideoRecompressStudio`), on your `PATH`
  or in `Program Files`, and runs `videorecompress serve`. If the app is missing it serves one tool, `get_started`.
- The skill may only run the app's own command-line tool (`allowed-tools: Bash(videorecompress:*)`).
- The app processes local files only. It sends anonymous usage telemetry (which tools ran, which MCP client
  connected, trial state) to ContentaSoft; turn it off in the app's settings. Privacy policy: https://www.contenta-software.com/videorecompress/privacy.php
- During the trial some outputs carry a watermark or other limits; the tool results say so and link to the
  license.

## License

This plugin and the launcher are MIT-licensed (see LICENSE). VideoRecompress Studio itself is commercial software by
ContentaSoft AB.
