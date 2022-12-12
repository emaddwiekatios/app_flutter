import 'dart:async';

import 'package:clean_arch_app/Feature_Post/domain/entities/Models.dart';
import 'package:clean_arch_app/core/resource/AssetManager.dart';
import 'package:clean_arch_app/core/resource/StringManager.dart';

import '../../../base/BaseViewModel.dart';



class ViewModelOnBording extends BaseViewModel with onBoardViewModelInput,onboardVMoutput1 {


  late final List<OnBoardingClass> _list ;
  int _currentIndex = 0;

  //final StreamController<OnBoardingClassObject> _streamController= StreamController<OnBoardingClassObject>();
  final StreamController<OnBoardingClassObject> _streamControllerNew = StreamController<OnBoardingClassObject>();




  ///from base class
  @override
  void dispose() {
    if(_streamControllerNew.hasListener)
      {
        _streamControllerNew.close();
      }
    _streamControllerNew.close();
    _list.clear();
    // TODO: implement dispose
  }

  @override
  void start() {
    _list=_getSliderData();
    //print('list length =${_list.length}');
    onPageChange(_currentIndex);
    // TODO: implement start
  }

  @override
  void onPageChange(int index) {
    _currentIndex=index;
    savedatatoview();

    // TODO: implement onpagechange
  }
  void savedatatoview()
  {
    getOnBoardingInput.add(OnBoardingClassObject(_list[_currentIndex], _list.length, _currentIndex));

  }

  // private onborad  func

  List<OnBoardingClass> _getSliderData() => [
    OnBoardingClass(onboarding_id: 1,onboarding_desc: 'Easy Shoping',onboarding_image:AssetManager.onBoarding1 ,
        onboarding_details: StringManager.onBoardingdetails1),
    OnBoardingClass(onboarding_id: 1,onboarding_desc: 'Secure Payment',
        onboarding_image:AssetManager.onBoarding2,
        onboarding_details: StringManager.onBoardingdetails2),
    OnBoardingClass(onboarding_id: 1,onboarding_desc: 'Quick Delivery',
        onboarding_image:AssetManager.onBoarding3 ,
        onboarding_details: StringManager.onBoardingdetails3),

  ];



  @override
  // TODO: implement get_onboardinput
  Sink get getOnBoardingInput => _streamControllerNew.sink;

  @override
  // TODO: implement get_onbordoutbut
  // Stream get get_onbordoutbut => _streamController.stream.map((OnBoardingClassObject) => OnBoardingClassObject);
  Stream<OnBoardingClassObject> get  get_onbordoutbut =>
      _streamControllerNew.stream.map((slideViewObject) => slideViewObject);
  @override
  int goNext() {
    // TODO: implement goNext
    if(_currentIndex<_list.length-1) {
      _currentIndex = _currentIndex + 1;
      //print(_currentIndex);
      //print(sliderViewObject.numberofSliders);
    }
    return _currentIndex;

  }

  @override
  int goPrivous() {
    if(_currentIndex>0) {
      _currentIndex = _currentIndex - 1;

    }
    return _currentIndex;
  }


}

abstract class  onBoardViewModelInput
{
  int goNext();
  int goPrivous();
  void onPageChange( int index );
  Sink get getOnBoardingInput;


}
abstract class  onboardVMoutput1
{
  Stream<OnBoardingClassObject> get  get_onbordoutbut;
}