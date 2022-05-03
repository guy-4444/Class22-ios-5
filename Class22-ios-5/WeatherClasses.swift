import Foundation


class WeatherModel: Decodable {
    var main: Main?
}

class Main: Decodable {
    var temp: Double?
}
