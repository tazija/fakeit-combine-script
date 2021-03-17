#!/usr/bin/env bash
folders=4000
records=25000
for i in `seq 2001 $folders`; do
    n=$((i * $records))
    sed "s/%customer_id%/${n}/g" ./models/customers_template.yaml > ./models/customers_generated.yaml
    sed "s/%order_id%/${n}/g" ./models/orders_template.yaml > ./models/orders_generated.yaml

    echo "$(date) >> generating customers and orders for ids from ${n}"
    fakeit -m ./models/customers_generated.yaml,./models/orders_generated.yaml -n $records -o json -d ./results/$i
done
