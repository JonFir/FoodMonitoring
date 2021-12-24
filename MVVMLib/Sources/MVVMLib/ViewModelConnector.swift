import SwiftUI

public protocol ViewModelConnector: ObservableObject {
    associatedtype VM: ViewModel
    
    var viewModel: VM { get }
    var state: VM.State { get }
    
    func bind<Value>(
        _ get: KeyPath<VM.State, Value>,
        _ eventBuilder: @escaping (Value) -> VM.Event
    ) -> Binding<Value>
    
    func dispatch(_ event: VM.Event)
}

public extension ViewModelConnector {
    var state: VM.State { viewModel.state }
    
    func bind<Value>(
        _ get: KeyPath<VM.State, Value>,
        _ eventBuilder: @escaping (Value) -> VM.Event
    ) -> Binding<Value> {
        Binding {
            self.viewModel.state[keyPath: get]
        } set: {
            let event = eventBuilder($0)
            self.dispatch(event)
        }
    }
    
    func dispatch(_ event: VM.Event) {
        viewModel.dispatch(event)
    }
}
