import 'package:peacock_and_quill/presentation/interfaces/entities/i_question_entity.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_questions_entity.dart';

class QuestionsEntity implements IQuestionsEntity {
  int screen;
  List<IQuestionEntity> questions;

  QuestionsEntity({
    this.screen,
    this.questions,
  });
}
