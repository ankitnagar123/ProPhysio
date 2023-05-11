import 'package:get/get.dart';

class MyRoute extends GetxController{

  var  pageIndex = 0.obs;

  get  load =>pageIndex.value;

  setValue(int value){
    pageIndex.value = value;
  }

}