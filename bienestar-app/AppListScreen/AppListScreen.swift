import UIKit
import Alamofire


var app: App?
var namesArray: [String] = []
var iconArray: [String] = []

class AppListScreen: UIViewController {
    
    
    
    @IBOutlet weak var welcomeMessage: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var tableElements: [App] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        welcomeMessage.text = "Bienvenid@, \n\(userName)"
        tableElements = createArray()
        
        tableView.delegate = self
        tableView.dataSource = self
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
                let appGot: App = App( appIcon: urlToImage, appName: app["name"] as! String,  appUsedTime: "03:20:34")
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



