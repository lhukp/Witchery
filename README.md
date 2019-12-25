# Witchery

Little helpers for your World of Warcraft Classic gaming experience

## Getting Started

This is my first try to create an addon, it is grown during my adventure to level 60 with my warlock.
The next steps are cleaning up, structuring and expanding. Support for other classes should also be promoted, especially for my twinks ;-)

This project is also intended to help me get started with git and GitHub.

### Installing

Just put it in your

```
_classic_/Interface/AddOns
```
Folder inside your World of Warcraft installation.

## What it does

Should make your gaming experience easier.

### Slash commands (general)

This addon provids the following general slash commands.

To reload the UI
```
/rl
```

To leave a party/raid
```
/lp
```

To reset instances
```
/ri
```

To start client support, eg. ticket
```
/gm
```

## Supported Casses

### Warlock

The Warlock module is loaded only, when your class is a Warlock. You can manually turn off components you do not need/like. This can easily done in the [Warlock setup LUA file](Classes/Warlock/Setup.lua).

Enables the Warlock module, use `false` to disable.
```
C.Warlock.Enabled = true
```

#### Soul Shards

This Addon can handle Soul Shards.

Enables the [***Warlock Soul Shard*** module](Classes/Warlock/Setup.lua), use `false` to disable. `C.Warlock.Enabled` has to be `true`.
```
C.Warlock.Soulshard.Enabled = true
```

Soul Shards are always sorted from your left outer bag to your backpack. Soul pouches are supported but not preferred.

> Best practice is placing your soul pouch as the left outer bag.

Soul Shards are sorted at login and when a new Soul Shard is created. Also a slash command is provided to sort manually.
```
/wss sort
```

You can also us a shortcut.
```
/wss s
```
#### Macros

This Addon can handle macros for your pets.

Enables the [***Warlock Macro*** module](Classes/Warlock/Setup.lua), use `false` to disable. `C.Warlock.Enabled` has to be `true`.
```
C.Warlock.Macro.Enabled = true
```
##### What it does
This module can place macros on your action bar for each pet you are using. E.g. if you are summoning an Imp, this module puts the macros you have for your Imp on the slots you defined to your action bars.

This also is defined in the [***Warlock Setup*** module](Classes/Warlock/Setup.lua)
E.g. for multiple slots/macros
```
C.Warlock.Macro.slotId = {61, 62}
```
E.g. for single slot/macro
```
C.Warlock.Macro.slotId = 61
```
> Use this to find the right slots

*ActionBar page 1: slots 1 to 12*
*ActionBar page 2: slots 13 to 24*
*ActionBar page 3 (Right ActionBar): slots 25 to 36*
*ActionBar page 4 (Right ActionBar 2): slots 37 to 48*
*ActionBar page 5 (Bottom Right ActionBar): slots 49 to 60*
*ActionBar page 6 (Bottom Left ActionBar): slots 61 to 72*

**Find the right name for your macros**

Use `/wwl dmn` to view the short names used for your pets. You should get a list like the following.

- Imp `imp`
- Voidwalker `vwr`
- Succubus `scs`
- Felhunter `fur`
- Felguard `fgd`
- Inferno `ieo`
- Doomguard `dgd`

The macro name is build with the pet short name e.g. `scs` for your Succubus plus the slot id e.g. `61`.
In this case the full macro name is `scs61`.

You can also use macro fallback, if you need 1 macro for all pets. In this case this module searches for a fallback macro, if no pet specific macro is found. To name the fallback macro use `pet` plus the slot id e.g. `61`.

To illustrate this, my config uses 2 slots, one macro for all pets that handles attack/stop. The second slot holds specific pet abilities macro like `Seduce`, `Devour Magic`, `Sacrifice`, ...

Slots I am using are `61` and `62`.
So my macros named:
- `pet61` for *all pets*, equipped to slot id *61*
- `imp62` for *Imp*, equipped to slot id *62*
- `vwr62` for *Voidwalker*, equipped to slot id *62*
- `scs62` for *Succubus*, equipped to slot id *62*
- `fur62` for *Felhunter*, equipped to slot id *62*

and so on ...

*more to come*

## Built With

* [AceLocale-3.0](https://www.wowace.com/projects/ace3/pages/api/ace-locale-3-0) - Manages localization in addons
