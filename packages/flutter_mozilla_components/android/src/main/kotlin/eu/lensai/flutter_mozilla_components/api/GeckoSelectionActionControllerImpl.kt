package eu.lensai.flutter_mozilla_components.api

import eu.lensai.flutter_mozilla_components.feature.DefaultSelectionActionDelegate
import eu.lensai.flutter_mozilla_components.pigeons.CustomSelectionAction
import eu.lensai.flutter_mozilla_components.pigeons.GeckoSelectionActionController

class GeckoSelectionActionControllerImpl(
    private val selectionActionDelegate: DefaultSelectionActionDelegate
) : GeckoSelectionActionController {
    override fun setActions(actions: List<CustomSelectionAction>) {
        selectionActionDelegate.actions = actions.associateBy { it.id }
    }
}