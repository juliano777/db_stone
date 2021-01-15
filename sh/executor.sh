#!/bin/bash

while getopts "a:h:p:d:U:f:c:t:s:e:" opt; do
case ${opt} in
	
	'a' | '--account_type')
		ACCOUNT_TYPE=${OPTARG}
		;;

	'h' | '--host')
		DBHOST=${OPTARG}
		;;

	'p' | '--port')
		DBPORT=${OPTARG}
		;;

	'd' | '--database')
		DBNAME=${OPTARG}
		;;

	'U' | '--username')
		DBUSER=${OPTARG}
		;;

	'f' | '--file')
		SQL_FILE=${OPTARG}
		;;

	'c' | '--clients')
		CLIENTS=${OPTARG}
		;;

	't' | '--transactions')
		TRANSACTIONS=${OPTARG}
		;;

	's' | '--start')
		START=${OPTARG}
		;;

	'e' | '--end')
		END=${OPTARG}
		;;


	\? )
		#print option error
		echo "Invalid option: $OPTARG" 1>&2
		;;

	: )
		#print argument error
		echo "Invalid option: $OPTARG requires an argument" 1>&2
		;;
esac
done

# Default values
ACCOUNT_TYPE=${ACCOUNT_TYPE:='1'}
DBHOST=${DBHOST:='localhost'}
DBPORT=${DBPORT:='5432'}
DBNAME=${DBNAME:='postgres'}
DBUSER=${DBUSER:='postgres'}
SQL_FILE=${SQL_FILE:='/tmp/test.sql'}
CLIENTS=${CLIENTS:='1'}
TRANSACTIONS=${TRANSACTIONS:='10'}
START=${START:='now()'}
END=${END:='now()'}

# ============================================================================

SQL="CALL sp_random_transfer(\
	${ACCOUNT_TYPE},
	fc_random_timestamp(${START}, ${END}));"

echo ${SQL} > ${SQL_FILE}

PGBENCH_OPTIONS="\
-h ${DBHOST} \
-p ${DBPORT} \
-U ${DBUSER} \
-f ${SQL_FILE} \
-c ${CLIENTS} \
-t ${TRANSACTIONS} \
${DBNAME}"


echo "pgbench ${PGBENCH_OPTIONS}"

pgbench ${PGBENCH_OPTIONS}
