import 'package:flutter/material.dart';
import 'package:peacock_and_quill/domain/interfaces/i_presentation_repository.dart';
import 'package:peacock_and_quill/domain/interfaces/i_user_repository.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_presentation_entity.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_question_user_entity.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_questions_entity.dart';
import 'package:peacock_and_quill/presentation/interfaces/use_cases/i_question_use_case.dart';
import 'package:peacock_and_quill/presentation/view_models/key_press_view_model.dart';

class BaseViewModel extends ChangeNotifier {
  final IQuestionUseCase questionUseCase;
  final KeyPressViewModel keyPressModel;
  final IPresentationRepository presentationRepository;
  final IUserRepository userRepository;
  final NavigatorState navigator;
  IPresentationEntity _presentationEntity;
  List<Future<IQuestionUserEntity>> _participantQuestions;
  bool _showQuestions = false;
  bool _showHeader = true;
  bool _isActive = false;
  String _presentationCode = '';
  List<IQuestionsEntity> _questions = [];

  BaseViewModel({
    @required this.questionUseCase,
    @required this.keyPressModel,
    @required this.navigator,
    @required this.userRepository,
    @required this.presentationRepository,
  }) {
    _getActivePresentation().then((activePresentation) {
      _isActive = activePresentation.isActive;
      _presentationCode = activePresentation.code;
      notifyListeners();
    });
  }

  bool get isPresenting => _isActive;
  List<Future<IQuestionUserEntity>> get participantQuestions =>
      _participantQuestions;
  String get presentationCode => _presentationCode;
  List<IQuestionsEntity> get questions => _questions;
  bool get showHeader => _showHeader;
  bool get showQuestions => _showQuestions;
  double get currentSlide => keyPressModel.controller.page;

  void handleQuestionDelete(int index, String refId) async {
    final slideNumber = currentSlide.round();
    final questionIndex = _questions.indexWhere((q) => q.screen == slideNumber);
    final slideInfo = _questions[questionIndex];
    slideInfo.questions.removeAt(index);
    if (slideInfo.questions.length == 0) _questions.removeAt(questionIndex);
    _participantQuestions.removeAt(index);
    notifyListeners();
    await questionUseCase.removeQuestionById(refId);
  }

  void handleQuestionPressed(IQuestionsEntity questionsEntity) {
    keyPressModel.navigateToSlide(questionsEntity.screen);
    _getAllQuestions(questionsEntity.screen);
  }

  void setHeader({@required bool value}) {
    _showHeader = !value;
    notifyListeners();
  }

  void toggleActive() async {
    _isActive = await presentationRepository.toggleActive();
    notifyListeners();
  }

  void toggleQuestions() async {
    _showQuestions = !_showQuestions;
    if (_showQuestions) {
      await _getAllQuestions();
    }
    navigator.pop();
    notifyListeners();
  }

  Future<IPresentationEntity> _getActivePresentation() async {
    _presentationEntity = await presentationRepository.getActivePresentation();
    return _presentationEntity;
  }

  Future _getAllQuestions([int slide]) async {
    _questions = await questionUseCase.getAllQuestions();
    _getQuestionsForActiveSlide(slide);
    notifyListeners();
  }

  void _getQuestionsForActiveSlide([int slide]) {
    final index = slide ?? keyPressModel.controller.page;
    final userQuestions =
        questions.where((question) => question.screen == index);

    _participantQuestions = userQuestions.length > 0
        ? userRepository.getUsersFromQuestions(
            userQuestions.first.questions,
          )
        : [];
  }
}
