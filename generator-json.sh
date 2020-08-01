#!/usr/bin/env bash
folders=2000
records=25000
for i in `seq 1 $folders`; do
    n=$((i * $records))
    sed "s/%customer_id%/${n}/g" ./models/customers_template.yaml > ./models/customers_generated.yaml
    sed "s/%order_id%/${n}/g" ./models/orders_template.yaml > ./models/orders_generated.yaml

    echo "$(date) >> generating customers and orders for ids from ${n}"
    bin/fakeit -m ./models/customers_generated.yaml,./models/orders_generated.yaml -n $records -o json -d ./results/$i
done