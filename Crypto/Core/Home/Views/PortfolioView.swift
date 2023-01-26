//
//  PortfolioView.swift
//  Crypto
//
//  Created by Kim Insub on 2023/01/16.
//

import SwiftUI

struct PortfolioView: View {

    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText = ""
    @State private var showCheckmark = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $viewModel.searchText)
                    coinLogoList
                    if selectedCoin != nil { portfolioInputSection }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton { presentationMode.wrappedValue.dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingNavBarButton
                }
            }
        }
    }
}

extension PortfolioView {

    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(viewModel.coins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(2)
                        .onTapGesture { withAnimation(.easeIn) { selectedCoin = coin } }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    selectedCoin?.id == coin.id ?
                                    Color.theme.green : Color.clear,
                                    lineWidth: 1
                                )
                        )
                }
            }
            .frame(height: 100)
            .padding(.leading)
        }
    }

    private var portfolioInputSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith2Decimals() ?? "")
            }
            Divider()
            HStack {
                Text("Amount Holdings:")
                Spacer()
                TextField("Ex: 14", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current Value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .animation(.none, value: true)
        .padding()
        .font(.headline)
    }

    private func getCurrentValue() -> Double {
        guard let quantity = Double(quantityText) else { return 0}
        return quantity * (selectedCoin?.currentPrice ?? 0)
    }

    private var trailingNavBarButton: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
            Button {
                saveButtonPressed()
            } label: {
                Text("Save".uppercased())
            }
            .opacity(
                (selectedCoin != nil) && (selectedCoin?.currentHoldings != Double(quantityText)) ?
                1.0 :
                0.0
            )
        }
        .font(.headline)
    }

    private func saveButtonPressed() {
        guard let coin = selectedCoin else { return }

        // show checkmark
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedCoin()
        }

        // hide keyboard
        UIApplication.shared.endEditing()

        // hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) { showCheckmark = false }
        }
    }

    private func removeSelectedCoin() {
        selectedCoin = nil
        viewModel.searchText = ""
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeViewModel)
    }
}
