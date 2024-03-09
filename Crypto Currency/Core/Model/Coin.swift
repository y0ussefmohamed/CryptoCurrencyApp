import Foundation


struct Coin : Codable , Identifiable
{
    let id: String
    let symbol: String
    let name: String
    let image: String
    let current_price: Double
    let price_change_percentage_24h: Double?
    let market_cap_rank: Int
}


struct TrendingCoinResult: Codable
{
    let coins: [CoinItem]
}

struct CoinItem: Codable
{
    let item: TrendingCoin
}

struct TrendingCoin: Codable , Identifiable
{
    let id: String
    let symbol: String
    let name: String
    let thumb: String
    let data: [TrendingCoinItemData]
}

struct TrendingCoinItemData: Codable
{
    let price: String
    let price_change_percentage_24h: PriceChangePercentage24h
}

struct PriceChangePercentage24h: Codable {
    let usd: Double
    
}
