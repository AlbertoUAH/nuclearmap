#!/bin/sh
#!/usr/bin/env bash
export SSL_VERSION=TLSv1_2
export SSL_VALIDATE=false

cd ../u00/app/cassandra/product/apache-cassandra-3.11.5/bin

TIPO=$1
PAIS=$2

echo "           _ ._  _ , _ ._"
echo "         (_ ' ( `  )_  .__)"
echo "       ( (  (    )   `)  ) _)"
echo "     (__ (_   (_ . _) _) ,__)"
echo "          '--'\ ' . /'--'"
echo "               ;   ;"
echo "               /   \\"
echo " _____________/  __ \_____________"

CQL_QUERY="SELECT id, country, latitude, longitude FROM coordinates.nuclear WHERE country = '$PAIS' ALLOW FILTERING;"
if [ "$TIPO" = "-c" ]; then 
    echo "country filter has been detected"
    ./cqlsh alberto-cosmos.cassandra.cosmos.azure.com 10350 -u alberto-cosmos -p LKRvao2UbOYGDHtyYmmi9gpuHXDkD8nBktLJrL7AwjtVjAIippsVcIGLN8n9uWDFCown7rGqOtH5r9ArrdAc9g== --ssl -e "$CQL_QUERY" > '/home/alberto/ubuntu/coordenadas.csv'
    sed -i 's/|/,/g' /home/alberto/ubuntu/coordenadas.csv
    sed -i 's/+//g' /home/alberto/ubuntu/coordenadas.csv
    sed -i -n -e '/(/,/)/!p' /home/alberto/ubuntu/coordenadas.csv
    sed -i '/^$/d' /home/alberto/ubuntu/coordenadas.csv
    sed -i 's/ //g' /home/alberto/ubuntu/coordenadas.csv
    sed -i '1d' /home/alberto/ubuntu/coordenadas.csv
    sed -i '1d' /home/alberto/ubuntu/coordenadas.csv

else 
    echo "country filter has not been detected"
    ./cqlsh alberto-cosmos.cassandra.cosmos.azure.com 10350 -u alberto-cosmos -p LKRvao2UbOYGDHtyYmmi9gpuHXDkD8nBktLJrL7AwjtVjAIippsVcIGLN8n9uWDFCown7rGqOtH5r9ArrdAc9g== -f '/home/alberto/ubuntu/generalQuery.cql' --ssl
fi

cd /home/alberto/ubuntu
python ./app.py

cd ./nuclearmap.github.io
#git fetch origin
#git reset --hard origin/master
#git pull
#cp ../index.html ./
#git add --all
#git config --global user.email "alberteinstein.al@gmail.com"
#git config --global user.name "AlbertoUAH"
#git commit -m "Commit Inicial"
#git push -u origin master
#./index.html
