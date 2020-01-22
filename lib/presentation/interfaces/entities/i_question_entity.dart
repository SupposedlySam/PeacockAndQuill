abstract class IQuestionEntity {
  ISelectionEntity selection;
  String presentationId;
  String uid;
}

abstract class ISelectionEntity {
  int paragraph;
  int slide;
}
