import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/image_model.dart';

class ImageRepository{
  Future<List<PixelfordImage>> getNetworkImages() async {
    try {
      var endpointUrl = Uri.parse('https://picsum.photos/v2/list');

      final response = await http.get(endpointUrl);

      if (response.statusCode == 200) {
        final List<dynamic> decodedList = jsonDecode(response.body) as List;

        final List<PixelfordImage> _imageList = decodedList.map((listItem) {
          return PixelfordImage.fromJson(listItem);
        }).toList();

        print(_imageList[0].url);
        return _imageList;
      } else {
        throw Exception('API not successful!');
      }
    } on SocketException{
      throw Exception("internet connection lost");
    } on HttpException {
      throw Exception("http exeption");
    }on FormatException {
      throw Exception("format exeption");
    }

    catch(e){
      print(e);
      throw Exception("unkown error");
    }
  }

}
