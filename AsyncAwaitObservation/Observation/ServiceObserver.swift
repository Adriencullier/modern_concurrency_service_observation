import SwiftUI

@MainActor
/// Aims to give a class the possibility to observe one or multiple ObservedService
class ServiceObserver {
    // MARK: - Properties
    /// Services to observe
    private let observedServices: [ObservedService]
    
    // MARK: - Init
    init(servicesToObserve: [ObservedService]) {
        self.observedServices = servicesToObserve
    }
    
    // MARK: - Internal functions
    /// Aims to pass ObservedState related to the service for each observed service update
    /// - Parameter completion: ObservedState related to the service
    func observe(completion: @escaping (ObservedState) -> Void) {
        self.observedServices.forEach { service in
            withObservationTracking {
                _ = service.state
                completion(service.state)
            } onChange: {}
        }
    }
}
