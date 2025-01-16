import SwiftUI

enum AppScreen: Hashable {
    case lesson
    case menu
    case difficalty
    case choosePuzzles(String, [PuzzleModel], Bool)
    case settings
    case favourite
    case recept(PuzzleModel, Bool)
    case game(PuzzleModel)
}

final class Router: ObservableObject {
    @Published var path: [AppScreen] = []
    
    func showLesson() {
        path.append(.lesson)
    }
    
    func showMenu() {
        path.append(.menu)
    }
    
    func showdDifficalty() {
        path.append(.difficalty)
    }
    
    func showChoosePuzzles(label: String, puzzleModule: [PuzzleModel], isDisabled: Bool) {
        path.append(.choosePuzzles(label, puzzleModule, isDisabled))
    }
    
    func showSettings() {
        path.append(.settings)
    }
    
    func showFavourite() {
        path.append(.favourite)
    }
    
    func showRecept(puzzleModel: PuzzleModel, bool: Bool) {
        path.append(.recept(puzzleModel, bool))
    }
    
    func showGame(puzzleModel: PuzzleModel) {
        path.append(.game(puzzleModel))
    }
    
    func back() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
}
