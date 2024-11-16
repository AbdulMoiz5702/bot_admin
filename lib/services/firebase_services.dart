




import 'package:bot_admin/const/firebase_const.dart';

class FirebaseServices {

  static getAllTasks (){
    return fireStore.collection(allTasks).get();
  }

  static getSocialTasks (){
    return fireStore.collection(socialTasks).get();
  }

  static getDailyTasks (){
    return fireStore.collection(dailyTasks).get();
  }

  static getAcademyTasks (){
    return fireStore.collection(academyTasks).get();
  }

}