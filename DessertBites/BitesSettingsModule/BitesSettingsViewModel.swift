import SwiftUI

class BitesSettingsViewModel: ObservableObject {
    let contact = BitesSettingsModel()
    @Published var isSoundOff = false
    @Published var isMusicOff = false
    
}
