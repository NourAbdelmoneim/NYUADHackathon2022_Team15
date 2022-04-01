import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

Future<List<PointLatLng>> fetchRoute() async {
  final response = await http.get(
      Uri.parse('http://localhost:3000/shortest-path'),
      headers: {"Access-Control-Allow-Origin": "*"});

  if (response.statusCode == 200) {
    print(response.body);
    List<PointLatLng> s = [];
    return s;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Maps Sample App'),
              backgroundColor: Colors.green[700],
            ),
            body: Text("Hi")));
  }
}

class _MyAppState extends State<MyApp> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(37.772, -122.214);

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  // Object for PolylinePoints
  late PolylinePoints polylinePoints;

  // List of coordinates to join
  List<LatLng> polylineCoordinates = [];

  // Map storing polylines created by connecting two points
  Map<PolylineId, Polyline> polylines = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    final marker = Marker(
      markerId: MarkerId('place_name'),
      position: LatLng(9.669111, 80.014007),
      // icon: BitmapDescriptor.,
      infoWindow: InfoWindow(
        title: 'title',
        snippet: 'address',
      ),
    );

    setState(() {
      markers[MarkerId('place_name')] = marker;
    });
  }

// Create the polylines for showing the route between two places

  _createPolylines(
    double startLatitude,
    double startLongitude,
    double destinationLatitude,
    double destinationLongitude,
  ) async {
    // Initializing PolylinePoints
    polylinePoints = PolylinePoints();

    List<PointLatLng> list1 = [
      PointLatLng(13.388798, 52.517033),
      PointLatLng(13.397631, 52.529432),
      PointLatLng(-18.142, 178.431),
      PointLatLng(-27.467, 153.027),
    ];
    PolylineResult result = PolylineResult(points: list1);

    // Generating the list of coordinates to be used for
    // drawing the polylines
    // PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    //   "AIzaSyBUB-Fm7iZw7KlhuHrlwPVZ43KCsL7cwns", // Google Maps API Key
    //   PointLatLng(startLatitude, startLongitude),
    //   PointLatLng(destinationLatitude, destinationLongitude),
    //   travelMode: TravelMode.transit,
    // );

    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    // Defining an ID
    PolylineId id = PolylineId('poly');

    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );

    // Adding the polyline to the map
    polylines[id] = polyline;
  }

  @override
  Widget build(BuildContext context) {
    _createPolylines(9.669111, 80.014007, 9.669111, 80.114007);
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Maps Sample App'),
            backgroundColor: Colors.green[700],
          ),
          body: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              markers: markers.values.toSet(),
              polylines: Set<Polyline>.of(polylines.values))),
    );
  }
}
