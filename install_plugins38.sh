version=190530

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
			if [ $single_repo ] # if the singel repo switch is present install plugin as code of one big repository
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
echo "install all qmplus plugins into baseurl = $baseurl (v.$version)"
echo "---------------------------------------------------------------------------------------------------"
start_time=`date +%s`

#------------------------------------------------------------------------------------------
chdir admin/tool/
install_plugin git@github.com:ndunand/moodle-tool_mergeusers.git mergeusers

#------------------------------------------------------------------------------------------
chdir auth/
install_plugin git@github.com:ULCC-QMUL/moodle-auth_dbsyncother2.git dbsyncother
install_plugin git@github.com:catalyst/moodle-auth_saml2.git saml2
install_plugin git@github.com:Microsoft/moodle-auth_oidc.git oidc MOODLE_37_STABLE
install_plugin git@github.com:QMUL/moodle-auth_cas_db.git cas_db
install_plugin git@github.com:QMUL/moodle-auth_ulcc_sharedsecret_sso.git ulcc_sharedsecret_sso

#------------------------------------------------------------------------------------------
chdir blocks/
install_plugin git@github.com:ULCC-QMUL/moodle-block_landingpage.git landingpage
install_plugin git@github.com:ULCC-QMUL/talis-block_aspirelists.git aspirelists
install_plugin git@github.com:ULCC-QMUL/moodle-block_assessment_information.git assessment_information Jan2020
install_plugin git@github.com:danmarsden/moodle-block_attendance.git attendance
#install_plugin git@github.com:netsapiensis/moodle-block_course_menu.git course_menu
install_plugin git@github.com:ULCC-QMUL/moodle-block_course_menu.git course_menu dev
install_plugin git@github.com:moodleuulm/moodle-block_course_overview_campus.git course_overview_campus
install_plugin git@github.com:ULCC-QMUL/moodle-block_course_profile.git course_profile develop_36
#install_plugin git@github.com:ULCC/public-moodle-block_reports.git reports
install_plugin git@github.com:ULCC-QMUL/moodle-block_course_rollover.git course_rollover
install_plugin git@github.com:ULCC-QMUL/moodle-block_glsubs.git glsubs JAN20
install_plugin git@github.com:ULCC-QMUL/moodle-block_qmul_course_mappings.git qmul_course_mappings
install_plugin git@github.com:ULCC-QMUL/moodle-block_qmul_course_metadata.git qmul_course_metadata
install_plugin git@github.com:ULCC-QMUL/moodle-block_qmplus_course_overview.git qmplus_course_overview
#install_plugin git@github.com:at-tools/moodle-block_massaction.git massaction
install_plugin git@github.com:QMUL/moodle-block_massaction.git massaction
install_plugin git@github.com:ULCC-QMUL/moodle-block_module_info.git module_info
install_plugin git@github.com:ULCC-QMUL/moodle-block_onlinesurvey.git onlinesurvey
install_plugin git@github.com:ULCC-QMUL/moodle-block_pearson.git pearson
install_plugin git@github.com:deraadt/Moodle-block_progress.git progress
install_plugin git@github.com:ULCC-QMUL/moodle-block_qmul_my_qmplus.git qmul_my_qmplus
install_plugin git@github.com:ULCC-QMUL/moodle-block_qmul_myprofile.git qmul_myprofile July2017
#install_plugin git@github.com:roglos/moodle-block_quickmail.git quickmail
#install_plugin git@github.com:QMUL/moodle-block_quickmail.git quickmail
install_plugin git@github.com:ULCC-QMUL/moodle-block_quickmail.git quickmail develop_34
#install_plugin git@github.com:VERSION2-Inc/moodle-block_sharing_cart.git sharing_cart
install_plugin git@github.com:QMUL/moodle-block_sharing_cart.git sharing_cart
install_plugin git@github.com:QMUL/moodle-block_side_bar.git side_bar
#install_plugin git@github.com:jfilip/moodle-block_side_bar.git side_bar
install_plugin git@github.com:ULCC-QMUL/moodle-block_turningtech.git turningtech develop
install_plugin git@github.com:QMUL/moodle-block_ulcc_diagnostics.git ulcc_diagnostics
install_plugin git@github.com:ULCC-QMUL/moodle-block_widgets.git widgets develop_34_1
install_plugin git@github.com:moodlehq/moodle-block_messages.git messages
install_plugin git@github.com:QMUL/moodle-block_accessibility.git accessibility
install_plugin git@github.com:thepurpleblob/moodle-block_course_overview.git course_overview
install_plugin git@github.com:QMUL/moodle-block_course_reports.git course_reports
install_plugin git@github.com:deraadt/moodle-block_heatmap.git heatmap
#install_plugin git@github.com:QMUL/moodle-block_ilp.git ilp
install_plugin git@github.com:lucisgit/moodle-block_quickscan.git quickscan
install_plugin git@github.com:QMUL/moodle-block_reportsdash.git reportsdash
install_plugin git@github.com:turnitin/moodle-block_turnitin.git turnitin
install_plugin git@github.com:QMUL/moodle-block_checklist.git checklist
install_plugin git@github.com:QMUL/moodle-block_course_contents.git course_contents
install_plugin git@github.com:ULCC-QMUL/moodle-block_modlib.git modlib
install_plugin git@github.com:doiphode/moodle-block_bulkactivity.git bulkactivity b896a95
install_plugin git@github.com:ULCC-QMUL/moodle-block_kortext.git kortext
install_plugin git@github.com:Microsoft/moodle-block_microsoft.git microsoft MOODLE_37_STABLE
install_plugin git@github.com:Microsoft/moodle-block_onenote.git onenote
install_plugin git@github.com:ULCC-QMUL/moodle-block_qmul_blindmarking.git qmul_blindmarking
install_plugin git@github.com:/FMCorz/moodle-block_xp xp af3691b
install_plugin git@github.com:/deraadt/moodle-block_completion_progress completion_progress 2a0e737

