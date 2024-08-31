enum ServiceState {
    case none
    case loading
    case error(error: String)
    case success
}
