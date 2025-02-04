import UIKit

class DeviceAuthenticator {
    private let deviceIdKey = "LostInTranslation.persistentDeviceIdentifier"
    
    var deviceId: String {
        if let savedId = UserDefaults.standard.string(forKey: deviceIdKey) {
            return savedId
        }
        
        let newId = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
        UserDefaults.standard.set(newId, forKey: deviceIdKey)
        return newId
    }
    
    var signature: String {
        return deviceId
    }
} 