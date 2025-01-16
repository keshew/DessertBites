import SwiftUI

struct BitesLessonView: View {
    @StateObject var bitesLessonModel =  BitesLessonViewModel()
    @ObservedObject var router: Router
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(.background)
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        if bitesLessonModel.currentIndex == 1 || bitesLessonModel.currentIndex == 2  {
                            SquareButton(action: {
                                bitesLessonModel.lowerIndex()
                            }, image: BitesImageName.arrowBack.rawValue)
                            .padding(.leading, 30)
                            .padding(.top)
                        }
                        Spacer()
                    }
                    
                    Spacer()
                    
                    Text(bitesLessonModel.contact.arrayOfTextLesson[bitesLessonModel.currentIndex])
                        .Bowlby(size: geometry.size.height * 0.04)
                        .frame(width: bitesLessonModel.currentIndex == 0 ? 310 : 250)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .offset(y: bitesLessonModel.currentIndex == 0 ? 40 : -0)
                    
                    Spacer()
                    
                    WideButton(action: {
                        bitesLessonModel.increaseIndex()
                        bitesLessonModel.goToMenu {
                            router.showMenu()
                        }
                    }, text: bitesLessonModel.contact.arrayOfTextButton[bitesLessonModel.currentIndex])
                    .disabled(bitesLessonModel.isDisabledNextButton())
                    .padding(.bottom, 30)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    @ObservedObject var router = Router()
    return BitesLessonView(router: router)
}

