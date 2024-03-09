import Foundation

class CoinViewModel: ObservableObject {
    @Published var coins = [Coin]()
    @Published var topMoversCoins = [Coin]()
    private let service = CoinDataService()
    
    init() {
        fetchCoins()
//        fetchTrendingCoins()
    }
    
    func fetchCoins() {
        service.fetchCoins { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let coinsFetchedFromService):
                    self?.coins = coinsFetchedFromService
                    self?.configureTopMovingCoins()
                }
            }
        }
    }
    
//    func fetchTrendingCoins() {
//        service.fetchTrendingCoins { [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .failure(let error):
//                    print(error)
//                case .success(let trendingCoinsFetchedFromService): // Update variable name
//                    self?.trendingCoins = [trendingCoinsFetchedFromService.coins[0].item]// Assign to trendingCoins property
//                }
//            }
//        }
//    }
    
    func configureTopMovingCoins() {
        let topMovers = coins.sorted(by:{ $0.price_change_percentage_24h! > $1.price_change_percentage_24h!})
        self.topMoversCoins = Array(topMovers.prefix(10))
    }
}