#------------------------------------------------------------------------------------------
chdir course/format/
install_plugin git@github.com:ULCC-QMUL/moodle-course_format_qmultopics.git qmultopics live
install_plugin git@github.com:ULCC-QMUL/moodle-format_landingpage.git landingpage
#install_plugin git@github.com:gjb2048/moodle-format_topcoll.git topcoll master
#install_plugin git@github.com:QMUL/moodle-format_topcoll.git topcoll
install_plugin git@github.com:ULCC-QMUL/moodle-format_topics2.git topics2
install_plugin git@github.com:ULCC-QMUL/moodle-course_format_qmultopics.git qmultopics
install_plugin git@github.com:ULCC-QMUL/moodle-course_format_qmultc.git qmultc live
install_plugin git@github.com:ULCC-QMUL/moodle-course_format_weeks2.git weeks2
install_plugin git@github.com:gjb2048/moodle-format_topcoll.git topcoll
install_plugin git@github.com:marinaglancy/moodle-format_flexsections.git flexsections
#install_plugin git@github.com:ULCC-QMUL/moodle-format_grid.git grid develop_34
install_plugin git@github.com:QMUL/moodle-format_grid.git grid
install_plugin git@github.com:ULCC-QMUL/moodle-format_qmulgrid.git qmulgrid live
#install_plugin git@github.com:ULCC-QMUL/moodle-course_format_qmultc.git qmultc develop_34
install_plugin git@github.com:ULCC-QMUL/moodle-course_format_qmultc.git qmultc live
install_plugin git@github.com:ULCC-QMUL/moodle-course_format_qmulweeks.git qmulweeks live

#------------------------------------------------------------------------------------------
chdir enrol/
#install_plugin git@github.com:bynare/moodle-enrol_auto.git auto
install_plugin git@github.com:QMUL/moodle-enrol_auto.git auto
install_plugin git@github.com:ULCC-QMUL/moodle-enrol_cohortcateg.git cohortcateg
install_plugin git@github.com:QMUL/moodle-enrol_databaseextended.git databaseextended

#------------------------------------------------------------------------------------------
chdir filter/
install_plugin git@github.com:ULCC-QMUL/moodle-filter_easychem.git easychem
install_plugin git@github.com:ULCC-QMUL/moode-filter_oembed.git oembed
install_plugin git@github.com:geoffrowland/moodle-filter_jmol.git jmol
install_plugin git@github.com:ULCC-QMUL/moodle-filter_freemind.git freemind develop_303
install_plugin git@github.com:ULCC-QMUL/moodle-filter_kaltura.git kaltura moodle_36_dev
install_plugin git@github.com:ULCC-QMUL/moodle-filter_replace.git replace
install_plugin git@github.com:gthomas2/moodle-filter_imageopt.git imageopt MOODLE_36_STABLE
install_plugin git@github.com:rschrenk/moodle-filter_h5p.git h5p

