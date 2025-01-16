import SwiftUI

class BitesLoadingViewModel: ObservableObject {
    let contact = BitesLoadingModel()
    @Published var currentIndex = 0
    @Published var currentText = "LOADING..."
    @Published var timer: Timer?
    @Published var isFirstLaunch = false
    func startTimer() {
         timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
             self.changeText()
         }
     }
    
    func changeText() {
        currentIndex -= 1
        if currentIndex == -1 {
            currentIndex = 2
        }
        currentText = contact.arrayOfLoadingText[currentIndex]
     }
    
    func setupFav() {
        UserDefaultsManager().savePuzzles(contact.easyPuzzle)
    }
}
