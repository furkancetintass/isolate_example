import 'dart:async';

import 'package:flutter/foundation.dart';

import 'photo_model.dart';

class PhotoService {
  Future<List<PhotoModel>> fetchPhotos() {
    return compute(generatePhotos, 400);
  }
}

List<PhotoModel> generatePhotos(int value) {  
  return List.generate(
      value,
      (int index) => PhotoModel(
          id: index,
          title: 'example $index',
          url: 'https://placeimg.com/640/480/arch/$index'));
}
