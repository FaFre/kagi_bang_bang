import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_mozilla_components/src/extensions/subject.dart';
import 'package:flutter_mozilla_components/src/pigeons/gecko.g.dart';
import 'package:rxdart/rxdart.dart';

final _apiInstance = GeckoSuggestionApi();

class GeckoSuggestionsService extends GeckoSuggestionEvents {
  final GeckoSuggestionApi _api;
  final _suggestionsSubject = BehaviorSubject<List<GeckoSuggestion>>();

  Stream<List<GeckoSuggestion>> get suggestionsStream =>
      _suggestionsSubject.stream;

  GeckoSuggestionsService.setUp({
    BinaryMessenger? binaryMessenger,
    String messageChannelSuffix = '',
    GeckoSuggestionApi? api,
  }) : _api = api ?? _apiInstance {
    GeckoSuggestionEvents.setUp(
      this,
      binaryMessenger: binaryMessenger,
      messageChannelSuffix: messageChannelSuffix,
    );
  }

  Future<void> onInputChanged(
    String text, {
    List<GeckoSuggestionType> providers = const [
      GeckoSuggestionType.session,
      GeckoSuggestionType.clipboard,
      GeckoSuggestionType.history,
    ],
  }) {
    return _api.onInputChanged(text, providers);
  }

  @override
  void onSuggestionResult(
    int timestamp,
    GeckoSuggestionType suggestionType,
    List<GeckoSuggestion> suggestions,
  ) {
    _suggestionsSubject.addWhenMoreRecent(
      timestamp,
      suggestionType,
      suggestions,
    );
  }

  void dispose() {
    unawaited(_suggestionsSubject.close());
  }
}
