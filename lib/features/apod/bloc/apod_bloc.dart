import 'package:apod/models/apod_model.dart';
import 'package:apod/repository/apod_repository.dart';
import 'package:rxdart/subjects.dart';

class ApodBloc {
  final _apodData = BehaviorSubject<ApodModel>();

  Stream get apodData => _apodData.stream;

  void loadNewData(DateTime date) {
    APODRepository.getApodForDate(date ?? DateTime.now()).then((value) {
      if (value != null) {
        value.fold(
          (l) => _apodData.addError(l.error),
          (r) => _apodData.add(r),
        );
      }
    });
  }

  void dispose() {
    _apodData.close();
  }
}
