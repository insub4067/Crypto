//
//  CointRowView.swift
//  Crypto
//
//  Created by Kim Insub on 2023/01/12.
//

import SwiftUI

struct CointRowView: View {

    let coin: CoinModel
    let showHoldingsColumn: Bool

    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            Spacer()
            centerColumn
            rightColumn
        }
        .font(.subheadline)
    }
}

struct CointRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CointRowView(coin: dev.coin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)

            CointRowView(coin: dev.coin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}

private extension CointRowView {

    var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 30)
            Circle()
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(Color.theme.accent)
        }
    }

    @ViewBuilder
    var centerColumn: some View {
        if showHoldingsColumn {
            VStack {
                Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                Text((coin.currentHoldings ?? 0).asNumberString())
            }
            .foregroundColor(Color.theme.accent)
        }
    }

    var rightColumn: some View {
        VStack {
            Text(coin.currentPrice.asCurrencyWith2Decimals())
                .bold()
                .foregroundColor(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ?
                    Color.theme.green :
                    Color.theme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3)
    }
}