#------------------------------------------------------------------------------------------
chdir grade/export/
install_plugin git@github.com:davosmith/moodle-grade_checklist.git checklist

#------------------------------------------------------------------------------------------
chdir grade/grading/form
#install_plugin git@github.com:marcusgreen/moodle-gradingform_btec.git btec
install_plugin git@github.com:QMUL/moodle-gradingform_btec.git btec

#------------------------------------------------------------------------------------------
chdir grade/import/
install_plugin git@github.com:ULCC-QMUL/moodle-gradeimport_directpearsonjson.git directpearsonjson

#------------------------------------------------------------------------------------------
chdir grade/report
install_plugin git@github.com:ULCC-QMUL/moodle-gradereport_marking.git marking
install_plugin git@github.com:ULCC-QMUL/moodle-gradereport_qmul_sits.git qmul_sits

#------------------------------------------------------------------------------------------
chdir lib/editor/tinymce/plugins
#install_plugin git@github.com:kaltura/moodle-tinymce_kalturamedia.git kalturamedia
install_plugin git@github.com:ULCC-QMUL/moodle-editor_tinymce_kalturamedia.git kalturamedia moodle_36_dev
install_plugin git@github.com:ULCC-QMUL/moodle-editor_tinymce_mathslate.git mathslate

#------------------------------------------------------------------------------------------
chdir local/
install_plugin git@github.com:ULCC-QMUL/moodle-local_landingpages.git landingpages
install_plugin git@github.com:Microsoft/moodle-local_o365.git o365
#install_plugin git@github.com:ULCC-QMUL/moodle-local_qmframework.git qmframework
#install_plugin git@github.com:QMUL/moodle-local_qmframework.git qmframework
#install_plugin git@github.com:ULCC-QMUL/moodle-local_qmframework.git qmframework client-qmul-3.4-prod
install_plugin git@github.com:ULCC-QMUL/moodle-local_qmcw_coversheet.git qmcw_coversheet
install_plugin git@github.com:ULCC-QMUL/moodle-local_qmul_sync.git qmul_sync
install_plugin git@github.com:ULCC-QMUL/moodle-local_kaltura.git kaltura moodle_36_dev
install_plugin git@github.com:ULCC-QMUL/moodle-local_activitytodo.git activitytodo
install_plugin git@github.com:DBezemer/moodle-local_analytics.git analytics
install_plugin git@github.com:jleyva/moodle-local_anonymousposting.git anonymousposting
install_plugin git@github.com:ULCC-QMUL/moodle-local_course_backup.git course_backup
install_plugin git@github.com:ULCC-QMUL/moodle-local_course_creation_wizard.git course_creation_wizard
install_plugin git@github.com:ULCC-QMUL/moodle-local_kalturamediagallery.git kalturamediagallery moodle_36_dev
install_plugin git@github.com:ULCC-QMUL/moodle-local_mass_enroll.git mass_enroll
install_plugin git@github.com:Microsoft/moodle-local_msaccount.git msaccount
#install_plugin git@github.com:kaltura/moodle-local_mymedia.git mymedia
install_plugin git@github.com:ULCC-QMUL/moodle-local_mymedia.git mymedia moodle_36_dev
install_plugin git@github.com:ULCC-QMUL/moodle-local_pearson.git pearson
install_plugin git@github.com:ULCC-QMUL/moodle-local_physicsapp.git physicsapp
install_plugin git@github.com:ULCC-QMUL/moodle-local_qm_activities.git qm_activities SEP19
install_plugin git@github.com:ULCC-QMUL/moodle-local_qmul_dashboard.git qmul_dashboard
install_plugin git@github.com:ULCC-QMUL/moodle-local_qmul_download_submissions.git qmul_download_submissions
install_plugin git@github.com:ULCC-QMUL/moodle-local_qmul_messaging.git qmul_messaging
install_plugin git@github.com:ULCC-QMUL/moodle-local_qmul_system_role_sync.git qmul_system_role_sync develop_30
install_plugin git@github.com:ULCC-QMUL/moodle-local_rollover_plugin.git rollover_plugin Jan2017
install_plugin git@github.com:moodleuulm/moodle-local_sandbox.git sandbox
install_plugin git@github.com:ULCC-QMUL/moodle-local_widgets.git widgets
install_plugin git@github.com:moodlehq/moodle-local_mobile.git mobile MOODLE_37_STABLE
install_plugin git@github.com:ULCC-QMUL/moodle-local_orphan2stealth.git orphan2stealth
install_plugin git@github.com:ULCC-QMUL/moodle-local_bulkactions.git bulkactions
install_plugin git@github.com:Microsoft/moodle-local_office365.git office365 MOODLE_37_STABLE
install_plugin git@github.com:Microsoft/moodle-local_onenote.git onenote MOODLE_37_STABLE
install_plugin git@github.com:ULCC-QMUL/moodle-local_qmframework.git qmframework client-qmul-3.4-prod-WR313667
install_plugin git@github.com:ULCC-QMUL/moodle-local_qsection.git qsection
install_plugin git@github.com:doiphode/moodle-local_simple_course_creator.git simple_course_creator 3555d50
install_plugin git@github.com:ULCC-QMUL/moodle-local_tabtransformer.git tabtransformer
install_plugin git@github.com:ULCC-QMUL/moodle-local_xp.git xp

