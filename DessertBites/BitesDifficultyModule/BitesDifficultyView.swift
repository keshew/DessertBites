import SwiftUI

struct BitesDifficultyView: View {
    @StateObject var bitesDifficultyModel =  BitesDifficultyViewModel()
    @ObservedObject var router: Router
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(.background)
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(spacing: 60) {
                    HStack {
                        SquareButton(action: {
                            router.back()
                        }, image: BitesImageName.arrowBack.rawValue)
                        .padding(.leading)
                        .padding(.top)
                        Spacer()
                    }
                    
                    VStack(spacing: 30) {
                        Text("The choice of\n difficulty")
                            .Bowlby(size: 40)
                            .multilineTextAlignment(.center)
                        
                        VStack(spacing: 30) {
                            WideButton(action: {
                                router.showChoosePuzzles(label: "EASY - 16 PIECES",
                                                         puzzleModule: bitesDifficultyModel.contact.easyPuzzle,
                                isDisabled: false)
                            }, text: "EASY", sizeOfText: 24)
                            
                            WideButton(action: {
                                router.showChoosePuzzles(label: "MEDIUM - 25 PIECES",
                                                         puzzleModule: bitesDifficultyModel.contact.mediumPuzzle,
                                                         isDisabled: false)
                            }, text: "MEDIUM", sizeOfText: 24)
                            
                            WideButton(action: {
                                router.showChoosePuzzles(label: "HARD - 36 PIECES",
                                                         puzzleModule: bitesDifficultyModel.contact.hardPuzzle,
                                                         isDisabled: true)
                            }, text: "HARD", sizeOfText: 24)
                        }
                    }
                    
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    @ObservedObject var router = Router()
    return BitesDifficultyView(router: router)
}
