# Flathub's Flatpak manifest for [**Imaginer**](https://imaginer.codeberg.page)

## Development

### Regenerate `python3-requirements.json`

To regenerate the `python3-requirements.json` file that specifies Python package build dependencies, install [`pip-tools`](https://pypi.org/project/pip-tools/) and [`req2flatpak`](https://johannesjh.github.io/req2flatpak/main/introduction.html):

```sh
uv tool install pip-tools
uv tool install req2flatpak
```

Then we need to determine the Python major-minor version shipped with the specified GNOME runtime. The [GNOME runtime](https://gitlab.gnome.org/GNOME/gnome-build-meta) is based on the [Freedesktop SDK](https://gitlab.com/freedesktop-sdk/freedesktop-sdk) – to determine which version exactly (e.g. `freedesktop-sdk-25.08.7`), see [this file](https://gitlab.gnome.org/GNOME/gnome-build-meta/-/blob/gnome-49/elements/freedesktop-sdk.bst?ref_type=heads#L7) in the corresponding branch (e.g. `gnome-49`). With this information, see the [Freedesktop SDK's `NEWS.yaml`](https://gitlab.com/freedesktop-sdk/freedesktop-sdk/-/blob/release/25.08/NEWS.yml) in the corresponding branch (e.g. `release/25.08`) to determine the Python version shipped (search for the latest `Update python3 to v` line).

Finally use that information to regenerate the `python3-requirements.json` file. The first argument to the `gen_py_deps` Just recipe corresponds to `req2flatpak`'s [`--target-platforms` argument](https://johannesjh.github.io/req2flatpak/main/cli.html#named-arguments). For Python 3.13, you'd run: 

```sh
just gen_py_deps '313-x86_64 313-aarch64'
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
