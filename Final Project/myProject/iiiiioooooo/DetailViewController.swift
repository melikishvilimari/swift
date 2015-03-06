import UIKit
import MapKit

class DetailViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblMinute: UILabel!

    var detail: MainTable?

    func configureView() {
        var name: String = detail!.name
        var desc: String = detail!.desc
        var imageURL: String = detail!.image
        
        if let lat = detail?.lat {
            if let lot = detail?.lng {
                self.addPoint((lat as NSString).doubleValue, longitude: (lot as NSString).doubleValue, title: name, subtitle: desc, imageName: "imageName")
            }
        }
        
        self.lblName.text = name
        self.lblDescription.text = desc
        self.lblCategory.text = detail!.category
        self.lblMinute.text = "\(detail!.minute) min"
        image.image = UIImage(named: imageURL)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.mapType = MKMapType.Standard
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func addPoint(latitude: Double, longitude: Double, title: String, subtitle: String, imageName: String) {
        var lat:CLLocationDegrees = latitude
        var lng:CLLocationDegrees = longitude
        var span:MKCoordinateSpan = MKCoordinateSpanMake(lat, lng)
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(0.2, 0.2)
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        mapView.setRegion(region, animated: true)
        
        var annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = title
        mapView.addAnnotation(annotation)
    }

}

