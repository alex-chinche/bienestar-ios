import UIKit

class StatsScreen: UIViewController {
    @IBOutlet weak var appName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        appName.text = app?.appName
    }
}
