import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lensai/data/models/equatable_iterable.dart';
import 'package:lensai/features/bangs/data/models/bang_data.dart';
import 'package:lensai/features/bangs/domain/providers/bangs.dart';
import 'package:lensai/features/bangs/domain/repositories/data.dart';
import 'package:lensai/features/geckoview/domain/providers/tab_state.dart';
import 'package:lensai/features/geckoview/features/browser/domain/providers.dart';
import 'package:lensai/features/geckoview/features/tabs/data/models/container_data.dart';
import 'package:lensai/features/geckoview/features/tabs/domain/providers/selected_container.dart';
import 'package:lensai/features/geckoview/features/tabs/domain/repositories/tab_search.dart';
import 'package:lensai/features/geckoview/features/tabs/presentation/widgets/container_chips.dart';
import 'package:lensai/features/search/domain/providers/search_suggestions.dart';
import 'package:lensai/features/search/presentation/widgets/bang_chips.dart';
import 'package:lensai/features/search/presentation/widgets/search_field.dart';
import 'package:lensai/presentation/hooks/listenable_callback.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchScreen extends HookConsumerWidget {
  final String? initialSearchText;

  const SearchScreen({required this.initialSearchText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());

    final searchTextController =
        useTextEditingController(text: initialSearchText);

    useListenableCallback(
      searchTextController,
      () async {
        ref
            .read(searchSuggestionsProvider().notifier)
            .addQuery(searchTextController.text);

        await ref
            .read(tabSearchRepositoryProvider.notifier)
            .addQuery(searchTextController.text);
      },
    );

    final globalSelectedContainer = ref.watch(
      selectedContainerDataProvider.select((value) => value.valueOrNull),
    );

    final defaultSearchBang = ref.watch(
      defaultSearchBangDataProvider.select((value) => value.valueOrNull),
    );

    final selectedBang = useState<BangData?>(null);
    final activeBang = selectedBang.value ?? defaultSearchBang;
    final showBangIcon = useState(false);

    ref.listen(
      selectedBangDataProvider(),
      (previous, next) {
        if (next.hasValue) {
          if ((previous?.hasValue ?? false) && previous!.value != next.value) {
            showBangIcon.value = true;
          }

          selectedBang.value = next.value;
        }
      },
    );

    final selectedContainer = useState<ContainerData?>(globalSelectedContainer);

    final availableTabs = ref
        .watch(
          availableTabIdsProvider(selectedContainer.value?.id).select(
            (value) => EquatableCollection(value, immutable: true),
          ),
        )
        .collection;

    return Scaffold(
      body: Form(
        key: formKey,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              automaticallyImplyLeading: false,
              title: SearchField(
                showBangIcon: showBangIcon.value,
                textEditingController: searchTextController,
                onFieldSubmitted: (text) {},
                activeBang: activeBang,
              ),
            ),
            const SliverToBoxAdapter(
              child: Divider(),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Site Search',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    BangChips(
                      activeBang: activeBang,
                      onSelected: (bang) {
                        ref
                            .read(selectedBangTriggerProvider().notifier)
                            .setTrigger(bang.trigger);
                      },
                      onDeleted: (bang) async {
                        if (ref.read(selectedBangTriggerProvider()) ==
                            bang.trigger) {
                          ref
                              .read(
                                selectedBangTriggerProvider().notifier,
                              )
                              .clearTrigger();
                        } else {
                          final dialogResult = await BangChips.resetBangDialog(
                            context,
                            bang.trigger,
                          );

                          if (dialogResult == true) {
                            await ref
                                .read(bangDataRepositoryProvider.notifier)
                                .resetFrequency(bang.trigger);
                          }
                        }
                      },
                      searchTextController: searchTextController,
                    ),
                  ],
                ),
              ),
            ),
            HookConsumer(
              builder: (context, ref, child) {
                final hasSearchText = useListenableSelector(
                  searchTextController,
                  () => searchTextController.text.isNotEmpty,
                );

                final suggestions =
                    useStream(ref.watch(searchSuggestionsProvider()));

                return (!hasSearchText || !suggestions.hasData)
                    ? SliverList.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const Icon(Icons.history),
                            title: Text('Search History $index'),
                          );
                        },
                      )
                    : SliverList.builder(
                        itemCount: suggestions.data!.length,
                        itemBuilder: (context, index) {
                          final suggestion = suggestions.data![index];

                          return ListTile(
                            leading: const Icon(Icons.search),
                            title: Text(suggestion),
                            onLongPress: () {
                              searchTextController.text = suggestion;
                            },
                          );
                        },
                      );
              },
            ),
            const SliverToBoxAdapter(
              child: Divider(),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tabs',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    ContainerChips(
                      displayMenu: false,
                      selectedContainer: selectedContainer.value,
                      onSelected: (container) {
                        selectedContainer.value = container;
                      },
                      onDeleted: (container) {
                        selectedContainer.value = null;
                      },
                      searchTextController: searchTextController,
                    ),
                  ],
                ),
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
                final tabs = ref.watch(tabSearchRepositoryProvider);

                return SliverSkeletonizer(
                  enabled: tabs.isLoading,
                  child: tabs.when(
                    data: (data) {
                      return SliverList.builder(itemBuilder: itemBuilder);
                    },
                    error: error,
                    loading: () => SliverList.builder(
                      itemCount: tabs.valueOrNull?.length ?? 3,
                      itemBuilder: (context, index) {
                        return ListTile()
                      },),
                  ),
                );
              },
            ),
            SliverList.builder(
              itemCount: availableTabs.length,
              itemBuilder: (context, index) {
                return Consumer(
                  key: ValueKey(availableTabs[index]),
                  builder: (context, ref, child) {
                    final tab =
                        ref.watch(tabStateProvider(availableTabs[index]));

                    if (tab == null) {
                      return const SizedBox.shrink();
                    }

                    return ListTile(
                      leading: RawImage(
                        image: tab.icon?.value,
                        height: 24,
                        width: 24,
                      ),
                      title: Text(tab.title),
                      subtitle: Text(
                        tab.url.toString(),
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
