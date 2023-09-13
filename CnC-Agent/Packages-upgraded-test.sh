packages=$(apt-get -s --no-download dist-upgrade -V --fix-missing | grep '=>')

echo $packages