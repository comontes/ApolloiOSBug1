import Apollo
import RocketReserverAPI
import SwiftUI

class LaunchListViewModel: ObservableObject {
    @Published var launches = [LaunchListQuery.Data.Launches.Launch]()
    @Published var lastConnection: LaunchListQuery.Data.Launches?
    @Published var activeRequest: Cancellable?
    @Published var appAlert: AppAlert?
    @Published var notificationMessage: String?
    
    // MARK: - Launch Loading
    
    func loadMoreLaunchesIfTheyExist() {
        guard let connection = self.lastConnection else {
            self.loadMoreLaunches(from: nil)
            return
        }
        
        guard connection.hasMore else {
            return
        }
        
        self.loadMoreLaunches(from: connection.cursor)
    }
    
    private func loadMoreLaunches(from cursor: String?) {
        self.activeRequest = Network.shared.apollo.fetch(query: LaunchListQuery(cursor: cursor ?? .null)) { [weak self] result in
            guard let self = self else {
                return
            }
            
            self.activeRequest = nil
            
            switch result {
            case .success(let graphQLResult):
                if let launchConnection = graphQLResult.data?.launches {
                    self.lastConnection = launchConnection
                    self.launches.append(contentsOf: launchConnection.launches.compactMap { $0 })
                }
                
                if let errors = graphQLResult.errors {
                    self.appAlert = .errors(errors: errors)
                }
            case .failure(let error):
                self.appAlert = .errors(errors: [error])
            }
        }
    }
}
