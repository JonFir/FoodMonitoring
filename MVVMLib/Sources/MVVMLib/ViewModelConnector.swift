import SwiftUI
import Combine

public final class ViewModelConnector<VM: ViewModel>: ObservableObject {
    private let viewModel: VM
    private var stateObserving: AnyCancellable?
    
    public var state: VM.State { viewModel.state }
    
    
    public init(viewModel: VM) {
        self.viewModel = viewModel
        self.stateObserving = viewModel.stateWillChange.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
    public func bind<Value>(
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
    
    public func dispatch(_ event: VM.Event) {
        viewModel.eventPublisher.send(event)
    }
}
