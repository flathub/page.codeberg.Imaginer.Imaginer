# Flathub's Flatpak manifest for [**Imaginer**](https://imaginer.codeberg.page)

## Development

### Regenerate `python3-requirements.json`

To regenerate the `python3-requirements.json` file that specifies Python package build dependencies, install [`pip-tools`](https://pypi.org/project/pip-tools/) and [`req2flatpak`](https://johannesjh.github.io/req2flatpak/main/introduction.html):

```sh
uv tool install pip-tools
uv tool install req2flatpak
```

Then run:

```sh
just gen_py_deps
```

### Build the Flatpak locally

To build the Flatpak locally, install [`flatpak-builder`](https://docs.flatpak.org/en/latest/flatpak-builder-command-reference.html) from [Flathub](https://flathub.org/apps/org.flatpak.Builder)) and then run:

```sh
just build
```

In the underlying `flatpak-builder` command, all output (`stdout` and `stderr`) is written to the file `build.log` for convenience. Also, the locally built Flatpak is installed directly afterwards (thanks to the `--install` flag).

### Run the locally built Flatpak

To test the locally built Flatpak, run:

```sh
flatpak run page.codeberg.Imaginer.Imaginer
```

To just open a terminal inside the locally built Flatpak instead, run:

```sh
flatpak run --command=bash page.codeberg.Imaginer.Imaginer
```
