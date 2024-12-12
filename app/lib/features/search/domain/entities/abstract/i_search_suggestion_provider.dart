import 'package:exceptions/exceptions.dart';

abstract interface class ISearchSuggestionProvider {
  Future<Result<List<String>>> getSuggestions(String query);
}
