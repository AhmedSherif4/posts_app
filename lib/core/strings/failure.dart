import '../errors/failures.dart';

const String emptyCacheFailure = 'No Data';
const String serverFailure = 'Please try again later .';
const String offlineFailure = 'Please Check your Internet Connection';

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case EmptyCacheFailure:
      return emptyCacheFailure;
    case ServerFailure:
      return serverFailure;
    case OfflineFailure:
      return offlineFailure;
    default:
      return 'Unexpected Error, Please try again later.';
  }
}