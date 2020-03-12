import pandas as pd

# Create a dataframe from csv
df = pd.read_csv('coordenadas.csv', delimiter=',')
# User list comprehension to create a list of lists from Dataframe rows
arrayCoordenadas = [list(row) for row in df.values]
# -----------------------------------------
arrayCoordenadasString = '[%s]' % ', '.join(map(str, arrayCoordenadas))

#f = open('webapp.html','wb')

message = """<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://atlas.microsoft.com/sdk/javascript/mapcontrol/2/atlas.min.css" type="text/css">
        <script src="https://atlas.microsoft.com/sdk/javascript/mapcontrol/2/atlas.min.js"></script>

        <style>
            html, body {
              margin: 0;
            }
          
            #myMap {
              height: 100vh; 
              width: 100vw;
            }
          </style>
    </head>
<body>
    <div id="myMap"></div>
    <script type="text/javascript">
        var coordenadas = """ + arrayCoordenadasString + """;
        var map = new atlas.Map('myMap', {
          language: 'en-US',
          authOptions: {
            authType: 'subscriptionKey',
            subscriptionKey: 'N_dRXFpUMso9-sVtzK1VCWqBIM9Wu3lf_HQeYx_B3CI'
          }
        });
        map.events.add('ready', function () {
            var dataSource = new atlas.source.DataSource();
            map.sources.add(dataSource);

            for (var i = 0 ; i < coordenadas.length; i++) {
              dataSource.add(
                  new atlas.data.Feature(
                      new atlas.data.Point([coordenadas[i][3], coordenadas[i][2]])));
            }
            map.layers.add(new atlas.layer.SymbolLayer(dataSource, null));
        }); 
        
       
      </script>
</body>
</html>"""

# Write HTML String to file.html
with open("index.html", "w") as file:
    file.write(message)

#f.write(message)
file.close()
