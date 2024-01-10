#!/bin/sh
export PGPASSWORD='Yugabyte12#'
./tserver/bin/ysqlsh -h 10.36.2.151 -d amex -c "delete from account_balance;"
./tserver/bin/ysqlsh -h 10.36.2.151 -d amex -c "insert into account_balance(id,name,salary) select id, concat('name',id),1000000 from generate_series(1,10000) as id;"

for ((i=1 ;i<1000 ;i++ ))
do
   ./tserver/bin/ysqlsh  -h 10.36.2.151 -d amex -c  "BEGIN TRANSACTION;
    UPDATE account_balance set salary = salary + 50 where id in (select id from account_balance  order by random() limit 1);
    UPDATE account_balance set salary = salary - 50 where id in (select id from account_balance  order by random() limit 1);
    UPDATE account_balance SET salary = salary + 20 where id in (select id from account_balance  order by random() limit 1);
    UPDATE account_balance SET salary = salary - 10 where id in (select id from account_balance  order by random() limit 1);
    UPDATE account_balance SET salary = salary - 10 where id in (select id from account_balance  order by random() limit 1);
COMMIT;"
done
