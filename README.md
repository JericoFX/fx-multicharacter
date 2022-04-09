# qb-multicharacter MODIFIED BY JERICOFX

Do not use yet, this version is re-written with Svelte so no more jquery bloated code this version here is modified to use for a particular server, i will release the "normal" version so everyone can use it

![Hi]https://img001.prntscr.com/file/img001/euHDZC4dShGmysoyyZ8S4w.png

![Hi]https://img001.prntscr.com/file/img001/6PDQ_mGUTsiq33dSikn4YA.png

# License

    QBCore Framework
    Copyright (C) 2021 Joshua Eger

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>

## Dependencies

- [qb-core](https://github.com/qbcore-framework/qb-core)
- [qb-spawn](https://github.com/qbcore-framework/qb-spawn) - Spawn selector
- [qb-apartments](https://github.com/qbcore-framework/qb-apartments) - For giving the player a apartment after creating a character.
- [qb-clothing](https://github.com/qbcore-framework/qb-clothing) - For the character creation and saving outfits.
- [qb-weathersync](https://github.com/qbcore-framework/qb-weathersync) - For adjusting the weather while player is creating a character.

## Screenshots

![Character Selection](https://i.imgur.com/EUB5X6Y.png) ![Character Registration](https://i.imgur.com/RKxiyed.png)

## Features

- Ability to create up to 5 characters and delete any character.
- Ability to see character information during selection.

## Installation

### Manual

- Download the script and put it in the `[qb]` directory.
- Add the following code to your server.cfg/resouces.cfg

```
ensure qb-core
ensure qb-multicharacter
ensure qb-spawn
ensure qb-apartments
ensure qb-clothing
ensure qb-weathersync
```
