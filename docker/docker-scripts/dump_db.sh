dumpdir=./backup
if [ -d "$dumpdir" ]; then
   rm $dumpdir/*.sql
else
   mkdir $dumpdir
fi
echo Dumping databases to "$dumpdir."
echo '\c synapse' > $dumpdir/prefix.sql

pg_dump -U mattermost -d synapse > $dumpdir/synapse.tmp
cat $dumpdir/prefix.sql  $dumpdir/synapse.tmp > $dumpdir/synapse.sql

pg_dump -U mattermost -d mattermost > $dumpdir/mattermost.sql
pg_dump -U  mm-matrix-bridge -d  mm-matrix-bridge > $dumpdir/mm-matrix-bridge.tmp
echo '\c  mm-matrix-bridge' > $dumpdir/prefix.sql
cat $dumpdir/prefix.sql  $dumpdir/mm-matrix-bridge.tmp > $dumpdir/mm-matrix-bridge.sql
rm $dumpdir/prefix.sql
rm $dumpdir/*.tmp 
