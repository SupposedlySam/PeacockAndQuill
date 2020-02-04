abstract class IQuestionEntity {
  String refId;
  ISelectionEntity selection;
  String presentationId;
  String uid;
}

abstract class ISelectionEntity {
  int paragraph;
  int slide;
}
