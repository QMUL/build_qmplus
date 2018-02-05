These two scripts allow to (re-)build a QMplus Moodle application from scratch.

What is does
---------------

run ./build_qmplus.sh <path/to/qmplus>
---------------------------------------
If not already present it will GIT clone Moodle from GitHub into the given path.

Then it will GIT checkout MOODLE_34_STABLE for the latest stable version

Finally the script 'install_plugins.sh' is copied into that Moodle instance and executed there.


install_plugins.sh
------------------
This script is copied into the Moodle installation by the build_qmplus.sh script above and then executed in situ. This way you will always be able to re-install the default setup at the time of installation for that specific instance.

The script will GIT clone all required repositories for QMplus and checkout any branch other than the default on where given. Finally all .git directories of these plug-ins are removed so the result can be GIT pushed as a whole.


----
v.1.1