import UIKit
import Alamofire

class AppDetailScreen: UIViewController {
    
    @IBOutlet weak var appDetailName: UILabel!
    @IBOutlet weak var appDetailIcon: UIImageView!
    @IBOutlet weak var appDetailTotalTime: UILabel!
    @IBOutlet weak var appId: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var averageTime: UILabel!
    var id = app?.appId
    let getTotalUsagesUrl = "http://localhost:8888/bienestar-app/public/index.php/api/getTotalUsagesPerApp"
    let getAverageUsagesUrl = "http://localhost:8888/bienestar-app/public/index.php/api/getAverageTimePerApp"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        appDetailName.text = app?.appName
        appDetailIcon.image = app?.appIcon
        appId.text = "Id: \(id!)"
        
        let token = ["token": UserDefaults.standard.value(forKey: "token")]
        let totalUsagesGot = Alamofire.request(self.getTotalUsagesUrl, method: .get, headers: token as? HTTPHeaders)
                .responseJSON
                {
                    response in
                    switch (response.response?.statusCode)
                    {
                        //GET USAGES
                            case 200:
                                do {
                            print("usages got succesfully")
                                    print(response.result.value!)
                                    let apps = response.result.value as! [[String:Any]]
                                    let totalTime = apps[self.id! - 1]["total_time"]
                                    print(totalTime!)
                                    self.totalTime.text = totalTime as? String
                            }
                        
                            case 401:
                                do {
                                print("not possible to get usages")
                                  
                            }
                    default: print("not possible to get usages")
            }
        }
        let averageUsagesGot = Alamofire.request(self.getAverageUsagesUrl, method: .get, headers: token as? HTTPHeaders)
            .responseJSON
            {
                response in
                switch (response.response?.statusCode)
                {
                    //GET USAGES
                        case 200:
                            do {
                        print("usages got succesfully")
                                print(response.result.value!)
                                let apps = response.result.value as! [[String:Any]]
                                let averageTime = apps[self.id! - 1]["average_time"]
                                print(averageTime!)
                                self.averageTime.text = averageTime as? String
                        }
                    
                        case 401:
                            do {
                            print("not possible to get usages")
                                print(response)
                        }
                default: print("not possible to get usages")
        }
        }
    }
    
}
