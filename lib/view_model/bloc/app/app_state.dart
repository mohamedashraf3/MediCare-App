part of 'app_cubit.dart';

sealed class AppState {}

final class AppInitial extends AppState {}

final class SelectedItemState extends AppState {}

final class SwitchChangedState extends AppState {}

final class BottomNavigatorIndex extends AppState {}

final class ProfileIndexChanged extends AppState {}

final class AlarmWithPermissionLoading extends AppState {}

final class AlarmWithPermissionSuccess extends AppState {}

final class AlarmWithPermissionError extends AppState {}

final class AlarmScheduledSuccess extends AppState {}

final class AlarmScheduledError extends AppState {}

final class UpdateNotificationTypeState extends AppState {}

final class PermissionRequestLoading extends AppState {}

final class PermissionRequestSuccess extends AppState {}

final class PermissionRequestError extends AppState {}

final class ShowNotificationSuccess extends AppState {}

final class ShowNotificationError extends AppState {}

final class AlarmSuccess extends AppState {}
class LocationServiceDisabledState extends AppState {}
class LocationPermissionDeniedState extends AppState {}
class LocationPermissionDeniedForeverState extends AppState {}
class LocationGrantedState extends AppState {}
class LocationPositionState extends AppState {}
class LocationFetchingState extends AppState {}
class LocationAddressLoadedState extends AppState {}
class LocationAddressLoadingState extends AppState {}
class LocationAddressErrorState extends AppState {}
class CurrentPositionLoadedState extends AppState {}
class CurrentPositionErrorState extends AppState {}