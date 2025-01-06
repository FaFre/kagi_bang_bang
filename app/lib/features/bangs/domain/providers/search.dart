import 'package:lensai/features/bangs/data/models/bang_data.dart';
import 'package:lensai/features/bangs/domain/repositories/data.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search.g.dart';

@Riverpod()
Future<Uri> triggerBangSearch(
  Ref ref,
  BangData bang,
  String searchQuery,
) async {
  final bangDataNotifier = ref.watch(bangDataRepositoryProvider.notifier);

  await bangDataNotifier.increaseFrequency(bang.trigger);
  await bangDataNotifier.addSearchEntry(
    bang.trigger,
    searchQuery,
    maxEntryCount: 3,
  ); //TODO: make count dynamic

  return bang.getUrl(searchQuery);
}
