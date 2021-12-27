import Combine
import Foundation

public protocol ViewModel {
    associatedtype State
    associatedtype Event
    
    var state: State { get }
    var stateWillChange: PassthroughSubject<Void, Never> { get }
    var cancellable: Set<AnyCancellable> { get }
    var eventPublisher: PassthroughSubject<Event, Error> { get }
    
    func on(event: Event) -> State?
    func on(error: Error) -> State?
}

open class ViewModelAbstract<State, Event>: ViewModel {
    fileprivate(set) public var state: State
    public let stateWillChange = PassthroughSubject<Void, Never>()
    public var cancellable = Set<AnyCancellable>()
    public let eventPublisher = PassthroughSubject<Event, Error>()
    
    public init(initialState state: State) {
        self.state = state
        setupEventSubscription()
    }
    
    open func on(event: Event) -> State? { nil }
    open func on(error: Error) -> State? { nil }
}


private extension ViewModelAbstract {
    
    func setupEventSubscription() {
        eventPublisher
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .map { [weak self] event in
                self?.on(event: event)
            }
            .catch({ [weak self] error in
                Just(self?.on(error: error))
            })
            .sink { [weak self] state in
                guard let self = self, let state = state else { return }
                self.state = state
                self.stateWillChange.send()
            }.store(in: &cancellable)
    }
    
}
