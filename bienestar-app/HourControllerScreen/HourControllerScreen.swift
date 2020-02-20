import UIKit

class HourControllerScreen: UIViewController {
    @IBOutlet weak var appName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        appName.text = app?.appName
    }
    @IBAction func setTimeButton(_ sender: Any) {
    }
}
