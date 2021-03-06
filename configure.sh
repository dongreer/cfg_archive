[ ! -r /etc/onabase ] && echo "[$0] ERROR: Unable to read /etc/onabase." && exit 1
ONABASE=`cat /etc/onabase`

echo 
echo "This script will reset any adjustments you have made to your cfg_archive configurations in $ONABASE/etc. "
echo -n "Are you sure? [y/n] "
read PROMPT
if [ "$PROMPT" = "y" ]
then

  # make sure they have netcat
  type -P netcat &>/dev/null || { echo "Unable to find netcat binary. Please install netcat (http://netcat.sf.net)." >&2; exit 1; }  

  # Remove existing symlinks
  rm $ONABASE/bin/cfg_archive
  rm $ONABASE/bin/cfg_archive_procspool
  rm $ONABASE/bin/cfg_archive_cisco_trapscript
  rm $ONABASE/bin/cisco_cfg_expect
  rm $ONABASE/bin/cisco_cmd
  rm $ONABASE/bin/cisco_asa_cmd
  rm $ONABASE/bin/motorola_wing_cmd
  rm $ONABASE/bin/cisco_cfg_snmp
  rm $ONABASE/bin/juniper_cmd
  rm $ONABASE/bin/netscreen_cmd
  rm $ONABASE/bin/extreme_networks_cmd

  # Create new symlinks
  ln -s $ONABASE/www/local/plugins/cfg_archive/bin/cfg_archive $ONABASE/bin/cfg_archive
  ln -s $ONABASE/www/local/plugins/cfg_archive/bin/cfg_archive_procspool $ONABASE/bin/cfg_archive_procspool
  ln -s $ONABASE/www/local/plugins/cfg_archive/bin/cfg_archive_cisco_trapscript $ONABASE/bin/cfg_archive_cisco_trapscript
  ln -s $ONABASE/www/local/plugins/cfg_archive/bin/cisco_cfg_expect $ONABASE/bin/cisco_cfg_expect
# ln -s $ONABASE/bin/cisco_cfg_expect $ONABASE/bin/cisco_cmd
  ln -s $ONABASE/www/local/plugins/cfg_archive/bin/cisco_cmd $ONABASE/bin/cisco_cmd
  ln -s $ONABASE/www/local/plugins/cfg_archive/bin/cisco_asa_cmd $ONABASE/bin/cisco_asa_cmd
  ln -s $ONABASE/www/local/plugins/cfg_archive/bin/motorola_wing_cmd $ONABASE/bin/motorola_wing_cmd
  ln -s $ONABASE/www/local/plugins/cfg_archive/bin/cisco_cfg_snmp $ONABASE/bin/cisco_cfg_snmp
  ln -s $ONABASE/www/local/plugins/cfg_archive/bin/juniper_cmd $ONABASE/bin/juniper_cmd
  ln -s $ONABASE/www/local/plugins/cfg_archive/bin/juniper_cmd $ONABASE/bin/netscreen_cmd
  ln -s $ONABASE/www/local/plugins/cfg_archive/bin/extreme_networks_cmd $ONABASE/bin/extreme_networks_cmd

  # move our initial configuration files into place
  # this is the destructive part if you have modified your etc configurations.  This resets back to initial installation
  install -m 644 -t $ONABASE/etc etc/*
  install -m 644 -t $ONABASE/sql sql/*

  # Create local archive directory
  [ -d $ONABASE/cfg_archive_local ] || mkdir $ONABASE/cfg_archive_local

  # Create spool directory
  [ -d $ONABASE/spool ] || mkdir $ONABASE/spool
  [ -d $ONABASE/spool/cfg_archive ] || mkdir $ONABASE/spool/cfg_archive

  echo "Done."

else
  echo "Exiting without changes."
fi

echo
