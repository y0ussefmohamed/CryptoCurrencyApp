import SwiftUI


struct HomeView: View 
{
    @StateObject var coinViewModel = CoinViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Live Prices")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                }.padding(.vertical)
                
                HStack {
                    Text("Top Movers")
                        .font(.title2)
                        .bold()
                    Spacer()
                }.padding(.vertical)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(coinViewModel.topMoversCoins) { coin in
                            NavigationLink(destination: CoinDetailView(coin: coin)) {
                                TopMoversCard(coin: coin)
                            }.foregroundStyle(.primary)
                        }
                        
                    }
                }.scrollIndicators(.never).padding(.bottom)
                
                Divider()
                
                HStack {
                    Text("All Coins")
                        .font(.title2)
                        .bold()
                    Spacer()
                }.padding(.vertical)
                
                HStack {
                    Text("Coin")
                        .bold()
                        .foregroundStyle(.gray)
                    Spacer()
                    Text("Prices")
                        .bold()
                        .foregroundStyle(.gray)
                }
                
                ScrollView(.vertical) {
                    VStack {
                        ForEach(coinViewModel.coins) { coin in
                            NavigationLink(destination: CoinDetailView(coin: coin)) {
                                CoinCard(coin: coin)
                            }.foregroundStyle(.primary)
                        }
                    }
                }.scrollIndicators(.never)
                Spacer()
            }
            .padding()
            .edgesIgnoringSafeArea(.bottom)
        }.navigationTitle("Coins")
    }
}

struct TopMoversCard: View 
{
    let coin: Coin
    @State var currentPrice: String?
        
        init(coin: Coin) {
            self.coin = coin
            _currentPrice = State(initialValue: removeTrailingZeros(from: (String(coin.current_price))))
        }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                // trending coin .thumb
                AsyncImage(url: URL(string: coin.image)) { image in
                  image.resizable()
                        .frame(width: 30 , height: 30) 
                } placeholder: {
                  ProgressView()
                }
                
                HStack {
                    
                    Text("\(coin.symbol.uppercased())").bold().foregroundStyle(.background)
                    Text(String(format:"%.2f",coin.current_price)).font(.caption).foregroundStyle(.gray).fontWeight(.semibold)
                }
                
                if coin.price_change_percentage_24h! > 0 {
                    Text(String(format: "%.2f", coin.price_change_percentage_24h ?? 0.0) + "%").foregroundStyle(.green)
                } else if ( coin.price_change_percentage_24h! == 0 ) {
                    Text(String(format: "%.2f", coin.price_change_percentage_24h ?? 0.0) + "%").foregroundStyle(.gray)
                } else {
                    Text(String(format: "%.2f", coin.price_change_percentage_24h ?? 0.0) + "%").foregroundStyle(.red)
                }
            }
            .padding(20)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(lineWidth: 1).opacity(0.2)
                    .padding(2) // Adjust the padding here
            )
            .background(Color("TopMoversCardBackground"))
            .cornerRadius(25)
            .padding(.leading)
        }
    }
    
    private func removeTrailingZeros(from price: String) -> String {
            var modifiedPrice = price
            while modifiedPrice.last == "0" {
                modifiedPrice.removeLast()
                if modifiedPrice.last == "." {
                    modifiedPrice.append("0")
                    return modifiedPrice
                }
            }
            return modifiedPrice
        }
}

struct CoinCard: View 
{
    let coin: Coin
    
    var body: some View {
        HStack {
            Text(String(coin.market_cap_rank))
                .foregroundStyle(.gray)
            
            VStack {
                Spacer()
                AsyncImage(url: URL(string: coin.image)) { image in
                  image.resizable()
                        .frame(width: 35 , height: 35) // or .fill
                } placeholder: {
                  ProgressView()
                }
//                Image(systemName: "bitcoinsign.circle.fill")
//                    .resizable()
//                    .frame(width: 35, height: 35)
//                    .foregroundStyle(.orange)
                Spacer()
            }.padding(.horizontal,5)
            
            
            VStack(alignment: .leading) {
                Text("\(coin.name)")
                    .font(.title3)
                    .bold()
                
                Text("\(coin.symbol.uppercased())")
                    .fontWeight(.light)
            }
            
            Spacer()
             
            VStack(alignment: .trailing) {
                Text(String(format: "%.2f", coin.current_price))
                    .font(.title3)
                    .bold()
                
                if coin.price_change_percentage_24h! > 0 {
                    Text(String(format: "%.2f", coin.price_change_percentage_24h ?? 0.0) + "%").fontWeight(.semibold).foregroundStyle(.green)
                } else if ( coin.price_change_percentage_24h! == 0 ) {
                    Text(String(format: "%.2f", coin.price_change_percentage_24h ?? 0.0) + "%").fontWeight(.semibold).foregroundStyle(.gray)
                } else {
                    Text(String(format: "%.2f", coin.price_change_percentage_24h ?? 0.0) + "%").fontWeight(.semibold).foregroundStyle(.red)
                }
            }
        }.padding(.vertical,3)
    }
}

#Preview {
    HomeView()
}
