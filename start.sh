#!/usr/bin/env bash
SOURCE="${BASH_SOURCE[0]}"
DIR="$( dirname "$SOURCE" )"
while [ -h "$SOURCE" ]
do
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
  DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd )"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

source edit_these.sh

eval $( $SED -n "/^define/ { s/.*('\([^']*\)', '*\([^']*\)'*);/export \1=\"\2\"/; p }" "$NEWZPATH"/www/config.php )

if [[ $AGREED == "no" ]]; then
        echo "Please edit the edit_these.sh file"
        exit
fi

if [[ $RAMDISK == "true" ]]; then
  TMPUNRAR_QUERY="SELECT value from site where ID = 66;"
  TMPUNRAR_PATH=`$MYSQL -u$DB_USER -h$DB_HOST --password=$DB_PASSWORD $DB_NAME -s -N -e "${TMPUNRAR_QUERY}"`
  for i in {1..9}
  do
    umount $TMPUNRAR_PATH$i &> /dev/null
    rm -fr $TMPUNRAR_PATH$i
    mkdir $TMPUNRAR_PATH$i
    chmod 777 $TMPUNRAR_PATH$i
    mount -t tmpfs -o size=256M tmpfs $TMPUNRAR_PATH$i 2>&1 > /dev/null
  done
fi

#remove postprocessing scripts
rm -f bin/lib/post*
rm -f bin/processAlternate*

#create postprocessing scripts
for (( c=2; c<=9; c++ ))
  do
  d=$((($c - 1) * 100))
  cp $NEWZPATH/www/lib/postprocess.php bin/lib/postprocess$c.php
  sed -i -e "s/PostProcess/PostProcess$c/g" bin/lib/postprocess$c.php
  sed -i -e "s/processAdditional/processAdditional$c/g" bin/lib/postprocess$c.php
  sed -i -e "s/\$tmpPath = \$this->site->tmpunrarpath;/\$tmpPath = \$this->site->tmpunrarpath; \\
                  \$tmpPath .= '$c';/g" bin/lib/postprocess$c.php
  sed -i -e "s/order by r.postdate desc limit %d.*\$/order by r.guid asc limit %d, %d \", (\$maxattemptstocheckpassworded + 1) * -1, $c * \$numtoProcess, \$numtoProcess));/g" bin/lib/postprocess$c.php
  sed -i -e "s/PostPrc : Performing additional post processing.*\$/PostPrc : Performing additional post processing by guid on \".\$rescount.\" releases, starting at $d ...\";/g" bin/lib/postprocess$c.php

  cp bin/lib/alternate bin/processAlternate$c.php
  sed -i -e "s/1/$c/g" bin/processAlternate$c.php
done

cp $NEWZPATH/www/lib/postprocess.php bin/lib/postprocess1.php
cp bin/lib/alternate bin/processAlternate1.php

#edit postprocessing scripts
sed -i -e 's/PostProcess/PostProcess1/g' bin/lib/postprocess1.php
sed -i -e 's/processAdditional/processAdditional1/g' bin/lib/postprocess1.php
sed -i -e 's/$tmpPath = $this->site->tmpunrarpath;/$tmpPath = $this->site->tmpunrarpath; \
               $tmpPath .= '1';/g' bin/lib/postprocess1.php
sed -i -e 's/order by r.postdate desc limit %d.*$/order by r.guid desc limit %d ", ($maxattemptstocheckpassworded + 1) * -1, $numtoProcess));/g' bin/lib/postprocess1.php
sed -i -e 's/PostPrc : Performing additional post processing.*$/PostPrc : Performing additional post processing by guid on ".$rescount." releases ...";/g' bin/lib/postprocess1.php

