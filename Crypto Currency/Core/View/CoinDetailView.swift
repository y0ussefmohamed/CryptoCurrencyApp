//
//  CoinDetailView.swift
//  Crypto Currency
//
//  Created by Youssef Mohamed on 09/03/2024.
//

import SwiftUI

struct CoinDetailView: View 
{
    let coin: Coin
    
    var body: some View {
        VStack {
            Text(coin.name).font(.largeTitle)
                .bold()
            Spacer()
            AsyncImage(url: URL(string: coin.image)) { image in
              image.resizable()
                    .frame(width: 60 , height: 60)
            } placeholder: {
              ProgressView()
            }
            
            Text(String(format: "%.2f", coin.current_price)).font(.title)

            Spacer()
        }.navigationTitle("Coins")
    }
}

#Preview {
    CoinDetailView(coin: Coin(id: "bit", symbol: "BTC", name: "Bitcoin", image: "kff", current_price: 200, price_change_percentage_24h: 2.3, market_cap_rank: 1))
}
