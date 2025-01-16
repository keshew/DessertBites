import Foundation

enum Keys: String {
    case numberOfLevel = "numberOfLevel"
    case countOfMoney = "countOfMoney"
    case firstLaunchKey = "firstLaunchKey"
    case puzzleKey = "puzzleKey"
}

class UserDefaultsManager {
    static let defaults = UserDefaults.standard
    
    func savePuzzles(_ puzzles: [PuzzleModel]) {
         do {
             let encoder = JSONEncoder()
             let data = try encoder.encode(puzzles)
             UserDefaultsManager.defaults.set(data, forKey: Keys.puzzleKey.rawValue)
         } catch {
             print("Ошибка сохранения: \(error)")
         }
     }

     func loadPuzzles() -> [PuzzleModel]? {
         guard let data = UserDefaultsManager.defaults.data(forKey: Keys.puzzleKey.rawValue) else { return nil }
         
         do {
             let decoder = JSONDecoder()
             let puzzles = try decoder.decode([PuzzleModel].self, from: data)
             return puzzles
         } catch {
             print("Ошибка загрузки: \(error)")
             return nil
         }
     }

     func addPuzzle(_ puzzle: PuzzleModel) {
         if var puzzles = loadPuzzles() {
             puzzles.append(puzzle)
             savePuzzles(puzzles)
         } else {
             savePuzzles([puzzle])
         }
     }
    
    func removePuzzle(_ puzzle: PuzzleModel) {
         if var puzzles = loadPuzzles() {
             puzzles.removeAll(where: { $0.name == puzzle.name && $0.image == puzzle.image })
             savePuzzles(puzzles)
         } else {
             print("Массив пуст или не загружен")
         }
     }
    
    func checkFirstLaunch(completion: () -> (), completiomElse: () -> ()) {
        if UserDefaultsManager.defaults.bool(forKey: Keys.firstLaunchKey.rawValue) {
             completion()
         } else {
             completiomElse()
             UserDefaultsManager.defaults.set(true, forKey: Keys.firstLaunchKey.rawValue)
         }
     }
}
