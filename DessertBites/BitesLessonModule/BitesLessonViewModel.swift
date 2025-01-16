import SwiftUI

class BitesLessonViewModel: ObservableObject {
    let contact = BitesLessonModel()
    @Published var currentIndex = 0
    
    func increaseIndex() {
        currentIndex += 1
    }
    
    func lowerIndex() {
        currentIndex -= 1
    }
    
    func goToMenu(closure: () -> ()) {
        if currentIndex == 2 {
            closure()
        }
    }
    
    func isDisabledNextButton() -> Bool {
        var boolValue = false
        if currentIndex < 2 {
            boolValue = false
        } else {
            boolValue = true
        }
        return boolValue
    }
    
    func isDisabledPreviousButton() -> Bool {
        var boolValue = false
        if currentIndex == 1 {
            boolValue = false
        } else {
            boolValue = true
        }
        return boolValue
    }
}
