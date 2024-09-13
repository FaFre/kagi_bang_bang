import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:fast_equatable/fast_equatable.dart';
import 'package:lensai/domain/entities/equatable_image.dart';
import 'package:lensai/features/geckoview/domain/entities/history_state.dart';
import 'package:lensai/features/geckoview/domain/entities/readerable_state.dart';
import 'package:lensai/features/geckoview/domain/entities/security_state.dart';

part 'tab_state.g.dart';

@CopyWith()
class TabState with FastEquatable {
  @CopyWithField(immutable: true)
  final String id;

  final String? contextId;

  final Uri url;
  final String title;

  final EquatableImage? icon;
  final EquatableImage? thumbnail;

  final int progress;

  final bool isPrivate;
  final bool isFullScreen;
  final bool isLoading;

  final SecurityState securityInfoState;
  final HistoryState historyState;
  final ReaderableState readerableState;

  TabState({
    required this.id,
    required this.contextId,
    required this.url,
    required this.title,
    required this.icon,
    required this.thumbnail,
    required this.progress,
    required this.isPrivate,
    required this.isFullScreen,
    required this.isLoading,
    required this.securityInfoState,
    required this.historyState,
    required this.readerableState,
  });

  factory TabState.$default(String tabId) => TabState(
        id: tabId,
        contextId: null,
        url: Uri.parse('about:blank'),
        title: "",
        icon: null,
        thumbnail: null,
        progress: 0,
        isPrivate: false,
        isFullScreen: false,
        isLoading: false,
        securityInfoState: SecurityState.$default(),
        historyState: HistoryState.$default(),
        readerableState: ReaderableState.$default(),
      );

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        id,
        contextId,
        url,
        title,
        icon,
        thumbnail,
        progress,
        isPrivate,
        isFullScreen,
        isLoading,
        securityInfoState,
        historyState,
        readerableState,
      ];
}
