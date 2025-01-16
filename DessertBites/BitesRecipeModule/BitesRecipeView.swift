import SwiftUI

struct BitesRecipeView: View {
    @StateObject var bitesRecipeModel =  BitesRecipeViewModel()
    @ObservedObject var router: Router
    var puzzleModel: PuzzleModel
    var bool: Bool
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(.background)
                    .resizable()
                    .ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 20) {
                        VStack {
                            HStack {
                                VStack(spacing: 0) {
                                    SquareButton(action: {
                                        router.showMenu()
                                    }, image: BitesImageName.menuImage.rawValue,
                                                 sizeWImage: 25,
                                                 sizeHImage: 25)
                                    
                                    Text("MENU")
                                        .Bowlby(size: 11,
                                                outlineWidth: 0.5)
                                }
                                .padding(.leading)
                                .padding(.top, 30)
                                
                                Spacer()
                                
                                Text(puzzleModel.name)
                                    .Bowlby(size: 24)
                                    .frame(width: geometry.size.width * 0.486,
                                           height: geometry.size.height * 0.133)
                                    .multilineTextAlignment(.center)
                                    .minimumScaleFactor(0.8)
                                    .padding(.top, 15)
                                
                                Spacer()
                                
                                SquareButton(action: {
                                    
                                    bitesRecipeModel.toggleFav(puzzle: puzzleModel, image: bitesRecipeModel.isFavouriteTapped ? BitesImageName.clearStar.rawValue : BitesImageName.star.rawValue)
                                }, image: bitesRecipeModel.isFavouriteTapped ? BitesImageName.clearStar.rawValue : BitesImageName.star.rawValue,
                                             sizeWImage: 25,
                                             sizeHImage: 25)
                                .padding(.trailing, 10)
                                .padding(.top)
                                
                            }
                            
                            Image(puzzleModel.image)
                                .resizable()
                                .frame(width: 170, height: 170)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 17)
                                        .stroke(Color(red: 255/255, green: 113/255, blue: 172/255), lineWidth: 4)
                                )
                        }
                        
                        ZStack {
                            Image(.receptBack)
                                .resizable()
                                .frame(width: 330, height: 440)
                            
                            VStack(spacing: 20) {
                                Text(puzzleModel.ingredients)
                                    .Bowlby(size: 14,
                                            color: .white,
                                            outlineWidth: 0.5,
                                            colorOutline: Color(red: 249/255, green: 41/255, blue: 85/255))
                                    .frame(width: 280, height: 100, alignment: .leading)
                                
                                Text("Cooking time: \(puzzleModel.cookingTime)")
                                    .Bowlby(size: 14,
                                            color: .white,
                                            outlineWidth: 0.5,
                                            colorOutline: Color(red: 249/255, green: 41/255, blue: 85/255))
                                    .frame(width: 280, height: 30, alignment: .leading)
                                
                                Text("Recipe: \(puzzleModel.recipe)")
                                    .Bowlby(size: 14,
                                            color: .white,
                                            outlineWidth: 0.5,
                                            colorOutline: Color(red: 249/255, green: 41/255, blue: 85/255))
                                    .frame(width: 280, height: 240, alignment: .leading)
                            }
                        }
                        
                        WideButton(action: {
                            router.showMenu()
                        }, text: "NEXT", sizeOfText: 24)
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .onAppear() {
            bitesRecipeModel.isFavouriteTapped = bool
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    let puzzleModel = PuzzleModel(image: "",
                                  name: "",
                                  ingredients: "",
                                  cookingTime: "",
                                  recipe: "",
                                  xPosition: [0.0],
                                  yPosition: [0.0],
                                  puzzleImages: [""])
    @ObservedObject var router = Router()
    let bool = false
    return BitesRecipeView(router: router, puzzleModel: puzzleModel, bool: bool)
}

