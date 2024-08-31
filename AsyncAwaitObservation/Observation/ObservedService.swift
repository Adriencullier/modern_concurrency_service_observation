import SwiftUI

@Observable
@ObservationActor
/// Aims to make a service thread safe (Observation actor) and observable from the main thread
class ObservedService {
    // MARK: - Properties
    /// State which is observed from the main thread
    @MainActor private(set) var state: ObservedState
    
    /// Key related to the service
    private let key: Servicekey
    
    // MARK: - Init
    @MainActor init(state: ServiceState, key: Servicekey) {
        self.state = ObservedState(state: state, key: key)
        self.key = key
    }
    
    // MARK: - Internal functions
    @MainActor
    /// Aims to update the observers with a new state
    /// - Parameter state: new state to update
    func updateObservers(_ state: ServiceState) {
        self.state = ObservedState(state: state, key: self.key)
    }
}
