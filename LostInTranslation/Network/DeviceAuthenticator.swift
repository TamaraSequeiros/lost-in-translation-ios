import UIKit

class DeviceAuthenticator {
    private let deviceIdKey = "LostInTranslation.persistentDeviceIdentifier"
    private let appSecret = "LostInTranslation2025"
    
    var deviceId: String {
        if let savedId = UserDefaults.standard.string(forKey: deviceIdKey) {
            return savedId
        }
        
        let newId = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
        UserDefaults.standard.set(newId, forKey: deviceIdKey)
        return newId
    }
    
    var signature: String {
        let dataToSign = deviceId + appSecret
        return dataToSign.data(using: .utf8)!
            .base64EncodedString()
    }
} 