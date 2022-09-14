import 'package:photo_app/feature/domain/entities/photo_entity.dart';

class PhotoModel extends PhotoEntity {
  PhotoModel(
      {required super.id,
      required super.width,
      required super.height,
      required super.description,
      required super.authorName,
      required super.imgUrlSmall,
      required super.imgUrlFull});

  // PhotoModel({
  //   required id,
  //   required width,
  //   required height,
  //   required description,
  //   required authorName,
  //   required imgUrlSmall,
  //   required imgUrlFull,
  // }) : super(
  //           id: id,
  //           width: width,
  //           height: height,
  //           authorName: authorName,
  //           description: description,
  //           imgUrlSmall: imgUrlSmall,
  //           imgUrlFull: imgUrlFull);

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json['id'],
      width: json['width'],
      height: json['height'],
      description:
          json['description'] == null ? 'No description' : json['description'],
      authorName: json['user']['username'],
      imgUrlSmall: json['urls']['small'],
      imgUrlFull: json['urls']['full'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'width': width,
      'height': height,
      'description': description,
      'authorName': authorName,
      'imgUrlSmall': imgUrlSmall,
      'imgUrlFull': imgUrlFull,
    };
  }
}
