import SwiftUI

struct BitesChoosePuzzlesView: View {
    @StateObject var bitesChoosePuzzlesModel =  BitesChoosePuzzlesViewModel()
    @ObservedObject var router: Router
    var levelDescription: String
    var puzzlesModel: [PuzzleModel]
    var isDisabled: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(.background)
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    VStack(spacing: 15) {
                        HStack {
                            SquareButton(action: {
                                router.back()
                            }, image: BitesImageName.arrowBack.rawValue)
                            .padding(.leading)
                            .padding(.top)
                            Spacer()
                            
                            Text("PUZZLES")
                                .Bowlby(size: 30)
                                .padding(.trailing, geometry.size.width * 0.307)
                                .padding(.top, 10)
                        }
                        
                        Text(levelDescription)
                            .Bowlby(size: 30)
                    }
                    
                    Spacer()
                    
                    VStack {
                        HStack {
                            PuzzleImage(action: {
                                router.showGame(puzzleModel: puzzlesModel[0])
                            }, image: puzzlesModel[0].image)
                            
                            PuzzleImage(action: {
                                router.showGame(puzzleModel: puzzlesModel[1])
                            }, image: puzzlesModel[1].image)
                        }
                        
                        HStack {
                            PuzzleImage(action: {
                                router.showGame(puzzleModel: puzzlesModel[2])
                            }, image: puzzlesModel[2].image)
                            
                            PuzzleImage(action: {
                                router.showGame(puzzleModel: puzzlesModel[3])
                            }, image: puzzlesModel[3].image)
                            .disabled(isDisabled)
                        }
                    }
                    .offset(y: -geometry.size.height * 0.1)
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    @ObservedObject var router = Router()
    let levelDesk = "EASY - 16 PIECES"
    let isDis = false
    let puzzlesModel = [PuzzleModel(image: BitesImageName.easy1.rawValue, name: "", ingredients: "", cookingTime: "", recipe: "",
                                    xPosition: [0.0],
                                    yPosition: [0.0],
                                    puzzleImages: [""]),
                        PuzzleModel(image: BitesImageName.easy1.rawValue, name: "", ingredients: "", cookingTime: "", recipe: "",
                                    xPosition: [0.0],
                                    yPosition: [0.0],
                                    puzzleImages: [""]),
                        PuzzleModel(image: BitesImageName.easy1.rawValue, name: "", ingredients: "", cookingTime: "", recipe: "",
                                    xPosition: [0.0],
                                    yPosition: [0.0],
                                    puzzleImages: [""]),
                        PuzzleModel(image: BitesImageName.easy1.rawValue, name: "", ingredients: "", cookingTime: "", recipe: "",
                                    xPosition: [0.0],
                                    yPosition: [0.0],
                                    puzzleImages: [""])]
    return BitesChoosePuzzlesView(router: router,
                                  levelDescription: levelDesk,
                                  puzzlesModel: puzzlesModel,
                                  isDisabled: isDis)
}

