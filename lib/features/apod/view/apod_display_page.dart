import 'package:apod/features/apod/bloc/apod_bloc.dart';
import 'package:apod/models/apod_model.dart';
import 'package:flutter/material.dart';

class ApodDisplayPage extends StatefulWidget {
  @override
  _ApodDisplayPageState createState() => _ApodDisplayPageState();
}

class _ApodDisplayPageState extends State<ApodDisplayPage> {
  final ApodBloc bloc = ApodBloc();

  @override
  void initState() {
    bloc.loadNewData(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1990),
                lastDate: DateTime(2024),
              );
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            color: Colors.red,
            child: StreamBuilder<ApodModel>(
              stream: bloc.apodData,
              builder:
                  (BuildContext context, AsyncSnapshot<ApodModel> snapshot) {
                if (snapshot.data == null) {
                  return CircularProgressIndicator();
                }
                return Image.network(snapshot.data.hdurl);
              },
            ),
          );
        },
      ),
    );
  }
}
