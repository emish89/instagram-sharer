import Foundation
import Capacitor

// Questo definisce il plugin, lo registra con Capacitor e contiene la nostra logica.
@objc(InstagramSharer)
public class InstagramSharer: CAPPlugin {
    
    // Questo è il metodo che chiamerai da React.
    @objc func shareToStory(_ call: CAPPluginCall) {
        // Estraiamo i dati passati da JavaScript
        guard let base64String = call.getString("imageBase64") else {
            call.reject("Missing imageBase64 option")
            return
        }
        
        guard let appId = call.getString("appId") else {
            call.reject("Missing appId option")
            return
        }
        
        // Convertiamo la stringa base64 in dati immagine
        guard let backgroundImage = Data(base64Encoded: base64String) else {
            call.reject("Failed to convert base64 to image data")
            return
        }
        
        // Creiamo l'URL per aprire le Storie di Instagram
        let urlSchemeString = "instagram-stories://share?source_application=\(appId)"
        guard let urlScheme = URL(string: urlSchemeString) else {
            call.reject("Failed to create URL Scheme")
            return
        }

        // Controlliamo se Instagram è installato
        if UIApplication.shared.canOpenURL(urlScheme) {
            // Prepariamo i dati per la clipboard con la chiave personalizzata di Instagram
            let pasteboardItems = [["com.instagram.sharedSticker.backgroundImage": backgroundImage]]
            let pasteboardOptions: [UIPasteboard.OptionsKey: Any] = [
                .expirationDate: Date().addingTimeInterval(60 * 5)
            ]
            
            // Scriviamo sulla clipboard
            UIPasteboard.general.setItems(pasteboardItems, options: pasteboardOptions)
            
            // Apriamo Instagram
            UIApplication.shared.open(urlScheme, options: [:]) { (success) in
                if success {
                    call.resolve()
                } else {
                    call.reject("Failed to open Instagram")
                }
            }
        } else {
            call.reject("Instagram app is not installed or URL scheme is not configured in Info.plist")
        }
    }
}