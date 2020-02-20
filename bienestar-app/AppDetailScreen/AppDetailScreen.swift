import UIKit

class AppDetailScreen: UIViewController {
    
    @IBOutlet weak var appDetailName: UILabel!
    @IBOutlet weak var appDetailIcon: UIImageView!
    @IBOutlet weak var appDetailTotalTime: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        appDetailName.text = app?.appName
        appDetailIcon.image = app?.appIcon
        
        //METER TAB BAR CONTROLLER PARA NAVEGACION ENTRE VISTAS
        
    }
    
}
