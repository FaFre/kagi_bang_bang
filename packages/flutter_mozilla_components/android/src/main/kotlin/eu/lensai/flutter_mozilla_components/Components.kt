package eu.lensai.flutter_mozilla_components

import android.content.Context
import androidx.core.app.NotificationManagerCompat
import eu.lensai.flutter_mozilla_components.components.Core
import eu.lensai.flutter_mozilla_components.components.Events
import eu.lensai.flutter_mozilla_components.components.Features
import eu.lensai.flutter_mozilla_components.components.Services
import eu.lensai.flutter_mozilla_components.components.UseCases
import eu.lensai.flutter_mozilla_components.pigeons.GeckoAddonEvents
import eu.lensai.flutter_mozilla_components.pigeons.GeckoStateEvents
import eu.lensai.flutter_mozilla_components.pigeons.ReaderViewController
import mozilla.components.concept.engine.EngineView
import mozilla.components.concept.engine.selection.SelectionActionDelegate
import mozilla.components.support.base.android.NotificationsDelegate

class Components(private val context: Context,
                 val flutterEvents: GeckoStateEvents,
                 val readerViewController: ReaderViewController,
                 val selectionAction: SelectionActionDelegate,
                 val addonEvents: GeckoAddonEvents
) {
    val core by lazy { Core(context, this, flutterEvents) }
    val events by lazy { Events(flutterEvents) }
    val useCases by lazy { UseCases(context, core.engine, core.store) }
    val services by lazy { Services(context, useCases.tabsUseCases) }
    val features by lazy { Features(core.store, addonEvents) }

    var engineView: EngineView? = null
    var engineReportedInitialized = false

    private val notificationManagerCompat = NotificationManagerCompat.from(context)
    val notificationsDelegate: NotificationsDelegate by lazy {
        NotificationsDelegate(
            notificationManagerCompat,
        )
    }
}