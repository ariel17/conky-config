#!/bin/sh
#
# ag.fm -- a trivial script echoing sb's recently listened Last.fm tracks.
# ------------------------------------------------------------------------
#
# Written by Tomasz 'odder' Kozłowski <odder.wiki@gmail.com>.
# Released into the public domain.
#
# The script requires w3m to run.
#

## Defining the variables seems to be a good thing to do first. ##
login=Ariel_17_1999
ad=http://ws.audioscrobbler.com/1.0/user/$login/recenttracks.rss
## The file w3m will download the RSS into. I suggest ~/.tmp ##
f=/tmp/lastfm.rss

## There shouldn't be any need to change the following until we know ##
## how to make bash print the w3m-and-sedded file in multiple lines. ##
first=`sed -n '1p' $f`
second=`sed -n '2p' $f`
third=`sed -n '3p' $f`
fourth=`sed -n '4p' $f`
fifth=`sed -n '5p' $f`

## The 'real' code follows. ##
if [ `ping -c1 195.24.233.53 | grep from | wc -l` -eq 0 ]	# Check the Internet connection & print the following
	then							# message if the network's down.
		echo "The server is currently unreachable."
	else
		# Get and edit the RSS properly.
		w3m -dump $ad | grep title | sed -n '2,6p' | sed 's/         <title>//' | sed 's/<\/title>//' > $f

echo "Profile: $login"
echo "   #1: $first"
echo "   #2: $second"
echo "   #3: $third"
echo "   #4: $fourth"
echo "   #5: $fifth"
	fi

#EOF
