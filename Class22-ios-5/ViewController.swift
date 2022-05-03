import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dff: UITextField!
    @IBOutlet weak var main_LBL_temp: UILabel!

    let API_KEY = "9bba3a14c05c8e8f4a1c4f5234b48ea0"
    let URL_PREFIX = "https://api.openweathermap.org/data/2.5/weather?q=london&units=metric&appid="

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dff.delegate = self
    }
    
    @IBAction func fetchClicked(_ sender: Any) {
        let completetUrl = "\(URL_PREFIX)\(API_KEY)"

        var dataManager: DataManager = DataManager()
        dataManager.fetchFromServer(url: completetUrl, delegate: self)
    }
    
    
    
}

extension ViewController: CallBack_Weather {
    
    func didUpdateWeather(model: WeatherModel) {
        main_LBL_temp.text = "NA"
        if let d = model.main?.temp {
            main_LBL_temp.text = "\(d)°C"
        }
    }
    
    
}

extension ViewController: UITextFieldDelegate {
    
}
