mapboxgl.accessToken = 'pk.eyJ1IjoibmFzc2FjYXJpdGFzIiwiYSI6ImNqa2FweGhqcTF2dm4zd24xa2w0c3pzNDkifQ.IIEkXeNO8hhuQZu-Mw7Frg';

$(document).ready(function(){

    var map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/streets-v10',
        center: [118.745, 9.830],
        zoom: 9,
        minZoom: 7,
        maxZoom: 18,
        // maxBounds: [[124.95, 11.03], [125.05, 11.08]]
    });

    map.addControl(new mapboxgl.NavigationControl(), 'top-left');

    map.on('load', function () {

        map.addSource(
            'flood', {
                type: 'geojson',
                data: 'flood.geojson',
            }
        );

        map.addSource(
            'landslide', {
                type: 'geojson',
                data: 'landslide.geojson',
            }
        );

        map.addSource(
            'storm-surge', {
                type: 'geojson',
                data: 'storm-surge.geojson',
            }
        );

        map.addSource(
            'tsunami', {
                type: 'geojson',
                data: 'tsunami.geojson',
            }
        );

        map.addSource(
            'barangays', {
                type: 'geojson',
                data: 'barangays.geojson',
            }
        );

        map.addSource(
            'building-footprints', {
                type: 'geojson',
                data: 'building-footprints.geojson',
            }
        );

        map.addLayer({
            'id': 'flood',
            'type': 'fill',
            'source': 'flood',
            'layout': {
                'visibility': 'visible'
            },
            'paint': {
                'fill-color': ['match',
                                  ['get', 'FloodSusc'],
                                  'HF', '#0000fe',
                                  'LF', '#75cff0',
                                  'MF', '#c896ff',
                                  'VHF', '#00064d',
                                  'rgb(171, 72, 33)'
                              ],
                'fill-outline-color': ['match',
                                  ['get', 'FloodSusc'],
                                  'HF', '#0000fe',
                                  'LF', '#75cff0',
                                  'MF', '#c896ff',
                                  'VHF', '#00064d',
                                  'rgb(171, 72, 33)'
                              ],
                'fill-opacity': 0.7
            }
        });

        map.addLayer({
            'id': 'landslide',
            'type': 'fill',
            'source': 'landslide',
            'layout': {
                'visibility': 'visible'
            },
            'paint': {
                'fill-color': ['match',
                                  ['get', 'LndslideSu'],
                                  'VHL', '#750000',
                                  'HL', '#e31a1c',
                                  'ML', '#33a02c',
                                  'LL', '#ffff01',
                                  'rgb(171, 72, 33)'
                              ],
                'fill-outline-color': ['match',
                                  ['get', 'LndslideSu'],
                                  'VHL', '#750000',
                                  'HL', '#e31a1c',
                                  'ML', '#33a02c',
                                  'LL', '#ffff01',
                                  'rgb(171, 72, 33)'
                              ],
                'fill-opacity': 0.7
            }
        });

        map.addLayer({
            'id': 'storm-surge',
            'type': 'fill',
            'source': 'storm-surge',
            'layout': {
                'visibility': 'visible'
            },
            'paint': {
                'fill-color': ['match',
                                  ['get', 'HAZ'],
                                  1.0, '#effb08',
                                  2.0, '#ff7f00',
                                  3.0, '#e31a1c',
                                  '#cf4320'
                              ],
                'fill-outline-color': ['match',
                                  ['get', 'HAZ'],
                                  1.0, '#effb08',
                                  2.0, '#ff7f00',
                                  3.0, '#e31a1c',
                                  '#cf4320'
                              ],
                'fill-opacity': 0.7
            }
        });

        map.addLayer({
            'id': 'tsunami',
            'type': 'fill',
            'source': 'tsunami',
            'layout': {
                'visibility': 'visible'
            },
            'paint': {
                'fill-color': 'blue',
                'fill-outline-color': 'blue',
                'fill-opacity': 0.7
            }
        });

        map.addLayer({
            'id': 'barangays',
            'type': 'line',
            'source': 'barangays',
            'layout': {
                'visibility': 'visible'
            },
            'paint': {
                'line-color': 'black',
            }
        });

        map.addLayer({
            'id': 'building-footprints',
            'type': 'fill-extrusion',
            'source': 'building-footprints',
            'layout': {
                'visibility': 'visible'
            },
            'paint': {
                // 'fill-extrusion-color': 'red',
                'fill-extrusion-color': 'red',
                'fill-extrusion-opacity': 0.75,
                'fill-extrusion-height': 20,
            },
        });
    });

    map.resize();

    var toggleableLayerIds = [ 'Flood', 'Landslide', 'Storm Surge', 'Tsunami', 'Barangays', 'Building Footprints' ];

    for (var i = 0; i < toggleableLayerIds.length; i++) {
        var id = toggleableLayerIds[i];

        var link = document.createElement('a');
        link.href = '#';
        link.className = 'active';
        link.textContent = id;

        link.onclick = function (e) {
        // var clickedLayer = this.textContent.split(" ").join("-").toLowerCase() + '_puerto-princesa';
        var clickedLayer = this.textContent.split(" ").join("-").toLowerCase();
        e.preventDefault();
        e.stopPropagation();

        var visibility = map.getLayoutProperty(clickedLayer, 'visibility');

        if (visibility === 'visible') {
        map.setLayoutProperty(clickedLayer, 'visibility', 'none');
        this.className = '';
        } else {
        this.className = 'active';
        map.setLayoutProperty(clickedLayer, 'visibility', 'visible');
        }
        };

        var layers = document.getElementById('menu');
        layers.appendChild(link);
    }

});
