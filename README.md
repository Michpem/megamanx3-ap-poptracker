# Mega Man X3 Archipelago Tracker for PopTracker

This is a PopTracker pack for Mega Man X3 Archipelago. Created by MeridianBC.

![](https://raw.githubusercontent.com/BrianCumminger/megamanx3-ap-poptracker/master/images/screenshot.png)

## Installation

Just download the lastest build or source and put in your PopTracker packs folder.

## Features
Detects and tracks most logic as of Mega Man X3 AP 1.1.2 including:

- Pickupsanity
- Jammed buster
- Doppler and Vile access conditions (medals/weapons/upgrades/heart/sub/access codes)
- Boss weaknesses required
  
Includes individual stage maps showing item locations, with the option to automatically switch tabs (on by default).

What's not handled:
- Shuffled boss weaknesses - see usage section for details.

## Usage
When using Archipelago auto tracking, logic settings will all be set automatically.  For manual operation (or to check which settings are active), click on the "Open Pack Settings" button at the top of PopTracker while this pack is loaded.

Brief notes for various settings when not using autotracker:
- Dr. Doppler and Vile options: sets the access requirements for Dr. Doppler Labs and Vile's Stage  If all of these are blank or set to 0, the associated stage will unlock when access codes are acquired.
- Bosses Require (Unshuffled) Weaknesses: Does not map directly to a yaml option.  If boss weaknesses are required by logic (`logic_boss_weakness: true`) and weaknesses are unshuffled (`boss_weakness_rando: vanilla`), this will show bosses as being in logic only if you have their required weakness.  Otherwise, bosses will always be shown as in logic if you can reach them.
- Jammed Buster: yaml option `jammed_buster` - adds an extra arm upgrade to the pool.  A jammed buster is indicated by a grayed out arms icon with a blue down arrow.
- There are a few access requirements (notably number of boss refights completed) which only update when an item changes.


## More Info

Check out PopTrackers Documentation on packs [here](https://github.com/black-sliver/PopTracker/blob/master/doc/PACKS.md)

Still having trouble realizing your pack and looking for help or just want more information about everything PopTracker? Check out the ['Unofficial' PopTracker Discord Server](https://discord.com/invite/gwThqMCPgK)!

## License

Public Domain