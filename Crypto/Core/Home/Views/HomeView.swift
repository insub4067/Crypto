//
//  HomeView.swift
//  Crypto
//
//  Created by Kim Insub on 2023/01/11.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var showPortfolio = false
    @State private var showPortfolioView = false

    var body: some View {
        ZStack {
            background
            VStack {
                homeHeader
                HomeStatsView(showPortfolio: $showPortfolio)
                SearchBarView(searchText: $viewModel.searchText)
                columnTitles
                coinsList
                porfolioCoinsList
                Spacer(minLength: 0)
            }
        }
    }
}

private extension HomeView {
    
    var background: some View {
        Color.theme.background
            .ignoresSafeArea()
            .sheet(isPresented: $showPortfolioView) {
                PortfolioView()
                    .environmentObject(viewModel)
            }
    }

    var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none, value: false)
                .onTapGesture {
                    guard showPortfolio else { return }
                    showPortfolioView.toggle()
                }
                .background(
                    CirecleButtonAnimationView(animate: $showPortfolio)
                )
            Spacer()
            Text("Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
    }

    @ViewBuilder
    var coinsList: some View {
        if !showPortfolio {
            List {
                ForEach(viewModel.coins) { coin in
                    CointRowView(coin: coin, showHoldingsColumn: false)
                        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                }
            }
            .listStyle(PlainListStyle())
            .transition(.move(edge: .leading))
        }
    }

    @ViewBuilder
    var porfolioCoinsList: some View {
        if showPortfolio {
            List {
                ForEach(viewModel.portfolioCoins) { coin in
                    CointRowView(coin: coin, showHoldingsColumn: true)
                        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                }
            }
            .listStyle(PlainListStyle())
            .transition(.move(edge: .trailing))
        }
    }

    var columnTitles: some View {
        HStack {
            Text("Coin")
            Spacer()
            if showPortfolio { Text("Holdings") }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)

        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeViewModel)
    }
}
