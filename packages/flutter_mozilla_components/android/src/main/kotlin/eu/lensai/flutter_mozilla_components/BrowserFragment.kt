package eu.lensai.flutter_mozilla_components


import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.View
import eu.lensai.flutter_mozilla_components.addons.WebExtensionActionPopupActivity
import eu.lensai.flutter_mozilla_components.feature.WebExtensionToolbarFeature
import eu.lensai.flutter_mozilla_components.integration.ReaderViewIntegration
import mozilla.components.browser.state.state.WebExtensionState
import mozilla.components.browser.thumbnails.BrowserThumbnails
import mozilla.components.concept.engine.EngineView
import mozilla.components.feature.tabs.WindowFeature
import mozilla.components.support.base.feature.UserInteractionHandler
import mozilla.components.support.base.feature.ViewBoundFeatureWrapper
import mozilla.components.support.webextensions.WebExtensionPopupObserver

/**
 * Fragment used for browsing the web within the main app.
 */
class BrowserFragment(private val context: Context) : BaseBrowserFragment(), UserInteractionHandler {
    private val windowFeature = ViewBoundFeatureWrapper<WindowFeature>()
    private val thumbnailsFeature = ViewBoundFeatureWrapper<BrowserThumbnails>()
    private val readerViewFeature = ViewBoundFeatureWrapper<ReaderViewIntegration>()
    private val webExtensionPopupObserver = ViewBoundFeatureWrapper<WebExtensionPopupObserver>()
    private val webExtToolbarFeature = ViewBoundFeatureWrapper<WebExtensionToolbarFeature>()

    override fun createEngine(components: Components): EngineView {
        return components.core.engine.createView(context).apply {
           selectionActionDelegate = components.selectionAction
        }
    }

    @Suppress("LongMethod")
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        readerViewFeature.set(
            feature = ReaderViewIntegration(
                requireContext(),
                components.core.engine,
                components.core.store,
                binding.readerViewBar,
                components.events.readerViewEvents,
                components.readerViewController,
            ),
            owner = this,
            view = view,
        )

        windowFeature.set(
            feature = WindowFeature(components.core.store, components.useCases.tabsUseCases),
            owner = this,
            view = view,
        )

        thumbnailsFeature.set(
            feature = BrowserThumbnails(requireContext(), components.engineView!!, components.core.store),
            owner = this,
            view = view,
        )

        webExtensionPopupObserver.set(
            feature = WebExtensionPopupObserver(components.core.store, ::openPopup),
            owner = this,
            view = view,
        )

        webExtToolbarFeature.set(
            feature = components.features.webExtensionToolbarFeature,
            owner = this,
            view = view,
        )
    }

    private fun openPopup(webExtensionState: WebExtensionState) {
        val intent = Intent(requireContext().applicationContext, WebExtensionActionPopupActivity::class.java)
        intent.putExtra("web_extension_id", webExtensionState.id)
        intent.putExtra("web_extension_name", webExtensionState.name)
        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
        startActivity(intent)
    }

    override fun onBackPressed(): Boolean =
        readerViewFeature.onBackPressed() || super.onBackPressed()

    companion object {
        fun create(context: Context, sessionId: String? = null) = BrowserFragment(context).apply {
            arguments = Bundle().apply {
                putSessionId(sessionId)
            }
        }
    }
}
