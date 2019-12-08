# Random notes

## Conda enviroment

```
conda env create -f environment.yml
```

## Run setup

Requires `Chromium` or `Chrome` brower and SPOT5 vegeration layers perest

```
./setup.sh
```

## OSM Australia

Requires PostgreSQL database (named `planet`) with `PostGIS` extension

```
wget http://download.geofabrik.de/australia-oceania/australia-latest.osm.pbf
osm2pgsql -c -C 20000 --number-processes 20 --username $(whoami) --database planet australia-latest.osm.pbf 
```


