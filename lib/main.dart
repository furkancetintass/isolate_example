import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:isolate_example/photo_service.dart';

import 'photo_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final PhotoService _photoService = PhotoService();
  late Future<List<PhotoModel>> _future;
  @override
  void initState() {
    _future = _photoService.fetchPhotos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Isolate Example"),
      ),
      body: FutureBuilder<List<PhotoModel>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              debugPrint(snapshot.error.toString());
            }
            return snapshot.hasData
                ? GridPhotos(photos: snapshot.data!)
                : const Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class GridPhotos extends StatelessWidget {
  const GridPhotos({Key? key, required this.photos}) : super(key: key);

  final List<PhotoModel> photos;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('snackBar'),
            backgroundColor:
                Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                    .withOpacity(1.0),
          ));
        },
        child: Column(
          children: [
            Image.network(photos[index].url),
            Text(photos[index].title,
                style: Theme.of(context).textTheme.headline6)
          ],
        ),
      ),
    );
  }
}
