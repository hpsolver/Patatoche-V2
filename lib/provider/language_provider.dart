import 'package:patatoche_v2/provider/base_provider.dart';
import '../models/language_model.dart';

class LanguageProvider extends BaseProvider {

  final List<LanguageModel> langList = [
    LanguageModel('Dutch', 'nl'),
    LanguageModel('English', 'en'),
    LanguageModel('French', 'fr'),
    LanguageModel('German', 'de'),
    LanguageModel('Spanish', 'es'),
    LanguageModel('Italian', 'it'),
  ];

  LanguageModel? _selectedLang;

  LanguageModel? get selectedLang => _selectedLang;

  set selectedLang(LanguageModel? value) {
    _selectedLang = value;
    notifyListeners();
  }
}
