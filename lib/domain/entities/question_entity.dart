import 'package:peacock_and_quill/domain/entities/interfaces/i_question_entity.dart';

class QuestionEntity implements IQuestionEntity {
  ISelectionEntity selection;
  String presentationId;
  String uid;

  QuestionEntity({
    this.selection,
    this.presentationId,
    this.uid,
  });
}
