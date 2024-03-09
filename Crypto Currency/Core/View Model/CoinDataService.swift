import Foundation


class CoinDataService
{
    func fetchCoins(completion: @escaping (Result<[Coin],Error>) -> Void) {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=1&sparkline=false&price_change_percentage=1h&locale=en")
        else {
            print("DEBUG: Error Getting URL")
            return
        }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if let e = error {
                print("DEBUG: Error Making a Task")
                completion(.failure(e))
            }
            else {
                if let fetchedData = data {
                    do {
                        let decodedCoinData = try JSONDecoder().decode([Coin].self, from: fetchedData)
                        completion(.success(decodedCoinData))
                    }
                    catch {
                        print("DEBUG: Error Decoding Data")
                        completion(.failure(error))
                    }
                    
                } else {
                    print("DEBUG: Error Fetching Data")
                    completion(.failure(error!))
                }
            }
        }
        task.resume()
    }
    
//    func fetchTrendingCoins(completion: @escaping (Result<[TrendingCoin], Error>) -> Void) {
//        guard let url = URL(string: "https://api.coingecko.com/api/v3/search/trending") else {
//            print("DEBUG: Error Getting URL")
//            return
//        }
//        
//        let session = URLSession(configuration: .default)
//        
//        let task = session.dataTask(with: url) { data, response, error in
//            if let e = error {
//                print("DEBUG: Error Making a Task")
//                completion(.failure(e))
//                return
//            }
//            
//            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
//                print("DEBUG: HTTP Response Error")
//                return
//            }
//            
//            if let fetchedData = data {
//                do {
//                    let decodedTrendingCoinData = try JSONDecoder().decode([TrendingCoin].self, from: fetchedData)
//                    print(decodedTrendingCoinData)
//                    completion(.success(decodedTrendingCoinData))
//                } catch {
//                    print("DEBUG: Error Decoding Data")
//                    completion(.failure(error))
//                }
//            } else {
//                print("DEBUG: Error Fetching Data")
//                completion(.failure(error ?? NSError(domain: "", code: 0, userInfo: nil)))
//            }
//        }
//        task.resume()
//    }

}

