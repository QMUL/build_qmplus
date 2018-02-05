cd theme/
git clone git@github.com:ULCC-QMUL/moodle-theme_synergy_bootstrap.git synergy_bootstrap
git clone git@github.com:ULCC-QMUL/moodle-theme_qmul.git qmul
cd qmul
git checkout develop_32
cd ../..

cd course/format
git clone git@github.com:ULCC-QMUL/moodle-course_format_qmultopics.git qmultopics
cd qmultopics
git checkout develop_32
cd ..

git clone git@github.com:ULCC-QMUL/moodle-format_landingpage.git landingpage
cd landingpage
git checkout master
cd ..

git clone https://github.com/gjb2048/moodle-format_topcoll.git topcoll
cd topcoll
git checkout master
cd ..
cd ../..

cd blocks
git clone git@github.com:ULCC-QMUL/moodle-block_landingpage.git landingpage
cd landingpage
git checkout master
cd ../..

cd local
git clone git@github.com:ULCC-QMUL/moodle-local_landingpages.git landingpages
cd landingpages
git checkout master
cd ..
git clone git@github.com:ULCC-QMUL/moodle-local_qmframework.git qmframework
