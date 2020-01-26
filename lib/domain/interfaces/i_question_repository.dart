import 'package:peacock_and_quill/presentation/interfaces/entities/i_question_entity.dart';

abstract class IQuestionRepository {
  final String collectionName = "questions";
  final String presenterId = "jn8HsjD1vROpepjAD8vK7YAgtl93";

  Future<List<IQuestionEntity>> getAllQuestions();
  Future<List<IQuestionEntity>> getQuestionsBySlide(int slide);
  Stream<List<IQuestionEntity>> getQuestionsByUser(String uid);
  void addQuestion(String uid, int screen, int paragraph);
  void removeQuestion(String uid, int screen, int paragraph);
}
