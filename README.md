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

#### Soul Shards

This Addon can handle Soul Shards.

Soul Shards are always sorted from your left outer bag to your rucksack.
Soul pouches are supported but not preferred, so best practice is placing your soul pouch as your the left outer bag.

Soul Shards are sorted at login and when a new Soul Shard is created. Also a slash command is provided to sort manually.
```
/wss sort
```

You can also us a shortcut.
```
/wss s
```
#### Macros

tba

## Built With

* [AceLocale-3.0](https://www.wowace.com/projects/ace3/pages/api/ace-locale-3-0) - Manages localization in addons
