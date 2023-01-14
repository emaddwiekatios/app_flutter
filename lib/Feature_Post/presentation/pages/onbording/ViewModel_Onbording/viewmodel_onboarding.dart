import 'dart:async';

import 'package:clean_arch_app/Feature_Post/domain/entities/Models.dart';
import 'package:clean_arch_app/core/resource/AssetManager.dart';
import 'package:clean_arch_app/core/resource/StringManager.dart';

import '../../../base/BaseViewModel.dart';

class ViewModelOnBording extends BaseViewModel
    with onBoardViewModelInput, onboardVMoutput1 {
   late List<OnBoardingClass> _list;
  int _currentIndex = 0;
  //final  _streamControllerNew =StreamController<OnBoardingClassObject>();
   final StreamController<OnBoardingClassObject> _streamControllerNew =
      StreamController<OnBoardingClassObject>();

  ///from base class
  @override
  void dispose() {
   // if (_streamControllerNew.hasListener) {
   //   _streamControllerNew.close();
   // }
    _streamControllerNew.close();
    _list.clear();
  }

  @override
  void start() {
    _list = _getSliderData();

    onPageChange(_currentIndex);
  }

  @override
  void onPageChange(int index) {
    _currentIndex = index;
    savedatatoview();
  }

  void savedatatoview() {
    if(!_streamControllerNew.isClosed) {
      getOnBoardingInput.add(OnBoardingClassObject(
          _list[_currentIndex], _list.length, _currentIndex));
    }
  }

  // private onborad  func

  List<OnBoardingClass> _getSliderData() => [
        OnBoardingClass(
            onBoardingId: 1,
            onBoardingDesc: 'Easy Shoping',
            onBoardingImage: AssetManager.onBoarding1,
            onBoardingDetails: StringManager.onBoardingDetails1),
        OnBoardingClass(
            onBoardingId: 1,
            onBoardingDesc: 'Secure Payment',
            onBoardingImage: AssetManager.onBoarding2,
            onBoardingDetails: StringManager.onBoardingdetails2),
        OnBoardingClass(
            onBoardingId: 1,
            onBoardingDesc: 'Quick Delivery',
            onBoardingImage: AssetManager.onBoarding3,
            onBoardingDetails: StringManager.onBoardingdetails3),
      ];

  @override

  Sink get getOnBoardingInput =>  _streamControllerNew.sink;

  @override
  Stream<OnBoardingClassObject> get get_onbordoutbut =>
      _streamControllerNew.stream.map((slideViewObject) => slideViewObject);
  @override
  int goNext() {
    if (_currentIndex < _list.length - 1) {
      _currentIndex = _currentIndex + 1;
    }
    return _currentIndex;
  }

  @override
  int goPrivous() {
    if (_currentIndex > 0) {
      _currentIndex = _currentIndex - 1;
    }
    return _currentIndex;
  }
}

abstract class onBoardViewModelInput {
  int goNext();
  int goPrivous();
  void onPageChange(int index);
  Sink get getOnBoardingInput;
}

abstract class onboardVMoutput1 {
  Stream<OnBoardingClassObject> get get_onbordoutbut;
}


