abstract class ChangePasswordState {}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordSaving extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {}

class ChangePasswordSaveError extends ChangePasswordState {
  final String error;

  ChangePasswordSaveError(this.error);
}
