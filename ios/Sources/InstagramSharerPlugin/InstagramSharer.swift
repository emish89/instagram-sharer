import Foundation
import Capacitor

@objc(InstagramSharer)
public class InstagramSharer: CAPPlugin, CAPBridgedPlugin {
    // Queste righe registrano esplicitamente il plugin e i suoi metodi con Capacitor
    public let identifier = "InstagramSharer"
    public let jsName = "InstagramSharer"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "shareToStory", returnType: CAPPluginReturnPromise)
    ]
    // La logica di implementazione è in un'istanza separata, come da prassi moderna
    private let implementation = InstagramSharerImpl()

    @objc func shareToStory(_ call: CAPPluginCall) {
        implementation.shareToStory(call)
    }
}


// Mettiamo la nostra logica effettiva in una classe "Impl" per una maggiore pulizia
// Questo previene problemi con l'inizializzazione del plugin
@objc(InstagramSharerImpl)
public class InstagramSharerImpl: NSObject {
    @objc public func shareToStory(_ call: CAPPluginCall) {
        guard let base64String = call.getString("imageBase64") else {
            call.reject("Missing imageBase64 option")
            return
        }
        
        guard let appId = call.getString("appId") else {
            call.reject("Missing appId option")
            return
        }
        
        guard let backgroundImage = Data(base64Encoded: base64String) else {
            call.reject("Failed to convert base64 to image data")
            return
        }
        
        let urlSchemeString = "instagram-stories://share?source_application=\(appId)"
        guard let urlScheme = URL(string: urlSchemeString) else {
            call.reject("Failed to create URL Scheme")
            return
        }

        if UIApplication.shared.canOpenURL(urlScheme) {
            let pasteboardItems = [["com.instagram.sharedSticker.backgroundImage": backgroundImage]]
            let pasteboardOptions: [UIPasteboard.OptionsKey: Any] = [
                .expirationDate: Date().addingTimeInterval(60 * 5)
            ]
            
            UIPasteboard.general.setItems(pasteboardItems, options: pasteboardOptions)
            
            DispatchQueue.main.async {
                UIApplication.shared.open(urlScheme, options: [:]) { (success) in
                    if success {
                        call.resolve()
                    } else {
                        call.reject("Failed to open Instagram")
                    }
                }
            }
        } else {
            call.reject("Instagram app is not installed or URL scheme is not configured in Info.plist")
        }
    }
}