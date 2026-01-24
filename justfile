set quiet

[default]
_list-recipes:
  {{quote(just_executable())}} --list --justfile={{quote(justfile())}}

# Regenerate `python3-requirements.json`
gen_py_deps:
  #!/usr/bin/env bash
  set -euo pipefail
  
  # download upstream requirements.txt as requirements.in
  IMAGINER_VERSION="$(jq --raw-output '.modules[] | select(type=="object" and .name=="imaginer") | .sources[0].tag' page.codeberg.Imaginer.Imaginer.json)"
  wget --quiet --output-document=requirements.in "https://codeberg.org/Imaginer/Imaginer/raw/tag/${IMAGINER_VERSION}/requirements.txt"

  # compile proper requirements.txt from requirements.in
  pip-compile --quiet requirements.in

  # compile Flatpak module JSON from requirements.txt
  req2flatpak --requirements-file requirements.txt --target-platforms 313-x86_64 313-aarch64 --outfile python3-requirements.json

  # clean up
  rm -f requirements.in requirements.txt

# Build the Flatpak locally
build:
  flatpak run org.flatpak.Builder --ccache \
                                  --repo=repo \
                                  --force-clean \
                                  --sandbox \
                                  --mirror-screenshots-url=https://dl.flathub.org/media/ \
                                  --install-deps-from=flathub \
                                  --install \
                                  --user \
                                  build \
                                  page.codeberg.Imaginer.Imaginer.json \
                                  &> build.log
