import SwiftUI

class BitesRecipeViewModel: ObservableObject {
    let contact = BitesRecipeModel()
    @Published var isFavouriteTapped = false
        
    
    func toggleFav(puzzle: PuzzleModel, image: String) {
        isFavouriteTapped.toggle()
        
        if image == BitesImageName.star.rawValue {
            UserDefaultsManager().removePuzzle(puzzle)
        } else {
            UserDefaultsManager().addPuzzle(puzzle)
        }
    }
}
