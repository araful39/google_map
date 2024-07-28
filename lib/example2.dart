import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place_updated/search_map_place_updated.dart';

class Example2 extends StatefulWidget {
  const Example2({super.key});

  @override
  State<Example2> createState() => _Example2State();
}

class _Example2State extends State<Example2> {
  late GoogleMapController mapController;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              SearchMapPlaceWidget(
                  apiKey: "AIzaSyANAAs0t1wT_aHvoUlr4kqlUzqgIybTu6k",
              onSelected: (Place place)async{
                    Geolocation? geolocation=await place.geolocation;
              },,
              ),
              SizedBox(
                height: 500.0,
                child: GoogleMap(
                  mapType: MapType.satellite,
                  initialCameraPosition: const CameraPosition(
                      target: LatLng(23.874510, 90.380980), zoom: 17),
                  onMapCreated: (GoogleMapController googleMapController) {
                    setState(() {
                      mapController = googleMapController;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
