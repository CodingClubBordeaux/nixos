# NixOS in the Coding Club

This is the NixOS configuration for the Coding Club's computers at
[Epitech](https://www.epitech.eu/) Bordeaux.


## Installation

### Install ISO

- Install the Graphical NixOS iso for x86_64 linux with Gnome
  ([here](https://nixos.org/download#nixos-iso)) (or you can use the minimal
  iso, in the end it will use the same config)
- Dump a usb stick with the iso (with *balena etcher* for example)
- Plug it in the computer and boot on it
- Select normal installation mode
- Wait for Gnome to start

### Install NixOS

- If the device is not connected to the internet, connect it to a network.
  For Epitech IONIS network, go into Settings app, go to wifi, select `IONIS`,
  select `PEAP` in the Authentication field, select `No CA certificate is
  required`, and fill in your login and password from Epitech (be careful, the
  keyboard layout is in qwerty).
- Once done, go to the installer (if the message saying that the device is not
  connected to the internet is still there, close the window et re-lauch
  `Install System` app)
- Select Paris timezone
- Select French (AZERTY) keyboard layout
- Create the user `Guest` with the default password we use (ask around if you
  don't know it)
- Select Gnome as the desktop environment
- Check YES for the Unfree software
- Select to wipe the whole computer and install NixOS, (with swap and hibernate
  if possible)
- Wait for the installation to finish

### Post-installation

- Reboot the computer
- Log in with the `Guest` user
- Open a terminal
```sh
sudo nixos-rebuild switch --impure --flake github:CodingClubBordeaux/nixos#default
```


## Update

Open a terminal and run
```sh
sudo nixos-rebuild switch --impure --flake github:CodingClubBordeaux/nixos#default
```
> Replace `default` by the name of the configuration you want to use (for
> example `java` or `python`)
