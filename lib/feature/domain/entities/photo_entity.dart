class PhotoEntity {
  String id;
  int width;
  int height;
  String description;
  String authorName;
  String imgUrlSmall;
  String imgUrlFull;

  PhotoEntity({
    required this.id,
    required this.width,
    required this.height,
    required this.description,
    required this.authorName,
    required this.imgUrlSmall,
    required this.imgUrlFull,
  });

  List<Object> get props => [
        id,
        width,
        height,
        description,
        authorName,
        imgUrlSmall,
        imgUrlFull,
      ];
}
