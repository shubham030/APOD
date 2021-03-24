import 'dart:convert';

ApodModel apodModelFromMap(String str) => ApodModel.fromMap(json.decode(str));

String apodModelToMap(ApodModel data) => json.encode(data.toMap());

class ApodModel {
  ApodModel({
    this.date,
    this.explanation,
    this.hdurl,
    this.mediaType,
    this.serviceVersion,
    this.title,
    this.url,
  });

  final DateTime date;
  final String explanation;
  final String hdurl;
  final String mediaType;
  final String serviceVersion;
  final String title;
  final String url;

  ApodModel copyWith({
    DateTime date,
    String explanation,
    String hdurl,
    String mediaType,
    String serviceVersion,
    String title,
    String url,
  }) =>
      ApodModel(
        date: date ?? this.date,
        explanation: explanation ?? this.explanation,
        hdurl: hdurl ?? this.hdurl,
        mediaType: mediaType ?? this.mediaType,
        serviceVersion: serviceVersion ?? this.serviceVersion,
        title: title ?? this.title,
        url: url ?? this.url,
      );

  factory ApodModel.fromMap(Map<String, dynamic> json) => ApodModel(
        date: DateTime.parse(json["date"]),
        explanation: json["explanation"],
        hdurl: json["hdurl"],
        mediaType: json["media_type"],
        serviceVersion: json["service_version"],
        title: json["title"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "explanation": explanation,
        "hdurl": hdurl,
        "media_type": mediaType,
        "service_version": serviceVersion,
        "title": title,
        "url": url,
      };
}
