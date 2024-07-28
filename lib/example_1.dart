import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class Example1 extends StatefulWidget {
  const Example1({super.key});

  @override
  State<Example1> createState() => MapSampleState();
}

class MapSampleState extends State<Example1> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const CameraPosition classicIt = CameraPosition(
    target: LatLng(23.868971, 90.381783),
    zoom: 14.4746,
  );

  static const CameraPosition myLocation = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(23.874510, 90.380980),
      tilt: 59.440717697143555,
      zoom: 14.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: classicIt,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(myLocation));
  }
}