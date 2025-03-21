import RocketReserverAPI
import SwiftUI

struct LaunchRow: View {
    let launch: LaunchListQuery.Data.Launches.Launch

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(launch.mission?.name ?? "Mission Name")
                Text(launch.site ?? "Launch Site")
                    .font(.system(size: 14))
            }

            Spacer()
        }
        .padding(4)
    }
}
