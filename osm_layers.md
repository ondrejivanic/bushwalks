# Australia

```
wget http://download.geofabrik.de/australia-oceania/australia-latest.osm.pbf
```

# Import

```
osm2pgsql -c -C 20000 --number-processes 20 --username ondrej --database planet australia-latest.osm.pbf 
```

# Layers