printf "\033]0; $TMUX_SESSION\007\003\n"
$TMUXCMD -f $TMUX_CONF new-session -d -s $TMUX_SESSION -n $TMUX_SESSION 'cd bin && echo "Monitor Started" && echo "It might take a minute for everything to spinup......" && $NICE -n 19 $PHP monitor.php'
$TMUXCMD selectp -t 0
$TMUXCMD splitw -h -p 72 'echo "..."'
$TMUXCMD splitw -h -p 50 'echo "..."'
$TMUXCMD selectp -t 0
$TMUXCMD splitw -v -p 60 'echo "..."'
if [[ $NZB_THREADS == "true" ]]; then
  $TMUXCMD splitw -v -p 60 'echo "..."'
else
  $TMUXCMD splitw -v -p 85 'echo "..."'
fi
$TMUXCMD splitw -v -p 50 'echo "..."'
$TMUXCMD selectp -t 4
$TMUXCMD splitw -v -p 83 'echo "..."'
$TMUXCMD splitw -v -p 80 'echo "..."'
$TMUXCMD splitw -v -p 75 'echo "..."'
$TMUXCMD splitw -v -p 67 'echo "..."'
$TMUXCMD splitw -v -p 50 'echo "..."'
$TMUXCMD selectp -t 10
$TMUXCMD splitw -v -p 75 'echo "..."'
$TMUXCMD splitw -v -p 67 'echo "..."'
$TMUXCMD splitw -v -p 50 'echo "..."'
$TMUXCMD new-window -n cleanup 'echo "..."'
$TMUXCMD selectp -t 0
$TMUXCMD splitw -h -p 75 'echo "..."'
$TMUXCMD splitw -h -p 67 'echo "..."'
$TMUXCMD splitw -h -p 50 'echo "..."'
$TMUXCMD selectp -t 0
$TMUXCMD splitw -v -p 50 'echo "..."'
$TMUXCMD selectp -t 2
$TMUXCMD splitw -v -p 50 'echo "..."'
$TMUXCMD selectp -t 4
$TMUXCMD splitw -v -p 50 'echo "..."'
$TMUXCMD selectp -t 6
$TMUXCMD splitw -v -p 50 'echo "..."'
$TMUXCMD new-window -n postprocessing 'echo "..."'

$TMUXCMD selectp -t 0
$TMUXCMD splitw -h -p 50 'echo "..."'
$TMUXCMD selectp -t 0
$TMUXCMD splitw -v -p 50 'echo "..."'
$TMUXCMD selectp -t 2
$TMUXCMD splitw -v -p 50 'echo "..."'
$TMUXCMD selectp -t 0
$TMUXCMD splitw -h -p 50 'echo "..."'
$TMUXCMD selectp -t 2
$TMUXCMD splitw -h -p 50 'echo "..."'
$TMUXCMD selectp -t 4
$TMUXCMD splitw -h -p 50 'echo "..."'
$TMUXCMD selectp -t 6
$TMUXCMD splitw -h -p 50 'echo "..."'

if [[ $USE_HTOP == "true" ]]; then
      $TMUXCMD new-window -n htop '$HTOP'
fi

if [[ $USE_NMON == "true" ]]; then
      $TMUXCMD new-window -n nmon '$NMON -t'
fi

if [[ $USE_BWMNG == "true" ]]; then
      $TMUXCMD new-window -n bwm-ng '$BWMNG'
fi

if [[ $USE_IOTOP == "true" ]]; then
      $TMUXCMD new-window -n iotop '$IOTOP -o'
fi

if [[ $USE_MYTOP == "true" ]]; then
      $TMUXCMD new-window -n mytop '$MYTOP -u $DB_USER -p $DB_PASSWORD -d $DB_NAME -h $DB_HOST'
fi

if [[ $USE_VNSTAT == "true" ]]; then
      $TMUXCMD new-window -n vnstat 'watch $VNSTAT'
fi

if [[ $USE_IFTOP == "true" ]]; then
      $TMUXCMD new-window -n iftop '$IFTOP'
fi

$TMUXCMD new-window -n Console 'bash -i'
$TMUXCMD select-window -t$TMUX_SESSION:0
$TMUXCMD attach-session -d -t$TMUX_SESSION

exit
