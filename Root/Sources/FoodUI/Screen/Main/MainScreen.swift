import SwiftUI
import Modifiers
import SwiftUIPreviewLib
import Localization
import DILib

struct MainScreen: View {
    @Environment(\.viewFactory) var viewFactory
    
    @State
    private var isShowNewFood = false
    
    var body: some View {
        ZStack {
            VStack {
                Text(L10n.hello)
            }
            AddButtonView(toggleValue: $isShowNewFood)
                .modifier(Modifiers.Alignment(.bottomTrailing))
                .padding([.bottom, .trailing], 16)
        }
        .sheet(isPresented: $isShowNewFood) {
            viewFactory.view(forKey: .searchFood)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
            .preferredColorScheme(.light)
            .modifier(PreviewLocaleModifier("ru"))
    }
}
