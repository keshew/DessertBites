import SwiftUI

struct BitesFavoriteView: View {
    @StateObject var bitesFavoriteModel = BitesFavoriteViewModel()
    @ObservedObject var router: Router
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(.background)
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    VStack(spacing: 15) {
                        HStack {
                            SquareButton(action: {
                                router.back()
                            }, image: BitesImageName.arrowBack.rawValue)
                            .padding(.leading)
                            .padding(.top)
                            Spacer()
                            
                            Text("FAVOURITES")
                                .Bowlby(size: 28)
                                .padding(.trailing, geometry.size.width * 0.257)
                                .padding(.top, 10)
                        }
                    }
                    
                    ScrollView {
                        LazyVGrid(columns: bitesFavoriteModel.columns, spacing: 20) {
                            ForEach(bitesFavoriteModel.getRecept(), id: \.self) { item in
                                Button(action: {
                                    router.showRecept(puzzleModel: item, bool: false)
                                }) {
                                    ZStack {
                                        Image(item.image)
                                            .resizable()
                                            .frame(width: geometry.size.width * 0.255,
                                                   height: geometry.size.width * 0.255)
                                        
                                        Image(.star)
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .offset(x: 42, y: 45)
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    @ObservedObject var router = Router()
    return BitesFavoriteView(router: router)
}

