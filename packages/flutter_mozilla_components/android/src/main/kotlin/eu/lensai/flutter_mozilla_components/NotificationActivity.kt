package eu.lensai.flutter_mozilla_components

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity

class NotificationActivity: AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        GlobalComponents.components!!.notificationsDelegate.bindToActivity(this)

        finish()
    }
}