/// 1. Make your class conform to ObservedService
/// 2. Pass initial state and key related to service in super.init
/// 3. Trigger all the observers with func updateObservers(_ state: ServiceState)
final class BooksService: ObservedService {
    @MainActor var data: [Book] = [Book(title: "test")]
     
    @MainActor init() {
        super.init(state: .none, key: .books)
    }
    
    func fetchBooks() {
        Task {
            await self.updateObservers(.loading)
            try await Task.sleep(for: .seconds(5))
            await self.updateObservers(.success)
            await MainActor.run {
                self.data = [Book(title: "Hello"), Book(title: "World")]
            }
        }
    }
}
