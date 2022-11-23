#!/data/data/com.termux/files/usr/bin/bash

if test ! -f /data/data/com.termux/files/usr/bin/chdman;
then

	echo "Installing dependencies:"

        pkg install -y x11-repo
        pkg install -y git build-essential lld sdl2 binutils

	echo "Cloning the repo and building:"
	    wget https://github.com/Pipetto-crypto/mame/archive/refs/heads/termux-chdman.zip
	    unzip termux-chdman.zip
	    cd mame-termux-chdman
	    bash build-chdman.sh
fi

read -p 'Where are your games located(absolute path):' location

if test ! -f $location/conversion.sh;
then
	echo "Creating conversion script in games folder:"
	touch $location/conversion.sh
	chmod a+rwx $location/conversion.sh
        echo 'for i in *.gdi' >> $location/conversion.sh
        echo 'do' >> $location/conversion.sh
        echo '  chdman createcd -i "$i" -o "${i%.*}.chd"' >> $location/conversion.sh
        echo '  rm -vi "$i"' >> $location/conversion.sh
        echo 'done' >> $location/conversion.sh
fi
cd  $location
echo "Starting conversion of all your games"
bash conversion.sh
echo "Done, Leaving"
cd ~
