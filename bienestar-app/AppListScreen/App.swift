
import Foundation
import UIKit

class App {
    var appIcon: UIImage
    var appName: String
    var appId: Int
    
    init(appId: Int, appIcon: UIImage, appName: String) {
        self.appIcon = appIcon
        self.appName = appName
        self.appId = appId
    }
}
