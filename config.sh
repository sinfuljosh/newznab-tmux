#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#Copy this file to defaults.sh
#DO NOT EDIT THIS FILE

#########################EDIT THESE#########################
############################################################

#This is the shutdown, true/false
#on, it runs, off and no scripts will be RESTARTED, when all panes are DEAD, killall tmux
#if this is set to false, the script will run 1 loop and terminate
export RUNNING="true"

############################################################

#Set paths
export NEWZPATH="/var/www/newznab"

#Should not need to change
export NEWZNAB_PATH=$NEWZPATH"/misc/update_scripts"
export TESTING_PATH=$NEWZPATH"/misc/testing"
export ADMIN_PATH=$NEWZPATH"/www/admin"

############################################################

#Post Processing Additional is the post processing that downloads rar files and attempts to get info for your site
#you are able to set the number of process to be run from 1-16, remember that each process uses 1 of your nntp connections
#so, if you have 20, and you set this to 16, you will have errors, lots of errors, nfo lookup uses 1 connection
#binaries and backfill threaded default to 10 connections each and predb uses 1, so understand how many connections you are using when setting
#trial and error for this, 1 runs always, 2 if more than 200, 3 more than 300 and so on.
#At some point, increasing this begins to slow things down. It will need to be adjusted for your system
#to get the desired performance, 0 will disable all post processing
export POST_TO_RUN="0"

#Enter the session name to be used by tmux
export TMUX_SESSION="Newznab"

#Set, in seconds - how often the monitor.php (left top pane) script should update, 0 may cause errors
export MONITOR_UPDATE="30"

#you may want to kill the update_binaries, backfill and import if no releases have been add in x minutes, set the timer to anything other than 0 to enable
#this will only run every 5 loops of monitor
export KILL_UPDATES="0"

#do you want to just cause it to restart or keep off until a release is created, true for off until a release is created
#this will stop all downloads and imports
export KEEP_KILLED="false"

############################################################

#You can have backfill loop constantly and interject binaries every so often
#by setting this next to true, if true, the normal backfill pane will be dead
export SEQUENTIAL="false"

#time between loop start for update_binaries, in seconds
#default is 30 minutes
#will run on first loop and then not again for at least 1800 seconds
export BINARIES_SEQ_TIMER="1800"

#this will not run on first loop, time between loop start for backfill, in seconds
#default is 10 seconds, this will run after time has expired, binaries will take precedence and run before this, if its time has expired
export BACKFILL_SEQ_TIMER="10"

############################################################

#Choose to run update_binaries true/false
export BINARIES="false"

#Choose to run the threaded or non-threaded newznab binaries scripts true/false
#update_binaries.php or update_binaries_threaded.php
export BINARIES_THREADS="false"

#Set, in seconds - how long the update_binaries should sleep between runs, 0 may cause errors
#top right pane
#sleep timers are not used when using SEQ
export BINARIES_SLEEP="40"

#Set the max amount of unprocessed releases and still allow update_binaries to run
#set to 0 to disable
export BINARIES_MAX_RELEASES="0"

#Set the max amount of of rows in the parts table and still allow update_binaries to run
#set to 0 to disable
export BINARIES_MAX_ROWS="0"

############################################################

#Choose to run backfill script true/false
export BACKFILL="false"

#Choose to run the threaded or non-threaded newznab backfill scripts true/false
#backfill.php or backfill_threaded.php
export BACKFILL_THREADS="false"

#Set, in seconds - how long the backfill should sleep between runs, 0 may cause errors
#in pane below update_binaries
#sleep timers are not used when using SEQ
export BACKFILL_SLEEP="40"

#Set the max amount of unprocessed releases and still allow backfill to run
#set to 0 to disable
export BACKFILL_MAX_RELEASES="0"

#Set the max amount of of rows in the parts table and still allow backfill to run
#set to 0 to disable
export BACKFILL_MAX_ROWS="0"

#Set the maximum days to backfill, you set the Newznab+ admin/edit backfill to 1
#this will increment your database by 1 after each backfill loop
#once your backfill numbers reach $MAXDAYS, then it will no long increment the database
#backfill will continue to run, and do no work, at that point you should disable backfill, below
export MAXDAYS="210"

############################################################

