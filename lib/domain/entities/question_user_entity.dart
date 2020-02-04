import 'package:peacock_and_quill/presentation/interfaces/entities/i_question_entity.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_question_user_entity.dart';

class QuestionUserEntity implements IQuestionUserEntity {
  String name;
  String presentationId;
  String questionRef;
  ISelectionEntity selection;
  String uid;

  QuestionUserEntity({
    this.uid,
    this.presentationId,
    this.name,
    this.questionRef,
    this.selection,
  });
}
