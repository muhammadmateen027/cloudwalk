part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {
  const DashboardEvent();

  List<Object> get props => [];
}
class LoadCurrentLocation extends DashboardEvent {}