#use kevin123's safer_backfill_parts.php instead of normal backfill or backfill threaded
#this is the script I use, it does 1 group at a time from z to a (wanted to start with tv groups first) 100k parts,
#then the script stops (once per loop), if your first_record_postdate on the group is 2012-06-24
#it will be skipped (target reached). When that group is done, it will do another ( again from z to a).
#this does not use increment, it works by the date set below
#you also need to enable kevin's compression mod, those files are needed
export KEVIN_SAFER="false"

#set the date to go back to, must be in the format of YYYY-MM-DD, like 2012-06-24
export KEVIN_DATE="2012-06-24"

#set the number of articles/headers to download at one time
export KEVIN_PARTS="100000"

############################################################

#Set the path to the nzb dump you downloaded from torrents, this is the path to bulk files folder of nzbs
#this does not recurse through subfolders, unless you set NZB_THREADS to true
export NZBS="/path/to/nzbs"

#Choose to run import nzb script true/false
export IMPORT="false"

#If, you have all of your nzbs in one folder select false
#If, you have all of you nzbs split into separate in with the root at $NZBS then select true
#and 10 nzbs will be imported from each subfolder per loop.
#Importing this way, allows all post processing scripts to run, such as book, music, movies
#Instead of doing all 1 type at once, spread the load
export NZB_THREADS="false"

#Set max number of folders to process per loop. This includes empty folders.
export NZB_FOLDER_COUNT="20"

#How many nzbs to import per loop, if using NZB_THREADS=true the per folder
export NZBCOUNT="10"

#Set, in seconds - how long the nzb-import should sleep between runs, 0 may cause errors
#below backfill
export IMPORT_SLEEP="40"

#Set the max amount of unprocessed releases and still allow nzb-import to run
#set to 0 to disable
export IMPORT_MAX_RELEASES="0"

#Set the max amount of of rows in the parts table and still allow nzb-import to run
#set to 0 to disable
export IMPORT_MAX_ROWS="0"

#import nzbs using the filename as the release name true/false
export IMPORT_TRUE="false"

############################################################

#MAX_RELEASES for each can be calculated on the total post processing or just the Misc category
#to calculate on just the Misc, enable this
export MISC_ONLY="false"

############################################################

#Create releases, this is really only necessary to turn off when you only want to post process
export RELEASES="false"

#Set, in seconds - how long the update_release should sleep between runs, 0 may cause errors
#bottom right
export RELEASES_SLEEP="40"

############################################################

#Choose to run optimize_innodb.php or optimize_mysiam.php script true/false
#set to false by default, you should test the optimize scripts in bin first
#optimize_myisam on small tables runs after every 5th loop of update_releases
export OPTIMIZE="false"

#How often to run optimize_myisam on small tables seconds, default is 10 min
export MYISAM_SMALL="600"

#How often to run optimize_myisam on large tables seconds, default is 1 hr
export MYISAM_LARGE="3600"

#How often to run optimize_innodb on small tables in seconds, default is 2 hr
export INNODB_SMALL="7200"

#How often to run optimize_innodb on large tables in seconds, default is 48 hrs
export INNODB_LARGE="172800"

############################################################

#Choose your database engine, comment the one true/false
#you should have already converted your database to InnoDB engine, if you select true here
export INNODB="false"

############################################################

#Choose to run update_cleanup.php and removespecial.php true/false
#set to false by default, you will need to edit /misc/testing/update_cleanup.php and /misc/testing/update_parsing.php
#to actually do anything, directions are in the file
export CLEANUP="false"

#edit update_cleanup.php and update_parsing.php and svn up, this will only mod files when you run scripts/update_svn.sh or scripts/fix_files.sh
export CLEANUP_EDIT="false"

#How often do you want  update_cleanup.php and removespecial.php to run, in seconds
export CLEANUP_TIMER="3600"

############################################################

#Choose to run update_parsing.php true/false
#set to false by default, you will need to edit /misc/testing/update_parsing.php
#to actually do anything, directions are in the file
export PARSING="false"

#How often do you want update_parsing.php to run, in seconds
export PARSING_TIMER="3600"

############################################################

#How often to update the PreDB in seconds
export PREDB_TIMER="900"

