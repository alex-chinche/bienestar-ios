
import Foundation
import UIKit

class App {
    var appIcon: UIImage
    var appName: String
    var appUsedTime: String
    var appId: Int
    
    init(appId: Int, appIcon: UIImage, appName: String, appUsedTime: String) {
        self.appIcon = appIcon
        self.appName = appName
        self.appUsedTime = appUsedTime
        self.appId = appId
    }
}
