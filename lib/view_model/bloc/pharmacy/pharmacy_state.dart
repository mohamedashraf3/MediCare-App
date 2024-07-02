part of 'pharmacy_cubit.dart';

sealed class PharmacyState {}

final class PharmacyInitial extends PharmacyState {}

final class SelectMethodSuccess extends PharmacyState {}

final class IncrementCounterSuccess extends PharmacyState {}

final class DecrementCounterSuccess extends PharmacyState {}

final class TakeImageLoadingState extends PharmacyState {}

final class TakeImageSuccessState extends PharmacyState {}

final class TakeImageErrorState extends PharmacyState {}

final class ShowBackSideCard extends PharmacyState {}

final class OnChangeController extends PharmacyState {}

final class CardSavedState extends PharmacyState {}

final class PharmacySavedState extends PharmacyState {}

final class AddToCartList extends PharmacyState {}

class LoadingSavedPharmaciesState extends PharmacyState {}
class LoadingPharmaciesState extends PharmacyState {}
class PharmaciesLoadedState extends PharmacyState {}
class PharmaciesErrorState extends PharmacyState {}

class SavedPharmaciesLoadedState extends PharmacyState {
  SavedPharmaciesLoadedState();
}
