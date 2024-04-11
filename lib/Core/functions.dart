class InputValidator{

  static String? emptyValidate(String value) {
     if(value.isEmpty ) {
       return 'هذا الحقل مطلوب' ;
     }

  }


  static String? emailValidate(String value) {
     if(value.isNotEmpty && !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
         .hasMatch(value)) {
       return 'صيغة الإيميل غير صحيحة' ;
     }
     // return null;
  }


  static String? phoneValidate(String value) {
    if(value.isEmpty ) {
      return 'هذا الحقل مطلوب' ;
    }
     if(!RegExp(r'[0-9]')
         .hasMatch(value)) {
       return 'يجب أن يتكون الرقم من ١٠ أعداد' ;
     }
     // return null;
  }
}

