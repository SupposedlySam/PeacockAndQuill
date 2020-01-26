import 'package:peacock_and_quill/presentation/interfaces/entities/i_question_entity.dart';

abstract class IQuestionRepository {
  final String collectionName = "questions";

  Future<List<IQuestionEntity>> getAllQuestions();
  Future<List<IQuestionEntity>> getQuestionsBySlide(int slide);
  Stream<List<IQuestionEntity>> getQuestionsByUser(String uid);
  void addQuestion(String uid, int screen, int paragraph);
  void removeQuestion(String uid, int screen, int paragraph);
}