#------------------------------------------------------------------------------------------
chdir mod/
install_plugin git@github.com:danmarsden/moodle-mod_attendance.git attendance
install_plugin git@github.com:ULCC-QMUL/moodle-mod_turningtech.git turningtech Sep19
install_plugin git@github.com:davosmith/moodle-checklist.git checklist
install_plugin git@github.com:QMUL/moodle-mod_adaptivequiz.git adaptivequiz
#install_plugin git@github.com:ULCC-QMUL/moodle-mod_adobeconnect.git adobeconnect
install_plugin git@github.com:tonyjbutler/moodle-mod_aspirelist.git aspirelist
install_plugin git@github.com:ULCC-QMUL/talis-mod_aspirelists.git aspirelists helptext_added
install_plugin git@github.com:markn86/moodle-mod_certificate.git certificate
install_plugin git@github.com:ndunand/moodle-mod_choicegroup.git choicegroup
install_plugin git@github.com:moodlerooms/moodle-mod_collaborate.git collaborate
install_plugin git@github.com:moodleou/moodle-mod_forumng.git forumng
install_plugin git@github.com:ULCC-QMUL/moodle-mod_kalvidassign.git kalvidassign moodle_36_dev
install_plugin git@github.com:ULCC-QMUL/moodle-mod_kalvidpres.git kalvidpres moodle_36_dev
install_plugin git@github.com:ULCC-QMUL/moodle-mod_kalvidres.git kalvidres moodle_36_dev
install_plugin git@github.com:tonyjbutler/moodle-mod_nln.git nln
install_plugin git@github.com:moodleou/moodle-mod_oublog.git oublog
install_plugin git@github.com:moodleou/moodle-mod_ouwiki.git ouwiki
install_plugin git@github.com:ULCC-QMUL/moodle-mod_pearson.git pearson
install_plugin git@github.com:ucsf-ckm/moodle-mod-respondusws.git respondusws
install_plugin git@github.com:ULCC-QMUL/moodle-mod_subpage.git subpage QMU-develop-36
install_plugin git@github.com:catalyst/moodle-mod_facetoface.git facetoface
install_plugin git@github.com:gbateson/moodle-mod_hotpot.git hotpot
#install_plugin git@github.com:projectestac/moodle-mod_hvp.git hvp
#install_plugin git@github.com:QMUL/moodle-mod_hvp.git hvp
install_plugin git@github.com:h5p/h5p-moodle-plugin.git hvp stable
install_plugin git@github.com:elearningsoftware/moodle-mod_journal.git journal
install_plugin git@github.com:PoetOS/moodle-mod_questionnaire.git questionnaire MOODLE_36_STABLE
install_plugin git@github.com:learnweb/moodle-mod_ratingallocate.git ratingallocate
install_plugin git@github.com:bostelm/moodle-mod_scheduler.git scheduler
install_plugin git@github.com:mudrd8mz/moodle-mod_subcourse.git subcourse
#install_plugin git@github.com:oohoo/moodle-mod_tab.git tab
install_plugin git@github.com:QMUL/moodle-mod_tab.git tab
install_plugin git@github.com:turnitin/moodle-mod_turnitintool.git turnitintool
install_plugin git@github.com:turnitin/moodle-mod_turnitintooltwo.git turnitintooltwo
install_plugin git@github.com:QMUL/moodle-mod_lightboxgallery.git lightboxgallery
install_plugin git@github.com:ULCC-QMUL/moodle-mod_qmevaluation.git qmevaluation

