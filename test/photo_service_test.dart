import 'package:flutter_test/flutter_test.dart';
import 'package:isolate_example/photo_model.dart';
import 'package:isolate_example/photo_service.dart';

void main() {
  group('Photo Service Test', () {
    PhotoService service = PhotoService();

    List<PhotoModel> photos;
    test('Photo Service Test', () async {
      photos = await service.fetchPhotos();
      //photos service ten çekilir bu süreçteki işlem
      //expect metodu ile kontrol edilir.
      expect(photos.first.url.isNotEmpty, true);
    });
  });
}
