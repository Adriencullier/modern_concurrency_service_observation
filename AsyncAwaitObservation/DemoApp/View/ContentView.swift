import SwiftUI

struct ContentView: View {
    @State var title: String = ""
    private let viewModel: ContentViewModel
    
    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 32) {
            Text("User is" + String(describing: self.viewModel.userLogState))
            Text(String(self.viewModel.booksCount) + " books in the library")
        }
        .padding()
    }
}
