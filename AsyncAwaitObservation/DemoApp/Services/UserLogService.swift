/// 1. Make your class conform to ObservedService
/// 2. Pass initial state and key related to service in super.init
/// 3. Trigger all the observers with func updateObservers(_ state: ServiceState)
final class UserLogService: ObservedService {
    @MainActor var data: UserLogState = .logout
     
    @MainActor init() {
        super.init(state: .none, key: .userLog)
    }
    
    func loginUser() {
        Task {
            await self.updateObservers(.loading)
            try await Task.sleep(for: .seconds(3))
            await self.updateObservers(.success)
            await MainActor.run {
                self.data = .login
            }
        }
    }
}

