import 'package:country_picker/country_picker.dart';
import 'package:get/get.dart';

class AuthenticationControll extends GetxController {

  //this for password off and on
  var isPasswordVisible = true.obs;
  var isPasswordNonVisible =false.obs;

    

  Rx<Country> selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  ).obs; // Initialize with your default country

  void setSelectedCountry(Country country) {
    selectedCountry.value = country;
   
  }

  RxString controllerText =''.obs;
  void storeText(String text)
  {
    controllerText.value=text;
  }

  
}


