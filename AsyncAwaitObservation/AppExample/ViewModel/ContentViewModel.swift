import Foundation

/// 1. Make your class conform to ServiceObserver
/// 2. Pass the services to observe in super.init
/// 3. Implement func observe(completion: @escaping (ObservedState) -> Void) from ServiceObserver class
@Observable
final class ContentViewModel: ServiceObserver {
    unowned let booksService: BooksService
    unowned let userLogService: UserLogService
    
    var userLogState: UserLogState = .logout
    var booksCount: Int = 0
    
    init(booksService: BooksService, userLogService: UserLogService) {
        self.booksService = booksService
        self.userLogService = userLogService
        
        super.init(
            servicesToObserve: [
                booksService,
                userLogService
            ]
        )
        self.startObservation()
    }
    
    private func startObservation() {
        self.observe { state in
            switch state.key {
            case .books:
                Task {
                    self.booksCount = self.booksService.data.count
                }
            case .userLog:
                Task {
                    self.userLogState = self.userLogService.data
                }
            }
        }
    }
}
