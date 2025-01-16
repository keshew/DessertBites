import SwiftUI

struct BitesLoadingView: View {
    @StateObject var bitesLoadingModel =  BitesLoadingViewModel()
    @ObservedObject var router = Router()
   
    var body: some View {
        NavigationStack(path: $router.path) {
            GeometryReader { geometry in
                ZStack {
                    Image(.background)
                        .resizable()
                        .ignoresSafeArea()
                    
                    VStack {
                        Spacer()
                        Image(.loadingLabel)
                            .resizable()
                            .frame(width: geometry.size.width * 0.85,
                                   height: geometry.size.height * 0.43)
                        
                        Spacer()
                        Text(bitesLoadingModel.currentText)
                            .Bowlby(size: 30)
                            .padding(.bottom, 30)
                    } 
                }
            }
            .navigationDestination(for: AppScreen.self) { screen in
                switch screen {
                case .settings:
                    BitesSettingsView(router: router)
                case .lesson:
                    BitesLessonView(router: router)
                case .menu:
                    BitesMenuView(router: router)
                case .choosePuzzles(let label, let puzzles, let isDisabled):
                    BitesChoosePuzzlesView(router: router,
                                           levelDescription: label,
                                           puzzlesModel: puzzles,
                                           isDisabled: isDisabled)
                case .difficalty:
                    BitesDifficultyView(router: router)
                case .favourite:
                    BitesFavoriteView(router: router)
                case .recept(let puzzleModel, let bool):
                    BitesRecipeView(router: router, puzzleModel: puzzleModel, bool: bool)
                case .game(let puzzleModel):
                    PuzzleGameView(router: router, puzzleModel: puzzleModel)
                }
            }
        }
        .onAppear {
            UserDefaultsManager().checkFirstLaunch {
                bitesLoadingModel.isFirstLaunch = false
            } completiomElse: {
                bitesLoadingModel.isFirstLaunch = true
                bitesLoadingModel.setupFav()
            }

            bitesLoadingModel.startTimer()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                if bitesLoadingModel.isFirstLaunch {
                    router.showLesson()
                } else {
                    router.showMenu()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    BitesLoadingView()
}

