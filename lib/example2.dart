import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_map/data/api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place_updated/search_map_place_updated.dart';

class Example2 extends StatefulWidget {
  const Example2({super.key});

  @override
  State<Example2> createState() => _Example2State();
}

class _Example2State extends State<Example2> {
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng destination = LatLng(23.874510, 90.380980);
  static const LatLng sourceLocation = LatLng(23.868971, 90.381783);

  List<LatLng> polylineCoordinates = [];

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey,
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(destination.latitude, destination.longitude));
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polylineCoordinates.add(LatLng(point.latitude, point.longitude)));
    }
    setState(() {

    });
  }
  @override
  void initState() {
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // SearchMapPlaceWidget(
            //     apiKey: "AIzaSyANAAs0t1wT_aHvoUlr4kqlUzqgIybTu6k",
            // onSelected: (Place place)async{
            //       Geolocation? geolocation=await place.geolocation;
            // },
            // ),
            SizedBox(
              height: 500.0,
              child: GoogleMap(
                polylines: {
                  Polyline(polylineId: PolylineId("route"),
                  points: polylineCoordinates
                  )
                },
                mapType: MapType.satellite,
                initialCameraPosition:
                    const CameraPosition(target: sourceLocation, zoom: 15),
                // onMapCreated: (GoogleMapController googleMapController) {
                //   setState(() {
                //     mapController = googleMapController;
                //   });
                // },
                markers: {
                  Marker(
                      markerId: MarkerId("source"), position: sourceLocation),
                  const Marker(
                      markerId: MarkerId("destination"), position: destination)
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
