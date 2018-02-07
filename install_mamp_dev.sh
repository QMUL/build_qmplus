#!/usr/bin/env bash
version=1.0

#----------------------------------------------------------------------------------------------------------
# DH - for dev reasons only
#
# usage: install_plugin <plugin_uri> [<plugin_name>] [<branch_name>]
#
# this will install plugin from the given uri. If the optional plugin_name is given it will be used.
# Wgen the optional branch name is given the plugin will be git checked out to that branch
#
install_plugin () {
	if [ ! $1 ]
		then
		echo 'no plugin repository given to install - aborting!'
		exit 1
	fi
	plugin=$1

	if [ $2 ]
		then
		plugin_name=$2
	fi

	if [ -d $plugin_name ]
		then
		echo "==> Plugin $plugin_name is re-installed."
		rm -rf $plugin_name
	fi
	if [ $3 ]
		then 
		echo "==> GIT checking out $3"
		git clone $plugin $plugin_name -b $3
#		git submodule add $plugin $plugin_name
	else
		git clone $plugin $plugin_name
#		git submodule add $plugin $plugin_name
	fi

	if [ -d $plugin_name ]
		then
		cd $plugin_name
		rm -rf .git
		cd ..
	fi

}

#=========================================================================================================
baseurl=$(pwd)
echo " "
echo "install all QMUL theme plugins into baseurl = $baseurl (v.$version)"
echo "---------------------------------------------------------------------------------------------------"
start_time=`date +%s`

cd local
echo " "
echo "--> " $(pwd)
echo "-----------------------------------------------------------------"
install_plugin git@github.com:ULCC-QMUL/moodle-local_qmul_messaging.git qmul_messaging master
install_plugin git@github.com:ULCC-QMUL/moodle-local_qmul_dashboard.git qmul_dashboard master
install_plugin git@github.com:ULCC-QMUL/moodle-local_qmcw_coversheet.git qmcw_coversheet master
cd $baseurl

cd plagiarism
echo " "
echo "--> " $(pwd)
echo "-----------------------------------------------------------------"
install_plugin git@github.com:ULCC-QMUL/moodle-plagiarism_turnitin.git turnitin master
cd $baseurl

install_plugin git@github.com:turnitin/moodle-block_turnitin.git turnitin

cd blocks
echo " "
echo "--> " $(pwd)
echo "-----------------------------------------------------------------"
install_plugin git@github.com:turnitin/moodle-block_turnitin.git turnitin
cd $baseurl

cd mod
echo " "
echo "--> " $(pwd)
echo "-----------------------------------------------------------------"
install_plugin git@github.com:turnitin/moodle-mod_turnitintool.git turnitintool
install_plugin git@github.com:turnitin/moodle-mod_turnitintooltwo.git turnitintooltwo
cd $baseurl

cd mod/assign/submission
echo " "
echo "--> " $(pwd)
echo "-----------------------------------------------------------------"
install_plugin git@github.com:ULCC-QMUL/moodle-mod-assign-submission_qmcw_coversheet.git qmcw_coversheet
cd $baseurl


echo " "
echo "====> DONE after $((`date +%s` - start_time)) seconds!"
echo " "
