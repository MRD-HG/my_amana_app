import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Menu/MenuSide.dart';

void main() {
  runApp(const AgencLoc());
}

class AgencLoc extends StatelessWidget {
  const AgencLoc({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapPage(),
    );
  }
}

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;

  final LatLng initialPosition = const LatLng(37.7749, -122.4194); // San Francisco

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: appB(context),
      drawer: darweF(context),
       body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: initialPosition,
          zoom: 12.0,
        ),
      ),
       bottomNavigationBar:const NavBottom(),
    );
  }
}
     
     