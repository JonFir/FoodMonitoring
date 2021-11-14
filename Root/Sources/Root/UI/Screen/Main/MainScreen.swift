import SwiftUI
import Modifiers

struct MainScreen: View {
    @State
    private var isShowNewFood = false
    
    var body: some View {
        ZStack {
            Text(L10n.hello)
            AddButtonView(toggleValue: $isShowNewFood)
                .modifier(Modifiers.Alignment(.bottomTrailing))
                .padding([.bottom, .trailing], 16)
        }
        .sheet(isPresented: $isShowNewFood, content: SearchFoodScreen.init)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
            .preferredColorScheme(.light)
            .environment(\.locale, .init(identifier: "ru"))
    }
}
