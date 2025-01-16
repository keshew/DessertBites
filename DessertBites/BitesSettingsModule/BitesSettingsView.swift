import SwiftUI

struct BitesSettingsView: View {
    @StateObject var bitesSettingsModel =  BitesSettingsViewModel()
    @ObservedObject var router: Router
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(.background)
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        SquareButton(action: {
                            router.back()
                        }, image: BitesImageName.arrowBack.rawValue)
                        .padding(.leading)
                        .padding(.top)
                        Spacer()
                    }
                    
                
                    VStack(spacing: geometry.size.height * 0.133) {
                        Text("SETTINGS")
                            .Bowlby(size: 32)
                        
                        HStack(spacing: 40) {
                            VStack {
                                Button(action: {
                                    bitesSettingsModel.isSoundOff.toggle()
                                }) {
                                    Image(bitesSettingsModel.isSoundOff ? BitesImageName.buttonSoundOff.rawValue : BitesImageName.buttonSound.rawValue)
                                        .resizable()
                                        .frame(width: 75, height: 75)
                                }
                                
                                Text("SOUND")
                                    .Bowlby(size: 15, outlineWidth: 0.8)
                            }
                            
                            VStack {
                                Button(action: {
                                    bitesSettingsModel.isMusicOff.toggle()
                                }) {
                                    Image(bitesSettingsModel.isMusicOff ? BitesImageName.buttonMusicOff.rawValue : BitesImageName.buttonMusic.rawValue)
                                        .resizable()
                                        .frame(width: 75, height: 75)
                                }
                                
                                Text("MUSIC")
                                    .Bowlby(size: 15, outlineWidth: 0.8)
                                    .offset(x: 2)
                            }
                        }
                        
                    }
                    .padding(.top, geometry.size.height * 0.106)
                    
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    @ObservedObject var router = Router()
    return BitesSettingsView(router: router)
}

