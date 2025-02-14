import 'package:flutter/material.dart';
import 'package:demandium_provider/data/model/response/language_model.dart';
import 'package:demandium_provider/utils/app_constants.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages({required BuildContext context}) {
    return AppConstants.languages;
  }
}
