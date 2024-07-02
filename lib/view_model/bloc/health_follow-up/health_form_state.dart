part of 'health_form_cubit.dart';

sealed class HealthFormState {}

final class HealthFormInitial extends HealthFormState {}

final class SelectDoneState extends HealthFormState {}

final class SelectDayState extends HealthFormState {}

final class StoreDoneState extends HealthFormState {}

final class MedicationFetchedState extends HealthFormState {}

final class NoMedicationFoundState extends HealthFormState {}

final class ClearDoneState extends HealthFormState {}

final class AddAnotherMedicationState extends HealthFormState {}

final class MedicationStatusUpdatedState extends HealthFormState {}

final class ScheduleDoneState extends HealthFormState {}

final class ScheduleErrorState extends HealthFormState {}

final class NearestMedicationFoundState extends HealthFormState {}

final class NearestMedicationNotFoundState extends HealthFormState {}

final class DeleteDoneState extends HealthFormState {}

final class SendMedicationFormLoadingState extends HealthFormState {}

final class SendMedicationFormSuccess extends HealthFormState {}

final class SendMedicationFormError extends HealthFormState {}
