import 'package:clean_arch_app/Feature_Post/domain/entities/Models.dart';
import 'package:clean_arch_app/Feature_Post/presentation/manager/Language/LocaleController.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/Login/view_login/view_login.dart';
import 'package:clean_arch_app/Feature_Post/presentation/pages/Onbording/ViewModel_Onbording/viewmodel_onboarding.dart';
import 'package:clean_arch_app/core/resource/AssetManager.dart';
import 'package:clean_arch_app/core/resource/ColorManger.dart';
import 'package:clean_arch_app/core/resource/FontManager.dart';
import 'package:clean_arch_app/core/resource/MediaQuery.dart';
import 'package:clean_arch_app/core/resource/RoutesManager.dart';
import 'package:clean_arch_app/core/resource/StringManager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/resource/ValueManger.dart';
import '../../../../domain/entities/Models.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

//int currentIndex=0;
//List image_list =[];
PageController _pageController = PageController();

LocaleController localeController = Get.put(LocaleController());

ViewModelOnBording _viewModelOnBording = ViewModelOnBording();

class _OnBoardingState extends State<OnBoarding> {
  _bind() {
    _viewModelOnBording.start();
  }

  @override
  void dispose() {
    _viewModelOnBording.dispose();
    _pageController.dispose();

    super.dispose();
  }

//FocusNode _focusNode = new FocusNode();
  @override
  void initState() {
    _bind();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Container(
        height: get_height(context),
        width: get_width(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: get_height(context),
              child: StreamBuilder<OnBoardingClassObject>(
                  stream:
                      _viewModelOnBording.get_onbordoutbut, //<SliderViewObject>,
                  builder: (context, snapShot) {
                    return _getContentWidget(snapShot.data);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getContentWidget(OnBoardingClassObject? onBoardingClassObject) {
    if (onBoardingClassObject == null) {
      return Container();
    } else {
      return SizedBox(
        height: get_height(context) / 1.2,
        width: get_width(context),
        //color:Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                height: get_height(context) / 2,
                width: get_width(context),
                child: PageView.builder(
                    controller: _pageController,
                    itemCount: onBoardingClassObject.noOfItem,
                    onPageChanged: (index) {
                      _viewModelOnBording.onPageChange(index);
                    },
                    itemBuilder: (context, index) {
                      return OnBoardingPage(
                          onBoardingClassObject.onBoardingClass);
                    }),
              ),
            ),
            _getBottomSheetWidget(onBoardingClassObject)
          ],
        ),
      );
    }
  }

  _getBottomSheetWidget(OnBoardingClassObject onBoardingClassObject) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              style: ButtonStyle(
                  //foregroundColor: MaterialStateProperty.all(ColorManager.grey),
                  elevation: MaterialStateProperty.all(FontManagerSize.s2),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(350)))),
              onPressed: () {
                // Navigator.pushReplacementNamed(context, RoutesManager.loginRoute);
                Navigator.pushReplacementNamed(
                    context, '/login');
              },
              child: Text(StringManager.onBoardSkip.tr)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  _pageController.animateToPage(_viewModelOnBording.goPrivous(),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.bounceInOut);
                },
                icon: const Icon(Icons.arrow_back_ios)),
            SizedBox(
              height: get_height(context) / FontManagerSize.s30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < onBoardingClassObject.noOfItem; i++)
                    cycleData(i, onBoardingClassObject.currentIndex),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(150)))),
                  onPressed: () {
                    _pageController.animateToPage(_viewModelOnBording.goNext(),
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.bounceInOut);
                    if (onBoardingClassObject.currentIndex >=
                        onBoardingClassObject.noOfItem - 1) {
                      Navigator.pushReplacementNamed(
                          context, '/login');
                    }
                  },
                  child: Text(StringManager.onBoardStart.tr)),
            ),
          ],
        ),
      ],
    );
  }

  cycleData(int i, int index) {
    //print('i====$i');
    //print('index====$index');
    if (i == index) {
      return Padding(
        padding: EdgeInsets.all(FontManagerSize.s2),
        child: CircleAvatar(radius: 5, backgroundColor: ColorManager.primary),
      );
    } else {
      return const Padding(
        padding: EdgeInsets.all(FontManagerSize.s2),
        child: CircleAvatar(radius: 5, backgroundColor: Colors.grey),
      );
    }
  }
}

class OnBoardingPage extends StatelessWidget {
  final OnBoardingClass _sliderObject;

  const OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Align( alignment:(localeController.currentLanguage ==Locale('ar'))?
          //    Alignment.topLeft:Alignment.topRight,
          //
          // child: InkWell(
          //     onTap: ()
          //     {
          //
          //       if(localeController.currentLanguage == Locale('en') )
          //         localeController.changeLanguage(Locale('ar'));
          //       else
          //         localeController.changeLanguage(Locale('en'));
          //
          //     },
          //     child: CircleAvatar(
          //       backgroundColor: ColorManager.primary,
          //     //  child: Text('${localeController.currentLanguage}'),
          //     ),
          //
          //   ),
          // ),ol2woplew

          Image.asset(AssetManager.onBoardLogo),
          Image.asset(_sliderObject.onboarding_image!),
          const SizedBox(height: AppSize.s20),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Text(
              '${_sliderObject.onboarding_desc}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Text(
              '${_sliderObject.onboarding_details}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),

          // image widget
        ],
      ),
    );
  }
}
