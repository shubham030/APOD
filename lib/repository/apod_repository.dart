import 'package:apod/models/apod_model.dart';
import 'package:apod/utils/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class APODRepository {
  static const String _path = 'planetary/apod/';
  static const String baseUrl = EndPoint + _path;

  static Future<Either<DioError, ApodModel>> getApodForDate(
    DateTime date,
  ) async {
    print(convertDateTime(date));
    var result = await Dio().get(
      baseUrl,
      queryParameters: {
        "api_key": API_KEY,
        "date": convertDateTime(date),
      },
    );
    print(result.extra);
    // }, onReceiveProgress: (x, y) {
    //   print(x);
    //   print(y);
    // });

    if (result.statusCode == 200) {
      return right(ApodModel.fromMap(result.data));
    } else {
      return left(DioError());
    }
  }
}
