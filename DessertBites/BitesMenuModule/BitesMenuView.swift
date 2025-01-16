import SwiftUI

struct BitesMenuView: View {
    @StateObject var bitesMenuModel =  BitesMenuViewModel()
    @ObservedObject var router: Router
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(.background)
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Spacer()
                        SquareButton(action: {
                            router.showFavourite()
                        }, image: BitesImageName.favoriteImage.rawValue,
                                     sizeHImage: 23)
                        .padding(.trailing)
                        .padding(.top)
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        Image(.loadingLabel)
                            .resizable()
                            .frame(width: geometry.size.width * 0.85,
                                   height: geometry.size.height * 0.43)
                        
                        VStack(spacing: 20) {
                            WideButton(action: {
                                router.showdDifficalty()
                            }, text: "RECIPES", sizeOfText: 24)
                            
                            WideButton(action: {
                                router.showSettings()
                            }, text: "SETTINGS", sizeOfText: 24)
                        }
                        Spacer()
                    }
                    .padding(.top, 30)
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    @ObservedObject var router = Router()
    return BitesMenuView(router: router)
}

