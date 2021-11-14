import SwiftUI

struct AddButtonView: View {
    
    @Binding var toggleValue: Bool
    
    var body: some View {
        Button {
            toggleValue.toggle()
        } label: {
            Image(systemName: "plus")
        }
        .buttonStyle(.borderedProminent)
        .shadow(color: .black.opacity(0.4), radius: 3, x: 1, y: 3)
        
    }
}

struct AddButtonView_Previews: PreviewProvider {
    @State
    static var toggleValue = false
    
    static var previews: some View {
        AddButtonView(toggleValue: $toggleValue)
    }
    
}
