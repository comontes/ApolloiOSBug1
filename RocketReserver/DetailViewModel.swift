import Apollo
import RocketReserverAPI
import SwiftUI

class DetailViewModel: ObservableObject {
    let launchID: RocketReserverAPI.ID
    
    @Published var launch: LaunchDetailsQuery.Data.Launch?
    @Published var appAlert: AppAlert?
    
    init(launchID: RocketReserverAPI.ID) {
        self.launchID = launchID
    }
    
    func loadLaunchDetails(forceReload: Bool = false) {
        guard forceReload || launchID != launch?.id else {
            return
        }
        
        let cachePolicy: CachePolicy = forceReload ? .fetchIgnoringCacheData : .returnCacheDataElseFetch
        
        Network.shared.apollo.fetch(query: LaunchDetailsQuery(launchId: launchID), cachePolicy: cachePolicy) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let graphQLResult):
                if let launch = graphQLResult.data?.launch {
                    self.launch = launch
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
