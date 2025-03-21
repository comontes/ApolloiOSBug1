import Apollo
import RocketReserverAPI
import SwiftUI

class LaunchListViewModel: ObservableObject {
    @Published var launches = [LaunchListQuery.Data.Launches.Launch]()
    @Published var appAlert: AppAlert?
 
    func loadLaunches() {
        Network.shared.apollo
            .fetch(query: LaunchListQuery(), cachePolicy: .returnCacheDataElseFetch) { [weak self] result in
                guard let self = self else {
                    return
                }
            
                switch result {
                case .success(let graphQLResult):
                
                    if graphQLResult.source == .server {
                        debugPrint("LaunchListQuery Data came from the NETWORK")
                    } else if graphQLResult.source == .cache {
                        debugPrint("LaunchListQuery Data came from the CACHE")
                    }
                
                    if let launchConnection = graphQLResult.data?.launches {
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
