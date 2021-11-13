import SwiftUI
import Modifiers

struct ContentView: View {
    var body: some View {
        ZStack {
            Text("hello", bundle: .safeModule)
            Button(action: {}, label: {Image(systemName: "plus")})
                .frame(width: 44, height: 44)
                .background(Color.accentColor)
                .foregroundColor(Color.white)
                .cornerRadius(22).shadow(color: .black.opacity(0.4), radius: 3, x: 1, y: 3)
                .modifier(Modifiers.Alignment(.bottomTrailing))
                .padding([.bottom, .trailing], 16)
                
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.locale, .init(identifier: "en"))
    }
}
