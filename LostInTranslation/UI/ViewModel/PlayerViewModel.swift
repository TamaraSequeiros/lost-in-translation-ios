//
//  PlayerViewModel.swift
//  LostInTranslation
//
//  Created by Tamara on 18/01/2025.
//

import Foundation

class PlayerViewModel: ObservableObject {
    
    @Published var player: Player?
    
    func savePlayer(newPlayer: Player?) {
        print("Saving user: \(String(describing: newPlayer))")
        player = newPlayer
        UserManager.shared.saveUser(player: newPlayer)
    }

    init() {
        player = UserManager.shared.loadUser()
    }
    
    func deleteUser() {
        player = nil
        UserManager.shared.deleteUser()
    }
}

