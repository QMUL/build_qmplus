version=200218

#----------------------------------------------------------------------------------------------------------
#
# usage: install_plugin <plugin_uri> [<plugin_name>] [<branch_name>]
#
# this will install plugin from the given uri. If the optional plugin_name is given it will be used.
# When the optional branch name is given the plugin will be git checked out to that branch
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

	if [ $force_reinstall ]
		then
		if [ -d $plugin_name ]
			then
			echo "==> re-installing $plugin_name"
			[ $testing ] || rm -rf $plugin_name
		fi
	fi

	if [ ! -d $plugin_name ] || [ $force_reinstall ]
		then
		if [ $3 ] #there is a specific branch/tag given
			then
			if [ $single_repo ] # if the single repo switch is present install plugin as code of one big repository
				then
				echo "==> clone repository $plugin as $plugin_name with branch $3"
				[ $testing ] || git clone $plugin $plugin_name -b $3
				[ $testing ] || rm -rf $plugin_name/.git # removing plugins GIT heritage to make it part of the qmplus repository
			else
				echo "==> add submodule $plugin as $plugin_name with branch $3"
				[ $testing ] || git submodule add --force -b $3 $plugin $plugin_name
			fi
		else
			if [ $single_repo ]
				then
				echo "==> clone repository $plugin as $plugin_name"
				[ $testing ] || git clone $plugin $plugin_name
				[ $testing ] || rm -rf $plugin_name/.git #
			else
				echo "==> add submodule $plugin as $plugin_name"
				[ $testing ] || git submodule add --force $plugin $plugin_name
			fi

		fi
	fi
}

#---------------------------------------------------------------------------------------------------------
chdir () {
	cd $baseurl
	if [  $1 ]
		then
		cd $1
		echo " "
		echo "--> " $(pwd)
		echo "-----------------------------------------------------------------"
	fi
}

#=========================================================================================================

# get options
while getopts :fst x; do
    case $x in
        f)
            force_reinstall=1
            ;;
        s)
            single_repo=1
            ;;
        t)
            testing=1
            ;;
    esac
done
shift $((OPTIND-1))


baseurl=$(pwd)
echo " "
echo "Install all QMoodle38 plugins into baseurl = $baseurl (v.$version)"
echo "---------------------------------------------------------------------------------------------------"
start_time=`date +%s`

#------------------------------------------------------------------------------------------
#chdir admin/tool/

#------------------------------------------------------------------------------------------
#chdir auth/

#------------------------------------------------------------------------------------------
chdir blocks/
install_plugin git@github.com:ULCC-QMUL/moodle-block_landingpage.git landingpage
install_plugin git@github.com:ULCC-QMUL/moodle-block_assessment_information.git assessment_information Jan2020
install_plugin git@github.com:ULCC-QMUL/moodle-block_widgets.git widgets develop_36
#install_plugin git@github.com:moodlehq/moodle-block_messages.git messages
install_plugin git@github.com:ULCC-QMUL/moodle-block_modlib.git modlib test
#install_plugin git@github.com:doiphode/moodle-block_bulkactivity.git bulkactivity
install_plugin git@github.com:ULCC-QMUL/moodle-block_module_info.git module_info

#------------------------------------------------------------------------------------------
chdir course/format/
#install_plugin git@github.com:gjb2048/moodle-format_topcoll.git topcoll
install_plugin git@github.com:ULCC-QMUL/moodle-course_format_qmultopics.git qmultopics test
install_plugin git@github.com:ULCC-QMUL/moodle-format_landingpage.git landingpage
install_plugin git@github.com:ULCC-QMUL/moodle-format_topics2.git topics2
install_plugin git@github.com:ULCC-QMUL/moodle-course_format_qmultopics.git qmultopics test
install_plugin git@github.com:ULCC-QMUL/moodle-course_format_qmultc.git qmultc test
install_plugin git@github.com:ULCC-QMUL/moodle-course_format_weeks2.git moodle-course_format_weeks2
install_plugin git@github.com:ULCC-QMUL/moodle-course_format_qmulweeks.git qmulweeks test
install_plugin git@github.com:QMUL/moodle-format_grid.git grid
install_plugin git@github.com:ULCC-QMUL/moodle-format_qmulgrid.git qmulgrid test

