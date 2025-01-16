import SwiftUI

extension Text {
    func Bowlby(size: CGFloat,
                color: Color = Color(red: 255/255, green: 113/255, blue: 172/255),
                outlineWidth: CGFloat = 1,
                colorOutline: Color = Color(red: 145/255, green: 15/255, blue: 37/255)) -> some View {
        self.font(.custom("BowlbyOneSC-Regular", size: size))
            .foregroundColor(color)
            .outlineText(color: colorOutline, width: outlineWidth)
    }
}

