import UIKit
import Flutter
import flutter_local_notifications
import BackgroundTasks

@main
@objc class AppDelegate: FlutterAppDelegate {
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    // Registro de flutter_local_notifications
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
      GeneratedPluginRegistrant.register(with: registry)
    }
    GeneratedPluginRegistrant.register(with: self)
    
    // Delegado para notificaciones
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }

    // Registro de la tarea de fondo
    if #available(iOS 13.0, *) {
      BGTaskScheduler.shared.register(
        forTaskWithIdentifier: "com.appVidaSaludable.simple_task",
        using: nil
      ) { task in
        self.handleBackgroundTask(task: task as! BGProcessingTask)
      }
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  // Manejo de tareas en segundo plano
  @available(iOS 13.0, *)
  private func handleBackgroundTask(task: BGProcessingTask) {
    // Configuración de tareas críticas
    task.expirationHandler = {
      // Cancela el trabajo si está tardando demasiado
    }
    
    // Simula la ejecución de la tarea
    DispatchQueue.global().async {
      // Ejemplo: limpieza de datos, sincronización, etc.
      print("Ejecutando tarea en segundo plano")
      task.setTaskCompleted(success: true)
    }
  }
}
