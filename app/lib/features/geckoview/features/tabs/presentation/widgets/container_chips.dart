import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lensai/core/routing/routes.dart';
import 'package:lensai/features/geckoview/features/tabs/data/models/container_data.dart';
import 'package:lensai/features/geckoview/features/tabs/domain/providers.dart';
import 'package:lensai/presentation/widgets/selectable_chips.dart';

class ContainerChips extends HookConsumerWidget {
  final bool displayMenu;

  final ContainerData? selectedContainer;
  final void Function(ContainerDataWithCount)? onSelected;
  final void Function(ContainerDataWithCount)? onDeleted;

  final TextEditingController? searchTextController;

  const ContainerChips({
    required this.selectedContainer,
    required this.onSelected,
    required this.onDeleted,
    this.searchTextController,
    this.displayMenu = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchText = useListenableSelector(
      searchTextController,
      () => searchTextController?.text,
    );

    final containersAsync =
        ref.watch(filteredContainersWithCountProvider(searchText));

    return containersAsync.when(
      data: (availableContainers) {
        if (selectedContainer == null &&
            availableContainers.isEmpty &&
            !displayMenu) {
          return const SizedBox.shrink();
        }

        return SizedBox(
          height: 48,
          child: Row(
            children: [
              if (selectedContainer != null || availableContainers.isNotEmpty)
                Expanded(
                  child: SelectableChips(
                    deleteIcon: false,
                    itemId: (container) => container.id,
                    itemAvatar: (container) => Container(
                      width: 20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                        color: container.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    itemLabel: (container) =>
                        Text(container.name ?? 'New Container'),
                    itemBadgeCount: (container) => container.tabCount,
                    availableItems: availableContainers,
                    selectedItem: selectedContainer,
                    onSelected: onSelected,
                    onDeleted: onDeleted,
                  ),
                )
              else
                Visibility(
                  visible: displayMenu,
                  child: Expanded(
                    child: Text(
                      "Press '>' to manage Containers.",
                      style: TextStyle(
                        color: Theme.of(context).hintColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              if (displayMenu)
                IconButton(
                  onPressed: () async {
                    await context.push(ContainerListRoute().location);
                  },
                  icon: const Icon(Icons.chevron_right),
                ),
            ],
          ),
        );
      },
      error: (error, stackTrace) => const SizedBox.shrink(),
      loading: () => const SizedBox(
        height: 48,
        width: double.infinity,
      ),
    );
  }
}
