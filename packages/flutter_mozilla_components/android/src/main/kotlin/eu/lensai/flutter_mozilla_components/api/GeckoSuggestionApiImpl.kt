package eu.lensai.flutter_mozilla_components.api

import eu.lensai.flutter_mozilla_components.GlobalComponents
import eu.lensai.flutter_mozilla_components.ext.toWebPBytes
import eu.lensai.flutter_mozilla_components.pigeons.GeckoSuggestion
import eu.lensai.flutter_mozilla_components.pigeons.GeckoSuggestionApi
import eu.lensai.flutter_mozilla_components.pigeons.GeckoSuggestionEvents
import eu.lensai.flutter_mozilla_components.pigeons.GeckoSuggestionType
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.launch
import org.mozilla.gecko.util.ThreadUtils.runOnUiThread

class GeckoSuggestionApiImpl(
    private val suggestionEvents: GeckoSuggestionEvents
) : GeckoSuggestionApi {
    companion object {
        private val coroutineScope = CoroutineScope(Dispatchers.Main + SupervisorJob())
    }

    private val components by lazy {
        requireNotNull(GlobalComponents.components) { "Components not initialized" }
    }

    override fun onInputChanged(text: String, providers: List<GeckoSuggestionType>) {
        for(provider in providers) {
            coroutineScope.launch {
                val results = when(provider) {
                    GeckoSuggestionType.SESSION -> components.search.sessionSuggestions.onInputChanged(text)
                    GeckoSuggestionType.CLIPBOARD -> components.search.clipboardSuggestions.onInputChanged(text)
                    GeckoSuggestionType.HISTORY -> components.search.historySuggestions.onInputChanged(text)
                }

                val mappedResults = results.map { result ->
                    GeckoSuggestion(
                        id = result.id,
                        title = result.title,
                        score = result.score.toLong(),
                        description = result.description,
                        type = provider,
                        editSuggestion = result.editSuggestion,
                        icon = result.icon?.toWebPBytes()
                    )
                }

                runOnUiThread {
                    suggestionEvents.onSuggestionResult(
                        System.currentTimeMillis(),
                        provider,
                        mappedResults
                    ) { }
                }
            }
        }
    }
}