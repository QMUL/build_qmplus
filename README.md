These two scripts allow to (re-)build a QMplus Moodle application from scratch.

What is does
---------------

build_qmplus.sh
---------------------------------------

usage: ./build_qmplus.sh <path/to/qmplus>

If not already present it will GIT clone Moodle from GitHub into the given path.

Then it will GIT checkout MOODLE_34_STABLE for the latest stable version

Finally the script 'install_plugins.sh' is copied into that Moodle instance and executed there.


install_plugins.sh
------------------
PLEASE NOTE: this script is copied to the root of the Moodle installation by the 'build_qmplus.sh' script (see above) and needs to run from there!

usage: ./install_plugins [-f] [-s]  

You may run this script to re-install all plugins according to the setup of the script.

The options are as follows:
	-f this will force all plugins to be re-installed to the repository and branch given in the script, otherwise only missing plugins will be installed.
	-s this will cause all plugins to be installed as submodules instead as part of one common repository

Script syntax
-------------
The script uses an internal function to add plugins according to the specified options.
To install a plugin using this function the syntax is as follows:
 install_plugin <gitURL> <plugin_name> [<branch/tag>]
To checkout another branch other than the default one you may use the optional third parameter.

Switching from plain repository to submodules
---------------------------------------------
By default the installation process will install all plugins as part of one large repository.
You can switch this to an installation using plugins with these steps:

	- cd into the cloned QMplus directory and 'git checkout qmplus-34-dev-submodules'
	- run 'git submodule update --init --recursive' (this will take some time)

----
v.1.2