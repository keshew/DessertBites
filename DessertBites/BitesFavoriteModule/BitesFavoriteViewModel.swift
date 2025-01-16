import SwiftUI

class BitesFavoriteViewModel: ObservableObject {
    let contact = BitesFavoriteModel()
    @Published var columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    func getRecept() -> [PuzzleModel] {
        return UserDefaultsManager().loadPuzzles()!
    }
}
