import SwiftUI

struct LaunchListView: View {
    @StateObject private var viewModel = LaunchListViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(0 ..< viewModel.launches.count, id: \.self) { index in
                    NavigationLink(destination: DetailView(launchID: viewModel.launches[index].id)) {
                        LaunchRow(launch: viewModel.launches[index])
                    }
                }
            }
            .task {
                viewModel.loadLaunches()
            }
            .navigationTitle("Rocket Launches")
            .appAlert($viewModel.appAlert)
        }
    }
}

struct LaunchListView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchListView()
    }
}
