These two scripts allow to (re-)build a QMplus Moodle application from scratch.

New
-----
2018-02-15: Now building QMplus with plugins as submodules as default option.
2020-04-02: Providing beta script to create QMplus 3.9 from the Moodle master branch.


What is does
---------------

build_qmplus.sh
---------------

	usage: ./build_qmplus39.sh <path/to/qmplus> [<moodle_branch>]

If not already present it will GIT clone Moodle from GitHub into the given path.

Then it will GIT checkout master - as the latest beta version - by default but you may specify a different Moodle branch as an optional parameter.

Finally the script 'install_plugins39.sh' is copied into that Moodle instance and executed in situ.


install_plugins.sh
------------------
PLEASE NOTE: this script is copied to the root of the Moodle installation by the 'build_qmplus.sh' script (see above) and needs to run from there!

	usage: ./install_plugins39 [-f] [-s]  

You may run this script to re-install all plugins according to the setup of the script.

The options are as follows:

	-f this will force all plugins to be re-installed to the repository and branch given in the script, otherwise only missing plugins will be installed.
	-s this will cause all plugins to be installed into one single repository instead as submodules

Script syntax
-------------
The script uses an internal function to add plugins according to the specified options.
To install a plugin using this function the syntax is as follows:

 install_plugin <gitURL> <plugin_name> [<branch/tag>]

To checkout another branch other than the default one you may use the optional third parameter.

Switching from one plain repository to submodules
-------------------------------------------------
By default the installation process will install all plugins as submodules.
You can switch this to an installation of one large repository by changing into the newlu created QMplus directory and run:

	./install_plugins.sh -fs

Please note that updating the submodules may take some time.

----
v.1.4
