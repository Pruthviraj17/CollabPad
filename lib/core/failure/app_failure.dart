class AppFailure {
  final String message;

  AppFailure([this.message = "Somthing went wrong!"]);

  @override
  String toString() => 'Failure(message: $message)';
}
