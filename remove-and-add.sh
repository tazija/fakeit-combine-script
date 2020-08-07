#!/usr/bin/env bash

rm combined-json.sh
rm generator-json.sh
rm push-json-6.sh
rm push-json-9.sh
rm push-json-18.sh

cd ../fakeit-combine-script/ && git pull
cp * ../fakeit
cd ../fakeit

chmod +x remove-and-add.sh
chmod +x combined-json.sh
chmod +x generator-json.sh
chmod +x push-json-6.sh
chmod +x push-json-9.sh

cp customers_template.yaml models/
cp orders_template.yaml models/
