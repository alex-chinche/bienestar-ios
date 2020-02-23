import UIKit
import Alamofire


var app: App?
var namesArray: [String] = []
var iconArray: [String] = []

class AppListScreen: UIViewController {
    
    let postUsageUrl = "http://localhost:8888/bienestar-app/public/index.php/api/postUseTimes"
    let getUsageUrl = "http://localhost:8888/bienestar-app/public/index.php/api/getUseTimes"
    
    
    @IBOutlet weak var welcomeMessage: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var tableElements: [App] = []
    
    override func viewDidLoad() {
        UserDefaults.standard.set(JSONtoken!["token"], forKey: "token")
        //UserDefaults.standard.value(forKey: "token")
        let file = "usage.csv"
        let directory = FileManager.default.urls(for:
            .documentDirectory, in: .userDomainMask)
        let ruta = directory.first?.appendingPathComponent(file)
        let params = ["file": ruta!]
        let token = ["token": UserDefaults.standard.value(forKey: "token")]
        let usagesPosted = Alamofire.request(self.postUsageUrl, method: .post, parameters: params as Parameters, headers: token as? HTTPHeaders)
                .responseJSON
                {
                    response in
                    switch (response.response?.statusCode)
                    {
                        //POST USAGES
                            case 200:
                                do {
                                    print("usages uploaded succesfully")
                            }
                        
                            case 401:
                                do {
                                print("not possible to post usages")
                            }
                    default: break
            }
        }
        
        super.viewDidLoad()
        
        welcomeMessage.text = "Bienvenid@, \n\(userName)"
        tableElements = createArray()
        
        tableView.delegate = self as UITableViewDelegate
        tableView.dataSource = self as UITableViewDataSource
    }
    
    func createArray() -> [App] {
        
        var cellsList: [App] = []
        
        //METER EL GET CON LAS APLICACIONES
       
        for app in appDataArray {
            let icon = app["icon"]
            let stringToUrl = URL(string: icon as! String)!
            do {
               let data = try Data(contentsOf: stringToUrl)
               let urlToImage = UIImage(data: data)!
                let appGot: App = App( appId: app["id"] as! Int, appIcon: urlToImage, appName: app["name"] as! String,  appUsedTime: "03:20:34")
                cellsList.append(appGot)
            }
            catch{
                print("Image not found")
            }
        }
        
        return cellsList
    }
}
extension AppListScreen: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableElements.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let app = tableElements[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppListCell") as! AppListCell
        
        cell.setApp(app: app)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        app = tableElements[indexPath.row]
        performSegue(withIdentifier: "appDetailScreen", sender: nil)
    }
}



