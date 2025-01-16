import SwiftUI

class PuzzleGameViewModel: ObservableObject {
    let contact = PuzzleGameModel()

    func createDartsGameScene(gameData: PuzzleGameData, data: PuzzleModel) -> PuzzleGameSpriteKit {
        let scene = PuzzleGameSpriteKit(data: data)
        scene.game  = gameData
        return scene
    }
}
