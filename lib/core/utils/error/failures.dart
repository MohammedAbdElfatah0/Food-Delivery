abstract class Failure {
  final String message;
  Failure(this.message);
}

class FirebaseFailure extends Failure {
  FirebaseFailure(String message) : super(message);
}

class ServerFailure extends Failure {
  ServerFailure(String message) : super(message);
}

class OfflineFailure extends Failure {
  OfflineFailure(String message) : super(message);
}
