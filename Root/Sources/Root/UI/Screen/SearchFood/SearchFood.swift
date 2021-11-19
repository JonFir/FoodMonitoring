import SwiftUI
import Modifiers

struct SearchFoodScreen: View {
    @State
    private var isShowCreateFoodChoiceSheet = false
    
    @State
    private var ssss = false
    
    var body: some View {
        ZStack {
            Text("hello", bundle: .safeModule)
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
            FoodDataSearchScreenView<FoodDataSearchViewModelDefault>(viewModel: FoodDataSearchViewModelDefault())
        }
        
    }
}

struct SearchFoodScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchFoodScreen()
    }
}
