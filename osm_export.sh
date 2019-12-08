#!/bin/bash

function db_export {
	osm_id=$1
	name=$2

	tee "${name}.kml" <<-KML >/dev/null
	<?xml version="1.0" encoding="UTF-8"?>
	<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
		<name>${name}</name>
		<Placemark>
			<name>${name}</name>
			$(psql -d planet -At -c "select st_askml(way) from planet_osm_line where osm_id = ${osm_id}")
		</Placemark>
	</kml>
	KML
}


