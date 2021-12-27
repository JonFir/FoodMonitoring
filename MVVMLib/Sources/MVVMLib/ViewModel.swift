import Combine
import Foundation

public protocol ViewModel {
    associatedtype State
    associatedtype Event
    
    var state: State { get }
    var stateWillChange: PassthroughSubject<Void, Never> { get }
    var cancellable: Set<AnyCancellable> { get }
    
    func dispatch(_ event: Event)
    func on(event: Event) -> State?
}

open class ViewModelAbstract<State, Event>: ViewModel {
    fileprivate(set) public var state: State
    public let stateWillChange = PassthroughSubject<Void, Never>()
    public var cancellable = Set<AnyCancellable>()
    
    
    private let eventPublisher = PassthroughSubject<Event, Never>()
    
    public init(initialState state: State) {
        self.state = state
        eventPublisher
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .map { [weak self] event in
                return self?.on(event: event)
            }
            .sink { [weak self] state in
                guard let self = self, let state = state else { return }
                self.state = state
                self.stateWillChange.send()
            }.store(in: &cancellable)
    }
    
    public final func dispatch(_ event: Event) {
        eventPublisher.send(event)
    }
    
    open func on(event: Event) -> State? {
        preconditionFailure("must be implement in concrete implementation")
    }
}
