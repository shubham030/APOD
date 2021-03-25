import 'package:intl/intl.dart';

const String EndPoint = "https://api.nasa.gov/";
const String API_KEY = "aWPhODExHc5j48m59viPzCysv1jkoaN7ID2dchPw";

String convertDateTime(DateTime date) {
  print(DateFormat('yyyy/MM/dd').format(date));
  return '';
}
