//
//  StatisticView.swift
//  Crypto
//
//  Created by Kim Insub on 2023/01/14.
//

import SwiftUI

struct StatisticView: View {

    let stat: StatisticModel
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            HStack {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(
                            degrees: (stat.percentageChange ?? 0) >= 0 ?
                            0 : 180
                        )
                    )
                Text(stat.percentageChange?.asPercentString() ?? "")
            }
            .foregroundColor(
                (stat.percentageChange ?? 0) >= 0 ?
                Color.theme.green : Color.theme.red
            )
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatisticView(stat: dev.stat1)
            StatisticView(stat: dev.stat2)
            StatisticView(stat: dev.stat3)
        }
    }
}
