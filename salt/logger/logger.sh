#!/bin/bash
#
# script counts the lines of all /var/log/*.log files and outputs
# data to file /root/counts.log  using pipe delimited format of
#     datetime|filename|line count

LOGDIR=/var/log
OUTFILE=/root/counts.log
DATETIME=`date +%s`

cd ${LOGDIR}

for FILE in `ls -1 *.log`; do
	LINECOUNT=`cat ${FILE} | wc -l`

	echo "${DATETIME}|${FILE}|${LINECOUNT}" >> ${OUTFILE}
done

exit 0
