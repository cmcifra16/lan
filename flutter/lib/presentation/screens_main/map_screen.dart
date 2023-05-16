import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Hazard {
  final String templateUrl;
  final String title;

  Hazard({required this.templateUrl, required this.title});
}

List<Hazard> dropdown = [
  Hazard(
      templateUrl:
          'https://api.mapbox.com/styles/v1/dankz01/cl8dwollz003n14mvp6oxul1d/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZGFua3owMSIsImEiOiJjbDU2Zzl1NTAwYzl0M2luYmRkNjZoMHlpIn0.-hCnY7ZjwBW0Wf91zheEPg',
      title: 'Flood'),
  Hazard(
      templateUrl:
          'https://api.mapbox.com/styles/v1/dankz01/cl8dwxk5l000515rkr74pah51/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZGFua3owMSIsImEiOiJjbDU2Zzl1NTAwYzl0M2luYmRkNjZoMHlpIn0.-hCnY7ZjwBW0Wf91zheEPg',
      title: 'Land Slide'),
  Hazard(
      templateUrl:
          'https://api.mapbox.com/styles/v1/dankz01/cl8dwzr4g001h14nsoiamysoa/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZGFua3owMSIsImEiOiJjbDU2Zzl1NTAwYzl0M2luYmRkNjZoMHlpIn0.-hCnY7ZjwBW0Wf91zheEPg',
      title: 'storm'),
];

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Hazard template = dropdown.first;
  LatLng? currentLocation;
  MapController mapController = MapController();
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _getMarkersFromFirestore();
  }

  Future<void> _requestLocationPermission() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // TODO: Handle denied permission
    } else if (permission == LocationPermission.deniedForever) {
      // TODO: Handle permanently denied permission
    } else {
      _getCurrentLocation();
      _getMarkersFromFirestore();
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
      markers.add(Marker(
        point: currentLocation!,
        builder: (context) => Icon(Icons.location_on),
      ));
      mapController.move(currentLocation!, 13);
    });
  }

  Future<void> _getMarkersFromFirestore() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('locations').get();

    List<Marker> newMarkers = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      double latitude = double.tryParse(data['latitude'].toString()) ?? 0.0;
      double longitude = double.tryParse(data['longitude'].toString()) ?? 0.0;
      String title = data['title'] ?? '';
      String description = data['description'] ?? '';
      LatLng latLng = LatLng(latitude, longitude);
      return Marker(
        point: latLng,
        builder: (context) => Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_pin,
                size: 50,
                color: Colors.blue,
              ),
              SizedBox(height: 5),
              SizedBox(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 8,
                  ),
                ),
              ),
              SizedBox(height: 5),
              SizedBox(
                width: 100, // set the width for the description
                child: Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 6,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();

    setState(() {
      markers.addAll(newMarkers);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FlutterMap(
          mapController: mapController,
          options: MapOptions(
              center: currentLocation ?? LatLng(9.239878, 126.024329),
              zoom: 13.0),
          nonRotatedChildren: [
            TileLayer(
              urlTemplate: template.templateUrl,
              additionalOptions: {
                'accessToken':
                    'pk.eyJ1IjoiZGFua3owMSIsImEiOiJjbDU2Zzl1NTAwYzl0M2luYmRkNjZoMHlpIn0.-hCnY7ZjwBW0Wf91zheEPg',
                'id': 'mapbox.mapbox-streets-v8'
              },
            ),
            MarkerLayer(
              markers: markers,
            ),
            Column(
              children: [
                const SizedBox(height: 70),
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: DropdownButton<Hazard>(
                      isDense: true,
                      value: template,
                      underline: const SizedBox.shrink(),
                      items: dropdown.map((e) {
                        return DropdownMenuItem<Hazard>(
                          value: e,
                          child: Text(e.title),
                        );
                      }).toList(),
                      onChanged: (Hazard? val) {
                        setState(() {
                          template = val!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                _getCurrentLocation();
              },
              tooltip: 'Show Current Location',
              child: Icon(Icons.location_on),
            ),
            SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
