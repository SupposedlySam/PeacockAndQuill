import 'package:flutter/material.dart';
import 'package:peacock_and_quill/domain/interfaces/i_presentation_repository.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_presentation_entity.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_questions_entity.dart';
import 'package:peacock_and_quill/presentation/interfaces/use_cases/i_question_use_case.dart';
import 'package:peacock_and_quill/presentation/view_models/key_press_view_model.dart';

class BaseViewModel extends ChangeNotifier {
  final IQuestionUseCase questionUseCase;
  final KeyPressViewModel keyPressModel;
  final IPresentationRepository presentationRepository;
  final NavigatorState navigator;
  IPresentationEntity _presentationEntity;
  bool _showQuestions = false;
  bool _showHeader = true;
  bool _isActive = false;
  String _presentationCode = '';
  List<IQuestionsEntity> _questions = [];

  BaseViewModel({
    @required this.questionUseCase,
    @required this.keyPressModel,
    @required this.navigator,
    @required this.presentationRepository,
  }) {
    _getActivePresentation().then((activePresentation) {
      _isActive = activePresentation.isActive;
      _presentationCode = activePresentation.code;
      notifyListeners();
    });
  }

  String get presentationCode => _presentationCode;
  bool get showQuestions => _showQuestions;
  bool get showHeader => _showHeader;
  bool get isPresenting => _isActive;
  List<IQuestionsEntity> get questions => _questions;

  void toggleQuestions() async {
    _showQuestions = !_showQuestions;
    if (_showQuestions) {
      _questions = await questionUseCase.getAllQuestions();
      navigator.pop();
    }
    notifyListeners();
  }

  void toggleActive() async {
    _isActive = await presentationRepository.toggleActive();
    notifyListeners();
  }

  Future<IPresentationEntity> _getActivePresentation() async {
    _presentationEntity = await presentationRepository.getActivePresentation();
    return _presentationEntity;
  }

  void setHeader({@required bool value}) {
    _showHeader = !value;
    notifyListeners();
  }

  void handleQuestionPressed(IQuestionsEntity questionsEntity) {
    keyPressModel.navigateToSlide(questionsEntity.screen);
    toggleQuestions();
  }
}
