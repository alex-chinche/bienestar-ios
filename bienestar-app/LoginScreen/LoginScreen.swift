
import UIKit
import Alamofire

var stringToken: String?
var userName = ""
var userEmail = ""
var userPassword = ""
var errorFromJson = ""
var JSONtoken:Dictionary<String, String>?
var JSONtoString:Dictionary<String, String>?
var appDataArray: [[String: Any]] = []

class LoginScreen: UIViewController {
    
    let createUserUrl = "http://localhost:8888/bienestar-app/public/index.php/api/createUser"
    let loginUserUrl = "http://localhost:8888/bienestar-app/public/index.php/api/loginUser"
    let rememberPasswordUrl = "http://localhost:8888/bienestar-app/public/index.php/api/rememberPassword"
    let postAppsUrl = "http://localhost:8888/bienestar-app/public/index.php/api/showApps"
    let getAppsUrl = "http://localhost:8888/bienestar-app/public/index.php/api/getApps"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var homeDir = NSHomeDirectory()
        print(homeDir)
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
        UIView.animate(withDuration: 2, delay: 0.1, options: .curveEaseOut, animations: {
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
        userPassword = PasswordOutlet.text!
        userEmail = EmailOutlet.text!
        let userParams: Parameters = [
            "name": userName,
            "email": userEmail,
            "password": userPassword
        ]
        if (userName != "" && userEmail != "" && userPassword != "") {
            //POST USER
            Alamofire.request(createUserUrl, method: .post, parameters: userParams)
                .responseJSON
                {
                    response in
                    switch (response.response?.statusCode)
                    {
                    case 200:
                        //POST APPS
                        JSONtoken = response.result.value as? [String:String]
                        UserDefaults.standard.set(JSONtoken!["token"], forKey: "token")
                        //UserDefaults.standard.value(forKey: "token")
                        let file = "usage.csv"
                        let directory = FileManager.default.urls(for:
                            .documentDirectory, in: .userDomainMask)
                        let ruta = directory.first?.appendingPathComponent(file)
                        let params = ["file": ruta!]
                        let token = ["token": UserDefaults.standard.value(forKey: "token")]
                        let appsPosted = Alamofire.request(self.postAppsUrl, method: .post, parameters: params as Parameters, headers: token as? HTTPHeaders)
                        
                        appsPosted.responseJSON
                            {
                                response in
                                switch (response.response?.statusCode)
                                {
                                case 200:
                                    let getApps = Alamofire.request(self.getAppsUrl, method: .get, headers: token as? HTTPHeaders)
                                    
                                    getApps.responseJSON
                                        {
                                            response in
                                            switch (response.response?.statusCode)
                                            {
                                            case 200:
                                                appDataArray = (response.result.value as? [[String: Any]])!
                                                self.performSegue(withIdentifier: "appListScreen", sender: nil)
                                                
                                            default: print("Error getting apps data")
                                            }
                                    }
                                    
                                default: print("Error uploading apps")
                                }
                        }
                        
                        print(response)
                        
                    case 401:
                        JSONtoString = response.result.value as? [String:String]
                        UserDefaults.standard.set(JSONtoString!["message"], forKey: "message")
                        self.showToast(message: UserDefaults.standard.value(forKey: "message") as! String)
                    default: break
                    }
            }
        }
        else {
            //Shows toast when the user is not logged
            self.showToast(message: "Empty fields!")
        }
    }
    @IBAction func loginUser(_ sender: Any) {
        userPassword = PasswordOutlet.text!
        userEmail = EmailOutlet.text!
        let params: Parameters = [
            "email": userEmail,
            "password": userPassword
        ]
        if (userEmail != "" && userPassword != "") {
            //POST USER
            Alamofire.request(loginUserUrl, method: .post, parameters: params)
                .responseJSON
                {
                    response in
                    switch (response.response?.statusCode)
                    {
                        //POST APPS
                    case 200:
                        JSONtoken = response.result.value as? [String:String]
                        UserDefaults.standard.set(JSONtoken!["token"], forKey: "token")
                        //UserDefaults.standard.value(forKey: "token")
                        let file = "usage.csv"
                        let directory = FileManager.default.urls(for:
                            .documentDirectory, in: .userDomainMask)
                        let ruta = directory.first?.appendingPathComponent(file)
                        let params = ["file": ruta!]
                        let token = ["token": UserDefaults.standard.value(forKey: "token")]
                        let appsPosted = Alamofire.request(self.postAppsUrl, method: .post, parameters: params as Parameters, headers: token as? HTTPHeaders)
                        
                        appsPosted.responseJSON
                            {
                                response in
                                switch (response.response?.statusCode)
                                {
                                case 200:
                                    let getApps = Alamofire.request(self.getAppsUrl, method: .get, headers: token as? HTTPHeaders)
                                    
                                    getApps.responseJSON
                                        {
                                            response in
                                            switch (response.response?.statusCode)
                                            {
                                            case 200:
                                                appDataArray = (response.result.value as? [[String: Any]])!
                                                self.performSegue(withIdentifier: "appListScreen", sender: nil)
                                                
                                            default: print("Error getting apps data")
                                            }
                                    }
                                    
                                default: print("Error uploading apps")
                                }
                        }
                        
                        print(response)
                        
                    case 401:
                        JSONtoString = response.result.value as? [String:String]
                        UserDefaults.standard.set(JSONtoString!["message"], forKey: "message")
                        self.showToast(message: UserDefaults.standard.value(forKey: "message") as! String)
                    default: break
                    }
            }
        }
        else {
            //Shows toast when the user is not logged
            self.showToast(message: "Empty fields!")
        }
    }
    
    @IBAction func forgotPass(_ sender: Any) {
        userEmail = EmailOutlet.text!
        let params: Parameters = [
            "email": userEmail,
        ]
        if (userEmail != "") {
            //Remember password
            Alamofire.request(rememberPasswordUrl, method: .post, parameters: params)
                .responseJSON
                {
                    response in
                    switch (response.response?.statusCode)
                    {
                    default: print(response)
                    JSONtoken = response.result.value as? [String:String]
                    UserDefaults.standard.set(JSONtoken!["message"], forKey: "message")
                    self.showToast(message: UserDefaults.standard.value(forKey: "message") as! String)
                    }
            }
        }
        else {
            //Shows toast when the user is not logged
            self.showToast(message: "Empty fields!")
        }
    }
}

