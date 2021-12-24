import Combine

public protocol ViewModel {
    associatedtype State
    associatedtype Event
    
    var state: State { get }
    var stateWillChange: PassthroughSubject<Void, Never> { get }
    func dispatch(_ event: Event)
}
