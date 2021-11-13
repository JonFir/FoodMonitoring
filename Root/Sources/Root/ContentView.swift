import SwiftUI
import Modifiers

struct ContentView: View {
    var body: some View {
        ZStack {
            Text("hello", bundle: .safeModule)
            AddButtonView()
                .modifier(Modifiers.Alignment(.bottomTrailing))
                .padding([.bottom, .trailing], 16)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.locale, .init(identifier: "ru"))
    }
}

private struct AddButtonView: View {
    var body: some View {
        Button {
            print("привет")
        } label: {
            Image(systemName: "plus")
        }
        .buttonStyle(.borderedProminent)
        .shadow(color: .black.opacity(0.4), radius: 3, x: 1, y: 3)
            
    }
}
