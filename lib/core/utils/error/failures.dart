abstract class Failure {
  final String message;
  Failure(this.message);
}

class FirebaseFailure extends Failure {
  FirebaseFailure(super.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}

class OfflineFailure extends Failure {
  OfflineFailure(super.message);
}
