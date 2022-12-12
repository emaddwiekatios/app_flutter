import 'package:clean_arch_app/Feature_Post/presentation/pages/splash/splash.dart';


class OnBoardingClass {
  int? onboarding_id ;
  String? onboarding_desc;
  String? onboarding_details;
  String? onboarding_image;
  OnBoardingClass(
  {this.onboarding_id,this.onboarding_desc,this.onboarding_image,this.onboarding_details}
      );
}


class OnBoardingClassObject
{
  OnBoardingClass onBoardingClass;
  int noOfItem;
  int currentIndex;
  OnBoardingClassObject(this.onBoardingClass,this.noOfItem,this.currentIndex);
}



class UserNamePassword {
  String  userName ;
  String password;
  UserNamePassword(
      this.userName,this.password
      );
}

