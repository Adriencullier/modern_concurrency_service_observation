import SwiftUI

@main
struct AsyncAwaitObservationApp: App {
    let userLogService: UserLogService
    let booksService: BooksService
    
    @MainActor init() {
        self.booksService = BooksService()
        self.userLogService = UserLogService()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                viewModel: ContentViewModel(
                    booksService: self.booksService,
                    userLogService: self.userLogService
                )
            )
                .task {
                    await self.booksService.fetchBooks()
                    await self.userLogService.loginUser()
                }
        }
    }
}