#How often to update the TV Schedule and the In Theaters in seconds
export TVRAGE_TIMER="43200"

############################################################

#Choose to run sphinx.php script true/false
#set to false by default, you should test the script first, php sphinx.php from the bin folder
export SPHINX="false"

#How often to run sphinx in seconds
export SPHINX_TIMER="3600"

############################################################

#mediainfo and ffmpeg can hang occasionally, set timer, in seconds, to anything other than 0 to enable
#it should not need to run longer that 120 seconds
export KILL_PROCESS="0"

#look at man killall - if you have the -q option, enable this, otherwise leave it disabled
export KILL_QUIET="false"

############################################################

#Delete parts and binaries older than retention days, which is set in edit - site
#this uses a script posted by cj https://github.com/NNScripts/nn-custom-scripts
export DELETE_PARTS="false"

#how often should this be run, default it 1 hr
export DELETE_TIMER="3600"

#Releases may be added/edited with an imdb-id that does not exists in the movieinfo table. This script, update_missing_movie_info,
#will fetch all the missing imdb id's from the releases table.
export FETCH_MOVIE="false"

#how often should this be run, default it 12 hr
export MOVIE_TIMER="43200"

############################################################

#Specify your SED binary, if you are using freebsd or mac, you need to install gnu sed (gsed) and adjust the path
export SED="/bin/sed"
#export SED="/usr/local/bin/gsed"

#freebsd, and maybe mac, does not contain SIGSTKFLT, SIGCLD, SIGPOLL, SIGPWR
#and powerprocess.php will error on one of those, but appears to work if they
#are commented out, enable to have the script comment them out while running update_svn
export FIX_POSIX="false"

############################################################

#Select some monitoring script, if they are not installed, it will not affect the running of the scripts
#these are set to false by default, enable if you want them
export USE_HTOP="false"
export USE_BWMNG="false"
export USE_MYTOP="false"
export USE_VNSTAT="false"
export USE_ATOP="false"
export USE_NMON="false"
export USE_IOTOP="false"

#freebsd does not have iotop, but can run top -m io -o total
export USE_TOP="false"

export USE_IFTOP="false"
#select interface to listen, only 1 interface
export INTERFACE="eth0"

#an additional window can be created manually with Ctrl-a c or it can be created at start of script
export USE_CONSOLE="false"

############################################################

#Use powerline scripts to display the status bar
#To display properly, you need a modified font, download and install the font and then select that font in your terminal
#This is done on the terminal computer, not the newznab++ server
#download fonts from https://github.com/jonnyboy/powerline-fonts
#I recommend Consolas if you are using putty in Win7
export POWERLINE="false"

############################################################

#use kevin123's compression mod true/false
#this will copy kevin123's compression mod to the correct location when you update_svn.sh or fix_files.sh
#this ensures that kevin123's files are present after updating svn
export KEVINS_COMP="false"

############################################################

#set your LANG to which ever you like, only effects these scripts
export LANG="en_US.UTF-8"

#to help IMDB return only English titles, enable this, you will need to run update_svn.php or fix_files.sh
export EN_IMDB="false"

############################################################

#newzdash is a web front end to show statistics of your Newznab+ install
#to use, you must first install from https://github.com/AlienXAXS/newzdash

#this is YOUR shared key and allows these scripts to communicate with newzdash
export NEWZDASH_SHARED_SECRET=""

#the url of your newzdash install, ensure it include HTTP:// or HTTPS:// or it will fail
#to disable leave blank ie. export NEWZDASH_URL=""
export NEWZDASH_URL=""

###########################################################

#Use tmpfs to run post processing on true/false
#to keep from running scripts as root, you can create your own ramdisk by adding the next line to /etc/fstab
#tmpfs /var/www/newznab/nzbfiles/tmpunrar1 tmpfs user,nodev,nodiratime,nosuid,size=256M,mode=777 0 0
#edit the path, the path MUST be the path in site edit with a "1" appended to the end, like above
#you still need to set this to true or mount it manually as your user, not as root
export RAMDISK="false"

