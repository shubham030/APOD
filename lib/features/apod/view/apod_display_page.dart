import 'package:apod/features/apod/bloc/apod_bloc.dart';
import 'package:apod/models/apod_model.dart';
import 'package:apod/utils/utils.dart';
import 'package:flutter/material.dart';

class ApodDisplayPage extends StatefulWidget {
  @override
  _ApodDisplayPageState createState() => _ApodDisplayPageState();
}

class _ApodDisplayPageState extends State<ApodDisplayPage> {
  final ApodBloc bloc = ApodBloc();

  @override
  void initState() {
    bloc.loadData();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () async {
                var result = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1990),
                  lastDate: DateTime.now(),
                );
                if (result != null) {
                  bloc.changeDate(result);
                }
              },
            ),
            SizedBox(width: 8),
            StreamBuilder<DateTime>(
                initialData: DateTime.now(),
                stream: bloc.date,
                builder: (context, snapshot) {
                  return Text(convertDateTime(snapshot.data));
                }),
            SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                bloc.loadData();
              },
              child: Text('Find'),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return StreamBuilder<ApodModel>(
                stream: bloc.apodData,
                builder:
                    (BuildContext context, AsyncSnapshot<ApodModel> snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error));
                  }
                  if (snapshot.data == null) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.49,
                        ),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 12),
                      Text(
                        snapshot.data.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      AspectRatio(
                        aspectRatio: 4 / 1,
                        child: Image.network(
                          snapshot.data.url,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        snapshot.data.explanation,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