#------------------------------------------------------------------------------------------
#chdir enrol/

#------------------------------------------------------------------------------------------
#chdir files/converter/

#------------------------------------------------------------------------------------------
#chdir filter/

#------------------------------------------------------------------------------------------
#chdir grade/export/

#------------------------------------------------------------------------------------------
#chdir grade/grading/form

#------------------------------------------------------------------------------------------
#chdir grade/import/

#------------------------------------------------------------------------------------------
#chdir grade/report

#------------------------------------------------------------------------------------------
#chdir lib/editor/tinymce/plugins

#------------------------------------------------------------------------------------------
chdir local/
install_plugin git@github.com:ULCC-QMUL/moodle-local_landingpages.git landingpages
#install_plugin git@github.com:ULCC-QMUL/moodle-local_qmcw_coversheet.git qmcw_coversheet
#install_plugin git@github.com:ULCC-QMUL/moodle-local_qmul_sync.git qmul_sync
#install_plugin git@github.com:ULCC-QMUL/moodle-local_course_creation_wizard.git course_creation_wizard
install_plugin git@github.com:ULCC-QMUL/moodle-local_qmul_dashboard.git qmul_dashboard
install_plugin git@github.com:ULCC-QMUL/moodle-local_widgets.git widgets
install_plugin git@github.com:ULCC-QMUL/moodle-local_orphan2stealth.git orphan2stealth
install_plugin git@github.com:ULCC-QMUL/moodle-local_bulkactions.git bulkactions
install_plugin git@github.com:ULCC-QMUL/moodle-local_qsection.git qsection
install_plugin git@github.com:ULCC-QMUL/moodle-local_tabtransformer.git tabtransformer
install_plugin git@github.com:ULCC-QMUL/moodle-local_activitytodo.git activitytodo
install_plugin git@github.com:ULCC-QMUL/moodle-local_qmul_messaging.git qmul_messaging

#------------------------------------------------------------------------------------------
chdir mod/
install_plugin git@github.com:PoetOS/moodle-mod_questionnaire.git questionnaire MOODLE_38_STABLE
install_plugin git@github.com:ULCC-QMUL/moodle-mod_qmevaluation.git qmevaluation behat

#------------------------------------------------------------------------------------------
#chdir mod/assign/feedback

#------------------------------------------------------------------------------------------
#chdir mod/assign/submission

#------------------------------------------------------------------------------------------
#chdir mod/quiz/accessrule/

#------------------------------------------------------------------------------------------
#chdir question/behaviour/

#------------------------------------------------------------------------------------------
#chdir question/format/

#------------------------------------------------------------------------------------------
#chdir question/type/

#------------------------------------------------------------------------------------------
#chdir lib/editor/atto/plugins

#------------------------------------------------------------------------------------------
chdir plagiarism/
install_plugin git@github.com:turnitin/moodle-plagiarism_turnitin.git turnitin

#------------------------------------------------------------------------------------------
#chdir report/

#------------------------------------------------------------------------------------------
#chdir repository/

#------------------------------------------------------------------------------------------
chdir theme/
#install_plugin git@github.com:ULCC-QMUL/moodle-theme_synergy_bootstrap.git synergy_bootstrap
install_plugin git@github.com:ULCC-QMUL/moodle-theme_qmul.git qmul behat

#------------------------------------------------------------------------------------------
#chdir user/profile/field/

cd $baseurl

# update submodules if present
if [ $submodules ]
	then
	echo "==> Updating submodules..."
	[ $testing ] || git submodule update --init --recursive
fi
echo " "
echo "====> DONE after $((`date +%s` - start_time)) seconds!"
echo " "
