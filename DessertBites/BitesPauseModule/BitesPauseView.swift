import SwiftUI

struct BitesPauseView: View {
    @StateObject var bitesPauseModel =  BitesPauseViewModel()
    @ObservedObject var router: Router
    let game: PuzzleGameData
    let puzzleModel: PuzzleModel
    var body: some View {
        ZStack {
            Color.white
                .opacity(0.5)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                VStack(spacing: 13) {
                    Text("PAUSE")
                        .Bowlby(size: 28)
                    
                    HStack(spacing: 30) {
                        SquareButton(action: {
                            router.showMenu()
                        }, image: BitesImageName.menuImage.rawValue,
                                     sizeWImage: 30,
                                     sizeHImage: 30,
                                     sizeWBack: 55)
                        
                        SquareButton(action: {
                            router.showGame(puzzleModel: puzzleModel)
                        }, image: BitesImageName.restart.rawValue,
                                     sizeWImage: 30,
                                     sizeHImage: 30,
                                     sizeWBack: 55)
                    }
                }
                VStack {
                    WideButton(action: {
                        game.isPause = false
                    }, text: "RESUME")
                }
            }
        }
    }
}

#Preview {
    @ObservedObject var router = Router()
    let game = PuzzleGameData()
    let puzzleModel = PuzzleModel(image: "",
                                  name: "",
                                  ingredients: "",
                                  cookingTime: "",
                                  recipe: "",
                                  xPosition: [0.0],
                                  yPosition: [0.0],
                                  puzzleImages: [""])
    return BitesPauseView(router: router, game: game, puzzleModel: puzzleModel)
}

