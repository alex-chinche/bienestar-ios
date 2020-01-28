
import UIKit
import Alamofire

var userName = ""
var userEmail = ""

class LoginScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 150, y: self.view.frame.size.height/1.35, width: 300, height: 35))
        toastLabel.textColor = UIColor.red
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: toastLabel.font.fontName, size: 20)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 1.5, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    @IBOutlet weak var UserOutlet: UITextField!
    @IBOutlet weak var EmailOutlet: UITextField!
    @IBOutlet weak var PasswordOutlet: UITextField!
    @IBAction func PostUser(_ sender: Any) {
        userName = UserOutlet.text!
        if (userName != "" && PasswordOutlet.text != "" && EmailOutlet.text != "") {
            //Goes to the next activity
            self.performSegue(withIdentifier: "appListScreen", sender: nil)
        }
        else {
            //Shows toast when the user is not logged
            self.showToast(message: "Incorrect fields!")
        }
    }
    @IBAction func forgotPass(_ sender: Any) {
        userEmail = EmailOutlet.text!
        if (userEmail == "") {
            self.showToast(message: "Incorrect Email")
        }
        /*else {
           POST NEW PASSWORD
        }
        */
    }
}

