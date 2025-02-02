//
//  UserManager.swift
//  LostInTranslation
//
//  Created by Tamara on 24/01/2025.
//

import Foundation

class UserManager {
    
    static let shared = UserManager()
    
    private init() {}
    
    private let userDefaultsKey = "LostInTranslation.player"

    func saveUser(player: Player?) {
        if let player = player {
            if let encodedUser = try? JSONEncoder().encode(player) {
                UserDefaults.standard.set(encodedUser, forKey: userDefaultsKey)
            }
        } else {
            UserDefaults.standard.removeObject(forKey: userDefaultsKey)
        }
    }

    func loadUser() -> Player? {
        if let userData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedUser = try? JSONDecoder().decode(Player.self, from: userData) {
            return decodedUser
        } else {
            return nil
        }
    }
    
    func deleteUser() {
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
    }
}
