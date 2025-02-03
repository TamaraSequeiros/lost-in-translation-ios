import SwiftUI

class NavigationManager: ObservableObject {
    @Published var path = NavigationPath()
    
    func goBack() {
        path.removeLast(path.count)
    }
    
    func popToRoot() {
        path = NavigationPath()
    }
    
    func navigate(to screen: AppScreen) {
        path.append(screen)
    }
} 
