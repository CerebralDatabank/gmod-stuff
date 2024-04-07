# gmod-stuff

Stuff for Garry's Mod and general Source engine stuff :)

Some scripts require an external contraption, while others will function on their own (or attached to one thing such as an EGP screen).

Use caution when installing scripts from random sources - they may be malicious. It's a good idea to glance over the code if you can before you install.

## How to find your Garry's Mod directory

(a.k.a. `GMODGAMEDIR` in below instructions)

1. Open Steam
2. Go to the Library tab
3. Scroll down to or search for Garry's Mod and select it
4. Click the settings button (gear icon) on the bottom-right below the game picture
5. Go to Manage → Browse Local Files
6. If you want, click on the location bar in File Explorer or press Ctrl + L, copy the path, and do either or both of the following for easy access:
   1. Press Windows + R to open the Run dialog, paste in the path, and press Enter. It will now be saved in the Run dialog's suggestions dropdown.
   2. Press Windows + S, search for "Edit environment variables for your account", and press Enter. Click "New", paste the path into the "Variable value:" box, type `GMODGAMEDIR` (or whatever you want) in the "Variable name:" box, and press Enter. Click "OK" to close the box. You should now be able to access the folder using `%GMODGAMEDIR%` (or whatever name you chose) in the file explorer, Run dialog, command line, and other places. You can use it in whole paths, too; if you are installing a Wiremod script according to the instructions below, for example, you can type `%GMODGAMEDIR%\garrysmod\data` in the file explorer or Search to open that folder.

## How to install Wiremod scripts

1. Make sure the filename only contains lowercase letters, numbers, and underscores. (I'm not sure if more characters are allowed, but the default seems to be this.)
2. Go to `GMODGAMEDIR\garrysmod\data\`.
3. If the file is an Expression 2 script, ZCPU script, ZGPU script, or ZSPU script, place it in the `expression2`, `cpuchip`, `gpuchip`, or `spuchip` folder, respectively.
4. If the game is open, you can press the Update button in the respective chip's editor tool and it should show the new files.

## How to install dupes and saves

1. Make sure the filename only contains lowercase letters, numbers, and underscores. (I'm not sure if more characters are allowed, but the default seems to be this.)
2. Go to `GMODGAMEDIR\garrysmod`. Paste the `.dupe` file (and optionally the `.jpg` file) in the `dupes` folder if it is a dupe, or paste the `.gms` file (and optionally the `.jpg` file) in the `saves` (NOT `save`) folder.

## How to install GMod Lua scripts

1. Make sure the filename only contains lowercase letters, numbers, and underscores. (I'm not sure if more characters are allowed, but the default seems to be this.)
2. Go to `GMODGAMEDIR\garrysmod\lua`.
3. Paste the file into that folder; it can now be run in-game by running `lua_openscript FILENAME.lua` (or `lua_openscript_cl FILENAME.lua` to run the code client-side instead of server-side).