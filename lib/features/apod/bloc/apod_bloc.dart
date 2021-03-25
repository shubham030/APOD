import 'package:apod/models/apod_model.dart';
import 'package:apod/repository/apod_repository.dart';
import 'package:apod/utils/utils.dart';
import 'package:rxdart/subjects.dart';

class ApodBloc {
  String previousSearch;
  final _apodData = BehaviorSubject<ApodModel>();
  final _date = BehaviorSubject<DateTime>();
  final _isFindButtonVisible = BehaviorSubject<bool>();

  Stream get apodData => _apodData.stream;
  Stream<DateTime> get date => _date.stream;
  Stream<bool> isFindButtonVisible = BehaviorSubject<bool>();

  Function(DateTime) get changeDate => _date.sink.add;

  void loadData() {
    if (previousSearch == convertDateTime(_date?.valueWrapper?.value)) {
      print("fetching aborted,same data");
      return;
    }
    _apodData.add(null);
    APODRepository.getApodForDate(_date?.valueWrapper?.value ?? DateTime.now())
        .then((value) {
      if (value != null) {
        value.fold(
          (l) {
            print(l.response);
            _apodData.addError(l.error ?? 'Something went wrong');
          },
          (r) {
            previousSearch = convertDateTime(_date?.valueWrapper?.value);
            _apodData.add(r);
          },
        );
      }
    });
  }

  void dispose() {
    _apodData.close();
    _date.close();
    _isFindButtonVisible.close();
  }
}
