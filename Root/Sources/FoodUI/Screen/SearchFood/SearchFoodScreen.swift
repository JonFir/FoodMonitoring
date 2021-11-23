import SwiftUI
import Modifiers
import Localization

struct SearchFoodScreen: View {
    typealias MakeFoodDataSearchScreen = () -> AnyView
    private let makeFoodDataSearchScreen: MakeFoodDataSearchScreen
    
    @State
    private var isShowCreateFoodChoiceSheet = false
    
    @State
    private var ssss = false
    
    init(
        makeFoodDataSearchScreen: @escaping MakeFoodDataSearchScreen
    ) {
        self.makeFoodDataSearchScreen = makeFoodDataSearchScreen
    }
    
    var body: some View {
        ZStack {
            Text("hello")
            AddButtonView(toggleValue: $isShowCreateFoodChoiceSheet)
                .modifier(Modifiers.Alignment(.bottomTrailing))
                .padding([.bottom, .trailing], 16)
        }
        .confirmationDialog(
            "Select how to create food",
            isPresented: $isShowCreateFoodChoiceSheet,
            titleVisibility: .hidden
        ) {
            Button {
                ssss.toggle()
            } label: {
                Text(L10n.createFoodChoiceSheetSimpleDish)
            }

            Button {
                ssss.toggle()
            } label: {
                Text(L10n.createFoodChoiceSheetComplexDish)
            }
        }
        .sheet(isPresented: $ssss) {
            makeFoodDataSearchScreen()
        }
        
    }
}

struct SearchFoodScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchFoodScreen { AnyView(Text("")) }
    }
}
