#!/usr/bin/env bash

set -e
set -x

# ## Upgrades all global pip packages
echo "Upgrading pip packages..."
for pip_pkg in $(sudo -H pip list --outdated | cut -d ' ' -f1); do
  sudo -H pip install -U "$pip_pkg"
done
echo "Done upgrading pip packages..."

# ## Upgrades all global pip3 packages
echo "Upgrading pip3 packages..."
for pip_pkg in $(sudo -H pip3 list --outdated | cut -d ' ' -f1); do
  sudo -H pip3 install -U "$pip_pkg"
done
echo "Done upgrading pip3 packages..."

# ## Upgrades all global rubygems
echo "Upgrading gem packages..."
for gem_pkg in $(sudo -H gem outdated | cut -d ' ' -f1); do
  sudo -H gem update --force --no-document "$gem_pkg"
done
echo "Done upgrading gem packages..."

#get list of global npm packages
echo "Upgrading node packages..."

CURDIR=$(pwd)
tmpfile="npmpkgs"

npm list -g --parseable --depth=0 | cut -d/ -f6 | sed -e '/^$/d' > "$tmpfile"
while IFS= read -r npmpkg; do 
 if [ "$npmpkg" == "@angular" ]; then
    npm install -g @angular/cli
    continue
 fi
npm install -g "$npmpkg"
done < "$tmpfile"
rm "$tmpfile"
echo "Done upgrading node packages."


