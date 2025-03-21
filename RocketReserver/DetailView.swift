import RocketReserverAPI
import SwiftUI

struct DetailView: View {
    @StateObject private var viewModel: DetailViewModel
    
    init(launchID: RocketReserverAPI.ID) {
        _viewModel = StateObject(wrappedValue: DetailViewModel(launchID: launchID))
    }
    
    var body: some View {
        VStack {
            if let launch = viewModel.launch {
                HStack(spacing: 10) {
                    VStack(alignment: .leading, spacing: 4) {
                        if let missionName = launch.mission?.name {
                            Text(missionName)
                                .font(.system(size: 24, weight: .bold))
                        }
                        
                        if let launchSite = launch.site {
                            Text(launchSite)
                                .font(.system(size: 14))
                        }
                    }
                    
                    Spacer()
                }
            }
            Spacer()
        }
        .padding(10)
        .navigationTitle(viewModel.launch?.mission?.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            viewModel.loadLaunchDetails()
        }
        .appAlert($viewModel.appAlert)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(launchID: "110")
    }
}
