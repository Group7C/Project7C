



import 'package:json_annotation/json_annotation.dart';
part 'image_model.g.dart';

@JsonSerializable()

class PixelfordImage{
  String id;
  String author;
  int width;
  int height;
  @JsonKey(name:'download_url')
  String url;


  PixelfordImage(
      {required this.id,
        required this.author,
        required this.width,
        required this.height,
        required this.url});

  factory PixelfordImage.fromJson(Map<String, dynamic> json) =>
      _$PixelfordImageFromJson(json);

  Map<String, dynamic> toJson() => _$PixelfordImageToJson(this);

}