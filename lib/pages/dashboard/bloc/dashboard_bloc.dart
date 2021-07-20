
import 'package:bloc/bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cloudwalk/repository/repository.dart';
import 'package:cloudwalk/utility/exceptions/exceptions.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({required this.apiService, required this.locationService})
      : super(DashboardInitial()) {
    on<LoadCurrentLocation>(_loadCurrentLocation);
  }

  final ApiService apiService;
  final LocationInterface locationService;

  void _loadCurrentLocation(LoadCurrentLocation event,
      Emit<DashboardState> emit) async {
    var isInternetAvailable = await _internetAvailable();
    var locationAvailable = await locationService.locationStatus();

    if (locationAvailable && !isInternetAvailable) {
      var position = await locationService.getCurrentPosition();

      if(position != null) {
        var latLong = LatLng(position.latitude, position.longitude);
        var marker = locationService.getMarker(latLong);

        emit(CoordinatesLoaded(latLng: latLong, marker: marker));
        return;
      }
    }

    try {
      var response = await apiService.getCurrentLocationFrom();

      var latLong = LatLng(response.data['lat'], response.data['lon']);
      var marker = locationService.getMarker(latLong);

      emit(CoordinatesLoaded(latLng: latLong, marker: marker));
    } on NetworkException catch (message){

      BotToast.showText(text: message.toString(), contentColor: Colors.red);

      var position = await locationService.getLastKnownLocation();
      if (position == null) {
        BotToast.showText(text: 'Services are not available.');
        return;
      }

      var latLong = LatLng(position.latitude, position.longitude);
      var marker = locationService.getMarker(latLong);
      emit(CoordinatesLoaded(latLng: latLong, marker: marker));
      return;
    }
  }
}


Future<bool> _internetAvailable() async {
  var connectivityResult = await Connectivity().checkConnectivity();

  if (connectivityResult == ConnectivityResult.none) {
    return false;
  }

  return true;
}


