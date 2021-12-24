import Combine

public protocol ViewModel {
    associatedtype State
    associatedtype Event
    
    var state: State { get }
    var stateWillChange: PassthroughSubject<Void, Never> { get }
    func dispatch(_ event: Event)
}

open class ViewModelAbstract<State, Event>: ViewModel {
    fileprivate(set) public var state: State
    public let stateWillChange = PassthroughSubject<Void, Never>()
    
    public init(initialState state: State) {
        self.state = state
    }
    
    public final func dispatch(_ event: Event) {
        state = makeState(fromEvent: event)
        stateWillChange.send()
    }
    
    open func makeState(fromEvent event: Event) -> State {
        preconditionFailure("must be implement in concrete implementation")
    }
}
