import SwiftUI

#if canImport(UIKit) && !os(watchOS)
@available(iOS 14.0, *)
@main
struct SpinStriveTestApp: App {
    var body: some Scene {
        WindowGroup {
            MarsCameraView(viewModel: MarksCameraViewModel(networkLayer: NetworkLayer()))
        }
    }
}
#else
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIHostingController(rootView: CustomNavBar())
        window?.makeKeyAndVisible()
        return true
    }
}

#endif