#for freebsd, it is just a little different, you can either create the ramdisk and mount it by adding the next line to /etc/fstab
#tmpfs /var/www/newznab/nzbfiles/tmpunrar1 tmpfs rw,size=256M,mode=777 0 0
#or, give users the permission to mount it by running sudo sysctl vfs.usermount=1 and then add the next line to /etc/fstab
#tmpfs /var/www/newznab/nzbfiles/tmpunrar1 tmpfs rw,noauto,size=256M,mode=777 0 0

############################################################

#set svn password, for use with scripts/update_svn.sh
#update_svn.sh is destructive, it update your version to match the svn version
export SVN_PASSWORD="password"

#running update_svn as root will change file ownership of every file in the svn path
#to chown -R the path, enable and set user/group
#newznab/nzbfiles is not chown'd
export CHOWN_TRUE="false"

#set CHOWN_TRUE="true" and WWW_USER="{youruser}:www-data" and run update_svn.sh or fix_files.sh
#and you will will not need root to run these scripts
export WWW_USER="www-data:www-data"

###########################################################

#if you have a ramdisk and would like to monitor it's use, set path here
#this is not the same as RAMDISK above, I keep my parts table on a ramdisk
export RAMDISK_PATH=""

###########################################################

#By using this script you understand that the programmer is not responsible for any loss of data, users, or sanity.
#You also agree that you were smart enough to make a backup of your database and files. Do you agree? yes/no
export AGREED="no"

############################################################

##END OF EDITS##

command -v mysql >/dev/null 2>&1 || { echo >&2 "I require mysql but it's not installed. Aborting."; exit 1; } && export MYSQL=`command -v mysql`
command -v php5 >/dev/null 2>&1 && export PHP=`command -v php5` || { export PHP=`command -v php`; }
command -v tmux >/dev/null 2>&1 || { echo >&2 "I require tmux but it's not installed. Aborting."; exit 1; } && export TMUXCMD=`command -v tmux`
command -v nice >/dev/null 2>&1 || { echo >&2 "I require nice but it's not installed. Aborting."; exit 1; } && export NICE=`command -v nice`


if [[ $USE_HTOP == "true" ]]; then
  command -v htop >/dev/null 2>&1|| { echo >&2 "I require htop but it's not installed. Aborting."; exit 1; } && export HTOP=`command -v htop`
fi
if [[ $USE_NMON == "true" ]]; then
  command -v nmon >/dev/null 2>&1 || { echo >&2 "I require nmon but it's not installed. Aborting."; exit 1; } && export NMON=`command -v nmon`
fi
if [[ $USE_BWMNG == "true" ]]; then
  command -v bwm-ng >/dev/null 2>&1|| { echo >&2 "I require bwm-ng but it's not installed. Aborting."; exit 1; } && export BWMNG=`command -v bwm-ng`
fi
if [[ $USE_IOTOP == "true" ]]; then
  command -v iotop >/dev/null 2>&1|| { echo >&2 "I require iotop but it's not installed. Aborting."; exit 1; } && export IOTOP=`command -v iotop`
fi
if [[ $USE_TOP == "true" ]]; then
  command -v top >/dev/null 2>&1|| { echo >&2 "I require top but it's not installed. Aborting."; exit 1; } && export TOP=`command -v top`
fi
if [[ $USE_MYTOP == "true" ]]; then
  command -v mytop >/dev/null 2>&1|| { echo >&2 "I require mytop but it's not installed. Aborting."; exit 1; } && export MYTOP=`command -v mytop`
fi
if [[ $USE_VNSTAT == "true" ]]; then
  command -v vnstat >/dev/null 2>&1|| { echo >&2 "I require vnstat but it's not installed. Aborting."; exit 1; } && export VNSTAT=`command -v vnstat`
fi
if [[ $USE_IFTOP == "true" ]]; then
  command -v iftop >/dev/null 2>&1|| { echo >&2 "I require iftop but it's not installed. Aborting."; exit 1; } && export IFTOP=`command -v iftop`
fi
if [[ $USE_ATOP == "true" ]]; then
  command -v atop >/dev/null 2>&1|| { echo >&2 "I require atop but it's not installed. Aborting."; exit 1; } && export ATOP=`command -v atop`
fi
if [[ $POWERLINE == "true" ]]; then
  export TMUX_CONF="powerline/tmux.conf"
else
  export TMUX_CONF="conf/tmux.conf"
fi

