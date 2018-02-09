#!/usr/bin/env bash
# script to (re-)install all scripts/commands for multihost

version=3.0
default_branch=MOODLE_34_STABLE

if [ ! $1 ]
	then 
	echo "ERROR: No install path given - aborting!"
	exit 1
fi

if [ $2 ]
	then
	branch=$2
else
	branch=$default_branch
fi
#--------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------
echo " "
echo "install all qmplus plugins into $moodle_path/$moodle_name (v.$version)"
echo "---------------------------------------------------------------------------------------------------"
start_time=`date +%s`
home=$(pwd)
moodle_path=$1

echo "==> will install at: $moodle_path"

if [ -d $moodle_path ]
	then
	echo "HINT: A (Moodle?) installation '$moodle_path' already exists - skipping cloning the Moodle base!"
	cd $moodle_path
else
	echo "==> cloning Moodle from GitHub into $moodle_path"
	git clone git@github.com:moodle/moodle.git $moodle_path
#	git clone git@github.com:QMUL/qmplus.git $moodle_path

	if [ ! -d $moodle_path ]
		then
		echo "ERROR: Could not clone Moodle into $moodle_path - aborting!"
		exit 1
	fi
	cd $moodle_path
	git checkout $branch
fi

baseurl=$(pwd)
echo "==> baseurl = $baseurl"
echo "==> copying install_plugins.sh script into $absolute_path/$moodle_name and running it"
cp $home/install_plugins.sh install_plugins.sh

echo " "
echo "==> Moodle installed after $((`date +%s` - start_time)) seconds!"
echo "==> Now installing plugins"
./install_plugins.sh



