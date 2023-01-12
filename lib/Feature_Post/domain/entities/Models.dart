
class OnBoardingClass {
  int? onBoardingId ;
  String? onBoardingDesc;
  String? onBoardingDetails;
  String? onBoardingImage;
  OnBoardingClass(
  {this.onBoardingId,this.onBoardingDesc,this.onBoardingImage,this.onBoardingDetails}
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

