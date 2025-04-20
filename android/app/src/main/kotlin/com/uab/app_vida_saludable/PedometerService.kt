import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Intent
import android.os.Build
import android.os.IBinder
import androidx.core.app.NotificationCompat

class PedometerService : Service() {

    private val channelId = "pedometer_channel"
    private val channelName = "Pedometer Service"

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onCreate() {
        super.onCreate()
        createNotificationChannel() // Crea el canal al iniciar el servicio
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        startForeground(1, createNotification())
        // Implementa aquí el sensor de pasos nativo
        return START_STICKY
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                channelId,
                channelName,
                NotificationManager.IMPORTANCE_LOW // Prioridad baja para no molestar
            )
            val manager = getSystemService(NotificationManager::class.java)
            manager.createNotificationChannel(channel)
        }
    }

    private fun createNotification(): Notification {
        return NotificationCompat.Builder(this, channelId)
            .setContentTitle("Contador de pasos")
            .setContentText("Monitoreando tu actividad...")
            .setSmallIcon(android.R.drawable.ic_dialog_info) // ¡Reemplaza con tu ícono!
            .setPriority(NotificationCompat.PRIORITY_LOW)
            .build()
    }
}