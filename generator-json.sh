folder_count=4000
record_count=25000
thread_count=20

max_folder_count_per_thread=$(python -c "from math import ceil; print int(ceil($folder_count.0/$thread_count.0))")

mkdir -p models results &> /dev/null

function generate {
  local start_index=$1
  local count_per_thread=$2
  local end_index=`expr $start_index + $count_per_thread`; echo $end_index
  local record_count=$3
  for index in `seq $start_index $end_index`; do
    n=$(($index * $record_count))
    sed "s/%customer_id%/${n}/g" ./customers_template.yaml > ./models/customers_generated_$index.yaml
    sed "s/%order_id%/${n}/g" ./orders_template.yaml > ./models/orders_generated_$index.yaml
    echo "$(date) >> generating customers and orders for ids from ${n}"
    fakeit -m ./models/customers_generated_$index.yaml,./models/orders_generated_$index.yaml -n $record_count -o json -d ./results/$index
    ./combined-json.sh $index $index
    rm -rf ./models/customers_generated_$index.yaml ./models/orders_generated_$index.yaml $./results/$index &> /dev/null
  done
}

for ((folder_index = 0, thread = 0; thread < thread_count; thread++, folder_index+=max_folder_count_per_thread)); do
  folder_count_per_thread=$(python -c "print min($max_folder_count_per_thread, $folder_count - $folder_index)")
  if ((folder_count_per_thread > 0)); then
    generate $folder_index $folder_count_per_thread $record_count &
  fi
done