#------------------------------------------------------------------------------------------
chdir mod/assign/feedback
install_plugin git@github.com:Microsoft/moodle-assignfeedback_onenote.git onenote MOODLE_37_STABLE

#------------------------------------------------------------------------------------------
chdir mod/assign/submission
install_plugin git@github.com:pauln/moodle-assignsubmission_onlineaudio.git onlineaudio
install_plugin git@github.com:ULCC-QMUL/moodle-mod-assign-submission_qmcw_coversheet.git qmcw_coversheet
install_plugin git@github.com:Microsoft/moodle-assignsubmission_onenote.git onenote MOODLE_37_STABLE
install_plugin git@github.com:QMUL/moodle-assignsubmission_mahara.git mahara

#------------------------------------------------------------------------------------------
chdir mod/quiz/accessrule/
install_plugin git@github.com:moodleou/moodle-quizaccess_honestycheck.git honestycheck

#------------------------------------------------------------------------------------------
chdir question/behaviour/
install_plugin git@github.com:QMUL/moodle-qbehaviour_adaptivehints.git adaptivehints
install_plugin git@github.com:QMUL/moodle-qbehaviour_adaptivehintsnopenalties.git adaptivehintsnopenalties
install_plugin git@github.com:maths/moodle-qbehaviour_adaptivemultipart.git adaptivemultipart
install_plugin git@github.com:maths/moodle-qbehaviour_dfcbmexplicitvaildate.git dfcbmexplicitvaildate
install_plugin git@github.com:maths/moodle-qbehaviour_dfexplicitvaildate.git dfexplicitvaildate
install_plugin git@github.com:QMUL/moodle-qbehaviour_interactivehints.git interactivehints
install_plugin git@github.com:moodleou/moodle-qbehaviour_opaque.git opaque

#------------------------------------------------------------------------------------------
chdir question/format/
install_plugin git@github.com:ecampbell/moodle-qformat_wordtable.git wordtable

#------------------------------------------------------------------------------------------
chdir question/type/
install_plugin git@github.com:jmvedrine/moodle-qtype_jme.git jme
install_plugin git@github.com:jmvedrine/moodle-qtype_multichoiceset.git multichoiceset
install_plugin git@github.com:ndunand/moodle-qtype_multinumerical.git multinumerical
install_plugin git@github.com:moodleou/moodle-qtype_opaque.git opaque
install_plugin git@github.com:gbateson/moodle-qtype_ordering.git ordering
install_plugin git@github.com:moodleou/moodle-qtype_pmatch.git pmatch
install_plugin git@github.com:timhunt/moodle-qtype_pmatchreverse.git pmatchreverse
install_plugin git@github.com:QMUL/moodle-qtype_poasquestion.git poasquestion
install_plugin git@github.com:moodleou/moodle-qtype_varnumeric.git varnumeric
install_plugin git@github.com:moodleou/moodle-qtype_varnumericset.git varnumericset
install_plugin git@github.com:moodleou/moodle-qtype_varnumunit.git varnumunit
install_plugin git@github.com:QMUL/moodle-qtype_gapfill.git gapfill
install_plugin git@github.com:QMUL/moodle-qtype_ddmatch.git ddmatch
install_plugin git@github.com:jmvedrine/moodle-qtype_algebra.git algebra

#------------------------------------------------------------------------------------------
chdir question/type/
install_plugin git@github.com:QMUL/moodle-qtype_order.git order
install_plugin git@github.com:moodleou/moodle-qtype_pmatchjme.git pmatchjme

