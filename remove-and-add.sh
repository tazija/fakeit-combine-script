#!/usr/bin/env bash

rm combined-json.sh
rm generator-json.sh
rm push-json.sh

cd ../fakeit-combine-script/ && git pull
cp * ../fakeit
cd ../fakeit

chmod +x combined-json.sh
chmod +x generator-json.sh
chmod +x push-json.sh

cp customers_template.yaml models/
cp orders_template.yaml models/
