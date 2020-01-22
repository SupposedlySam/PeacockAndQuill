import 'package:peacock_and_quill/presentation/interfaces/entities/i_question_entity.dart';

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
