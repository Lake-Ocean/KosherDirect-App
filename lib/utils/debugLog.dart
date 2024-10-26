
// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/foundation.dart';


void Debug(String message){
  if(kDebugMode){
    print("***** $message *****");
  }
}