#------------------------------------------------------------------------------------------
chdir lib/editor/atto/plugins
install_plugin git@github.com:ULCC-QMUL/moodle-editor_atto_qmulcolumns.git qmulcolumns
install_plugin git@github.com:ULCC-QMUL/moodle-editor_atto_qmulcite.git qmulcite
install_plugin git@github.com:ULCC-QMUL/moodle-editor_atto_qmulicons.git qmulicons
install_plugin git@github.com:ULCC-QMUL/moodle-editor_atto_qmultitle.git qmultitle
install_plugin git@github.com:ULCC-QMUL/moodle-editor_atto_qmultexthighlight.git qmultexthighlight
install_plugin git@github.com:ULCC-QMUL/moodle-editor_atto_qmulblockquote.git qmulblockquote
install_plugin git@github.com:ULCC-QMUL/moodle-editor_atto_easychem.git easychem
install_plugin git@github.com:QMUL/moodle-editor_atto_chemistry.git chemistry
install_plugin git@github.com:ULCC-QMUL/moodle-editor_atto_computing.git computing
install_plugin git@github.com:QMUL/moodle-editor_atto_htmlplus.git htmlplus
install_plugin git@github.com:ULCC-QMUL/moodle-editor_atto_mathslate.git mathslate
install_plugin git@github.com:ULCC-QMUL/moodle-editor_atto_kalturamedia.git kalturamedia moodle_36_dev
install_plugin git@github.com:dthies/moodle-atto_fullscreen.git fullscreen
install_plugin git@github.com:projectestac/moodle-atto_fontfamily.git fontfamily
install_plugin git@github.com:andrewnicols/moodle-atto_fontsize.git fontsize
install_plugin git@github.com:ndunand/moodle-atto_morefontcolors.git morefontcolors
install_plugin git@github.com:justinhunt/moodle-atto_snippet.git snippet
install_plugin git@github.com:/ULCC-QMUL/moodle-editor_atto_echo360attoplugin echo360attoplugin

#------------------------------------------------------------------------------------------
chdir plagiarism/
#install_plugin git@github.com:QMUL/moodle-plagiarism_turnitin.git turnitin
install_plugin git@github.com:turnitin/moodle-plagiarism_turnitin.git turnitin develop

#------------------------------------------------------------------------------------------
chdir report/
install_plugin git@github.com:ULCC-QMUL/moodle-report_qmplus.git qmplus SEP18
install_plugin git@github.com:pauln/moodle-report_componentgrades.git componentgrades
#install_plugin git@github.com:ctchanandy/moodle-report_forumgraph.git forumgraph
install_plugin git@github.com:QMUL/moodle-report_forumgraph.git forumgraph
#install_plugin git@github.com:mudrd8mz/moodle-report_overviewstats.git overviewstats
install_plugin git@github.com:QMUL/moodle-report_overviewstatistics.git overviewstats

#------------------------------------------------------------------------------------------
chdir repository/
install_plugin git@github.com:Microsoft/moodle-repository_office365.git office365 MOODLE_37_STABLE
#install_plugin git@github.com:Microsoft/moodle-repository_onenote.git onenote
install_plugin git@github.com:QMUL/moodle-repository_evernote.git evernote

#------------------------------------------------------------------------------------------
chdir theme/
#install_plugin git@github.com:apnet/moodle-theme_bcu.git bcu
#install_plugin git@github.com:QMUL/moodle-theme_bloom.git bloom
#install_plugin git@github.com:gjb2048/moodle-theme_essential.git essential
install_plugin git@github.com:ULCC-QMUL/moodle-theme_synergy_bootstrap.git synergy_bootstrap
#install_plugin git@github.com:ULCC-QMUL/moodle-theme_qmul.git qmul develop_34
install_plugin git@github.com:ULCC-QMUL/moodle-theme_qmul.git qmul develop_36
install_plugin git@github.com:ULCC-QMUL/moodle-theme_qmul_humanities.git qmul_humanities develop_36
install_plugin git@github.com:ULCC-QMUL/moodle-theme_qmul_learning.git qmul_learning develop_36
install_plugin git@github.com:ULCC-QMUL/moodle-theme_qmul_lifesciences.git qmul_lifesciences develop_36
install_plugin git@github.com:ULCC-QMUL/moodle-theme_qmul_medicine.git qmul_medicine develop_36
install_plugin git@github.com:ULCC-QMUL/moodle-theme_qmul_science.git qmul_science develop_36
#install_plugin git@github.com:QMUL/moodle-theme_adaptable.git adaptable
#install_plugin git@github.com:QMUL/moodle-theme_klass.git klass
install_plugin git@github.com:Microsoft/moodle-theme_boost_o365teams.git boost_o365teams

#------------------------------------------------------------------------------------------
chdir user/profile/field/
install_plugin git@github.com:QMUL/moodle-profilefield_o365.git o365
install_plugin git@github.com:QMUL/moodle-profilefield_oidc.git oidc

#------------------------------------------------------------------------------------------
chdir files/converter/
install_plugin git@bitbucket.org:uonmoodle/moodle-fileconverter_onedrive.git onedrive

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
