# cfx-swr-persistant-spawn

Persistent spawn resource for FiveM using a local SQLite3 file.

## What it does

- On first spawn after joining, client asks server for spawn location.
- Server checks SQLite table for player's last saved coordinates.
- If found, player is moved there.
- If not found, player is moved to `defaultSpawn` from `config.json`.
- Position is saved periodically and on player drop.

## Files

- `fxmanifest.lua`
- `config.json`
- `server/main.js`
- `client/main.lua`
- `package.json`

## Setup

1. Open this resource folder in a terminal.
2. Install dependency:

   ```bash
   npm install
   ```

3. Add to your `server.cfg`:

   ```cfg
   ensure cfx-swr-persistant-spawn
   ```

4. Restart the server/resource.

## Config

Edit `config.json`:

- `dbFileName`: SQLite database file created in this resource folder.
- `defaultSpawn`: Used when a player has no saved location.
- `autoSaveIntervalMs`: How often client sends position updates.

## Commands

- `/setspawn`: Saves your current location as your persistent spawn point.

## Notes

- SQLite file is local to your server machine.
- Primary identifier preference: `license:` → `fivem:` → `discord:` → `steam:`.
