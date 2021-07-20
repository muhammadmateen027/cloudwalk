part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState {
  const DashboardState();

  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class CoordinatesLoaded extends DashboardState {
  final LatLng latLng;
  final Marker marker;

  const CoordinatesLoaded({ required  this.latLng, required  this.marker});

  @override
  List<Object> get props => [latLng, this.marker];
}
