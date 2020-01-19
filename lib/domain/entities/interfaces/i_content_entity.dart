abstract class IContentEntity {
  List<IContentDataEntity> data;
  int order;
  String presentationId;
  String uid;
}

abstract class IContentDataEntity {
  String type;
  String value;
}
