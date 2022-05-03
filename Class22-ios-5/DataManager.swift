import Foundation


protocol CallBack_Weather {
    func didUpdateWeather(model: WeatherModel)
}

class DataManager {
    
    var delegate: CallBack_Weather?
    
    func fetchFromServer(url: String, delegate: CallBack_Weather) {
        self.delegate = delegate
        performRequest(fullUrl: url)
    }
    
    
    func performRequest(fullUrl: String) {
        if let url: URL = URL(string: fullUrl) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, urlResponse, error) in
                if error != nil {
                    print("error:\(error)")
                    return
                }
                
                if let safeData = data {
                    let dataString = String(data: safeData, encoding: .utf8)
                    print("dataString:\(dataString!)")
                    self.parseJSON(data: safeData)
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(data: Data) {
        var decoder = JSONDecoder()
        
        do {
            var model = try decoder.decode(WeatherModel.self, from: data)
            print("Temp: \(model.main?.temp)")
            
            DispatchQueue.main.sync {
                self.delegate?.didUpdateWeather(model: model)
            }
            
        } catch {
            print("Error: \(error)")
        }
    }
    
}
