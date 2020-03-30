import UIKit
import MapKit
import Alamofire
import CoreLocation


class MapScreen: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
let postLocationsUrl = "http://localhost:8888/bienestar-app/public/index.php/api/postLocations"
let getLocationsUrl = "http://localhost:8888/bienestar-app/public/index.php/api/getLocations"
var id = app?.appId

@IBOutlet weak var appName: UILabel!
@IBOutlet weak var map: MKMapView!
override func viewDidLoad() {

UserDefaults.standard.set(JSONtoken!["token"], forKey: "token")

let file = "usage.csv"
let directory = FileManager.default.urls(for:
.documentDirectory, in: .userDomainMask)
let ruta = directory.first?.appendingPathComponent(file)
let params = ["file": ruta!]
let token = ["token": UserDefaults.standard.value(forKey: "token")]
let postLocations = Alamofire.request(self.postLocationsUrl, method: .post, parameters: params as Parameters, headers: token as? HTTPHeaders)
.responseJSON
{
response in
switch (response.response?.statusCode)
{
//POST LOCATIONS
case 200:
do {
print("locations uploaded succesfully")
}

case 401:
do {
print("not possible to post locations")
}
default: print("not possible to post locations")
}
}
let getLocations = Alamofire.request(self.getLocationsUrl, method: .get, headers: token as? HTTPHeaders)
.responseJSON
{
response in
switch (response.response?.statusCode)
{
//GET LOCATIONS
case 200:
do {
print("locations got succesfully")
print(response.result.value!)
let apps = response.result.value as! [[String:Any]]
let appOpenLatitude = apps[self.id! - 1]["open_latitude"]
let appOpenLongitude = apps[self.id! - 1]["open_longitude"]
let appCloseLatitude = apps[self.id! - 1]["close_latitude"]
let appCloseLongitude = apps[self.id! - 1]["close_longitude"]


//PRIMERA CHINCHETA
let openedApp = MKPointAnnotation()
openedApp.coordinate = CLLocationCoordinate2D(latitude: appOpenLatitude as! CLLocationDegrees, longitude: appOpenLongitude as! CLLocationDegrees)
openedApp.title = app?.appName
openedApp.subtitle = "Abierta aqui"
    
self.map.addAnnotation(openedApp)

//SEGUNDA CHINCHETA
let closedApp = MKPointAnnotation()
closedApp.coordinate = CLLocationCoordinate2D(latitude: appCloseLatitude as! CLLocationDegrees, longitude: appCloseLongitude as! CLLocationDegrees)
closedApp.title = app?.appName
closedApp.subtitle = "Cerrada aqui"

self.map.addAnnotation(closedApp)
}

case 401:
do {
print("not possible to get locations")
}
default: print("not possible to get locations")
}
super.viewDidLoad()
self.appName.text = app?.appName


}
}
}

