import 'dart:async';

import 'package:cloudwalk/pages/dashboard/bloc/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  LatLng _initialPosition = LatLng(2.7426277, 101.6834318);
  Completer<GoogleMapController> _completer = Completer();
  late GoogleMapController controller;
  final double zoom = 10.5;
  List<Marker> myMarkers = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<DashboardBloc, DashboardState>(
      listener: (_, state) {
        if (state is CoordinatesLoaded) {
          var position = CameraPosition(target: state.latLng, zoom: zoom);
          controller.animateCamera(CameraUpdate.newCameraPosition(position));
          setState(() {
            myMarkers = [state.marker];
          });

          _completer.complete(controller);
        }
      },
      child: _googleMapView(),
    );
  }

  Widget _googleMapView() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: _initialPosition,
        zoom: zoom,
      ),
      mapType: MapType.normal,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: false,
      rotateGesturesEnabled: false,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      onMapCreated: _onMapCreated,
      markers: Set<Marker>.of(myMarkers),
    );
  }

  _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
  }
}
