#!/bin/bash

source ./osm_export.sh

dir=$(basename $0 .sh)
map=${dir}/${dir}.tgz
png=${dir}/${dir}.png
svg=${dir}/${dir}.svg

mkdir -p ${dir}

rm -f ${map} ${png} ${svg}

nswtopo init -c 150.331000,-34.226183,150.449563,-34.311764 ${map}
nswtopo add ${map} nsw/vegetation-spot5
nswtopo add ${map} nsw/topographic
nswtopo grid ${map} 
nswtopo contours -i 10 -x 50 --replace nsw.topographic.contours ${map} ${dir}/dem.zip 

while read id name; do
	db_export ${id} ${name}
	nswtopo overlay --stroke black --stroke-width 0.25 --stroke-dasharray 1.4,0.7 ${map} ${name}.kml
	rm ${name}.kml
done <<OSM
240253893 way_1
240253894 way_2
240253895 starlights_trail
249652591 nattai_road_w11e_1
281277037 rocky_waterholes_creek_trail
281277038 ahearn_lookout_track
281777562 nattai_road_w11e_2
281777579 nattai_national_park
287029412 slott_way_track
287063315 troys_creek_fire_trail
289302416 way_3
705651537 troys_creek_track_2
705651538 troys_creek_track_1
OSM

nswtopo overlay --stroke "#ccff00" --stroke-width 1.5 --stroke-opacity 0.6 ${map} ${dir}/krokodile_4.kml

nswtopo controls ${map} ${dir}/controls.kml

nswtopo render -o ${map} ${png} ${svg}

map_aerial=${dir}/${dir}_aerial.tgz
png_aerial=${dir}/${dir}_aerial.png

cp ${map} ${map_aerial}

nswtopo delete ${map_aerial} \
	nsw.vegetation-spot5 \
	contours \
	nsw.topographic.watercourses \
	nsw.topographic.stock-dams \
	nsw.topographic.water-areas

nswtopo add --resolution 1.0 ${map_aerial} nsw/aerial

nswtopo render -o ${map_aerial} ${png_aerial}
