import SwiftUI

struct WideButton: View {
    var action: (() -> ())
    var text: String
    var sizeOfText: CGFloat = 26
    var body: some View {
        Button(action: {
            action()
        }) {
            ZStack {
                Image(.wideBackgroundButton)
                    .resizable()
                    .frame(width: 200, height: 90)
                
                Text(text)
                    .Bowlby(size: sizeOfText, color: .white,
                            outlineWidth: 0.8,
                            colorOutline: Color(red: 249/255, green: 41/255, blue: 85/255))
            }
        }
    }
}

struct SquareButton: View {
    var action: (() -> ())
    var image: String
    var sizeWImage: CGFloat = 25
    var sizeHImage: CGFloat = 15
    var sizeWBack: CGFloat = 50
    var body: some View {
        Button(action: {
            action()
        }) {
            ZStack {
                Image(.squareButtonBackground)
                    .resizable()
                    .frame(width: sizeWBack, height: sizeWBack)
                
                Image(image)
                    .resizable()
                    .frame(width: sizeWImage, height: sizeHImage)
            }
        }
    }
}

struct PuzzleImage: View {
    var action: (() -> ())
    var image: String
    var body: some View {
        Button(action: {
            action()
        }) {
            Image(image)
                .resizable()
                .frame(width: 120, height: 120)
        }
    }
}
