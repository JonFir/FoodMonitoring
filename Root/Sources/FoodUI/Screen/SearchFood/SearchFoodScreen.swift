import SwiftUI
import Modifiers
import Localization
import DILib

struct SearchFoodScreen: View {
    @Environment(\.viewFactory) var viewFactory
    
    @State
    private var isShowCreateFoodChoiceSheet = false
    
    @State
    private var ssss = false
    
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
            viewFactory.view(forKey: .foodDataSearch)
        }
        
    }
}

struct SearchFoodScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchFoodScreen()
    }
}
