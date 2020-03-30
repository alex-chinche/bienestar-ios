

import UIKit

class AppListCell: UITableViewCell {

    @IBOutlet weak var CellImageView: UIImageView!
    @IBOutlet weak var CellAppName: UILabel!
    
    func setApp(app: App) {
        CellImageView.image = app.appIcon
        CellAppName.text = app.appName
    }
}
