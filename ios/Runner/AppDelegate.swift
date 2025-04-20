import UIKit
import Flutter
import flutter_local_notifications
import BackgroundTasks

@main
@objc class AppDelegate: FlutterAppDelegate {
  private let pedometer = CMPedometer()
  private var eventSink: FlutterEventSink?
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "pedometer_chanel", binaryMessenger: controller.binaryMessenger)
    
    channel.setMethodCallHandler { [weak self] (call, result) in
      if call.method == "startPedometer" {
        self?.startPedometer()
      }
    // Registro de flutter_local_notifications
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
      GeneratedPluginRegistrant.register(with: registry)
    }
    
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

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  //PODOMETRO
  private func startPedometer() {
    if CMPedometer.isStepCountingAvailable() {
      pedometer.startUpdates(from: Date()) { [weak self] data, error in
        guard let data = data, error == nil else { return }
        DispatchQueue.main.async {
          // Envía los pasos a Flutter
        }
      }
    }
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
