import SwiftUI
import Modifiers
import SwiftUIPreviewLib
import Localization

public struct MainScreen: View {
    typealias MakeSearchFoodScreen = () -> AnyView
    
    private let makeSearchFoodScreen: MakeSearchFoodScreen
    
    @State
    private var isShowNewFood = false
    
    init(
         makeSearchFoodScreen: @escaping MakeSearchFoodScreen
    ) {
        self.makeSearchFoodScreen = makeSearchFoodScreen
    }
    
    public var body: some View {
        ZStack {
            VStack {
                Text(L10n.hello)
            }
            AddButtonView(toggleValue: $isShowNewFood)
                .modifier(Modifiers.Alignment(.bottomTrailing))
                .padding([.bottom, .trailing], 16)
        }
        .sheet(isPresented: $isShowNewFood, content: makeSearchFoodScreen)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen { AnyView(Text("Next1")) }
            .preferredColorScheme(.light)
            .modifier(PreviewLocaleModifier("ru"))
    }
}
