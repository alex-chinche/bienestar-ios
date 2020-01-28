import UIKit
import Alamofire

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
        
        let cell1 = App(appIcon: #imageLiteral(resourceName: "memphis copia"), appName: "Whatsapp", appUsedTime: "03:20:34")
        let cell2 = App(appIcon: #imageLiteral(resourceName: "Boston copia"), appName: "Youtube", appUsedTime: "01:25:34")
        let cell3 = App(appIcon: #imageLiteral(resourceName: "raptors copia"), appName: "Reloj", appUsedTime: "03:30:54")
        let cell4 = App(appIcon: #imageLiteral(resourceName: "raptors copia"), appName: "Reloj", appUsedTime: "03:30:54")
        let cell5 = App(appIcon: #imageLiteral(resourceName: "raptors copia"), appName: "Reloj", appUsedTime: "03:30:54")
        let cell6 = App(appIcon: #imageLiteral(resourceName: "raptors copia"), appName: "Reloj", appUsedTime: "03:30:54")
        let cell7 = App(appIcon: #imageLiteral(resourceName: "raptors copia"), appName: "Reloj", appUsedTime: "03:30:54")
        let cell8 = App(appIcon: #imageLiteral(resourceName: "raptors copia"), appName: "Reloj", appUsedTime: "03:30:54")
        let cell9 = App(appIcon: #imageLiteral(resourceName: "raptors copia"), appName: "Reloj", appUsedTime: "03:30:54")
        
        cellsList.append(cell1)
        cellsList.append(cell2)
        cellsList.append(cell3)
        cellsList.append(cell4)
        cellsList.append(cell5)
        cellsList.append(cell6)
        cellsList.append(cell7)
        cellsList.append(cell8)
        cellsList.append(cell9)
        
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
    }


