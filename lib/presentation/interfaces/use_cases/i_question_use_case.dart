import 'package:peacock_and_quill/presentation/interfaces/entities/i_question_entity.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_questions_entity.dart';

abstract class IQuestionUseCase {
  Future<void> addQuestion(int screen, int paragraph);

  Future<List<IQuestionsEntity>> getAllQuestions();

  Future<List<IQuestionEntity>> getQuestions(int slide);

  Stream<List<IQuestionEntity>> getQuestionsByUser();

  Future<bool> hasQuestion(int pageIndex, int paragraphIndex);

  Future<void> removeQuestion(int screen, int paragraph);

  Future<void> removeQuestionById(String refId);
}
