#!/bin/sh
export  PGPASSWORD='Yugabyte12#'
for ((i=1 ;i<1000; i++ ))
do
./tserver/bin/ysqlsh -h 10.36.3.44 -d amex -c "select sum(salary) from account_balance";
done
