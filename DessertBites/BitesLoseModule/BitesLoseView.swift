import SwiftUI

struct BitesLoseView: View {
    @StateObject var bitesLoseModel =  BitesLoseViewModel()
    @ObservedObject var router: Router
    var puzzleModel: PuzzleModel
    var body: some View {
        ZStack {
            Color.white
                .opacity(0.5)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                VStack(spacing: 13) {
                    Text("GAME OVER!")
                        .Bowlby(size: 28)
                    
                    Text("TIME'S UP")
                        .Bowlby(size: 28, color: .white, colorOutline: Color(red: 255/255, green: 113/255, blue: 172/255))
                    
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
                        router.showdDifficalty()
                    }, text: "NEXT")
                }
            }
        }
    }
}

#Preview {
    @ObservedObject var router = Router()
    let puzzleModel = PuzzleModel(image: "",
                                  name: "",
                                  ingredients: "",
                                  cookingTime: "",
                                  recipe: "",
                                  xPosition: [0.0],
                                  yPosition: [0.0],
                                  puzzleImages: [""])
    return BitesLoseView(router: router, puzzleModel: puzzleModel)
}

