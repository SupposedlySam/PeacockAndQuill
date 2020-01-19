import 'package:peacock_and_quill/domain/entities/interfaces/i_content_entity.dart';

class ContentEntity implements IContentEntity {
  List<IContentDataEntity> data;
  int order;
  String presentationId;
  String uid;

  ContentEntity({
    this.data,
    this.order,
    this.presentationId,
    this.uid,
  });
}

class ContentData implements IContentDataEntity {
  String type;
  String value;

  ContentData({
    this.type,
    this.value,
  });
}
