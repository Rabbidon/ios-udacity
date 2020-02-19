import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController, MKMapViewDelegate
{
 
    let dataController = AppDelegate.dataController
    
    func addPin(coordinates c:CLLocationCoordinate2D){
        let pin = Pin(context: dataController.viewContext)
        pin.latitude = c.latitude
        pin.longitude = c.longitude
        do{
            try dataController.viewContext.save()
        }
        catch{
            print("Failure to Save")
        }
        print(pins.count)
        pins.append(pin)
        print(pins.count)
        map.addAnnotation(pin)
    }
    
    override func viewDidLoad()
    {
      super.viewDidLoad()
      let hold = UILongPressGestureRecognizer(target: self, action: #selector(self.handlePress(_:)))
      view.addGestureRecognizer(hold)
      view.isUserInteractionEnabled = true
      map.delegate = self
        
    let dataController = AppDelegate.dataController
    let fetchRequest:NSFetchRequest<Pin> =
    Pin.fetchRequest()
    do{
        let result = try dataController.viewContext.fetch(fetchRequest)
            pins = result
    }
    catch{
        print("Failed to Load")
    }
    map.addAnnotations(pins)
    }
    
    @IBOutlet weak var map: MKMapView!
    
    // Not a necessary feature - just wanted to get rid of the 100 or so pins that I had dunked onto the map
    @IBAction func wipePins(_ sender: Any) {
        for pin in pins
        {
            map.removeAnnotation(pin)
            dataController.viewContext.delete(pin)
        }
        do{
            try dataController.viewContext.save()
        }
        catch{
            print("Failure to Save")
        }
        pins = [Pin]()
    }
    
    var pins = [Pin]()
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = MKPinAnnotationView()
        guard let annotation = annotation as? Pin else {return nil}
        let identifier = "Pin"

        if let dequedView = mapView.dequeueReusableAnnotationView(
            withIdentifier: identifier)
            as? MKPinAnnotationView {
            annotationView = dequedView
        } else{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        performSegue(withIdentifier: "presentAlbum", sender: view.annotation)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender s:Any?){
        (segue.destination as! AlbumViewController).pin = (s as! Pin)
        
    }
  
     @objc func handlePress(_ sender: UILongPressGestureRecognizer) {
        if (sender.state == UIGestureRecognizer.State.began){
            let location = sender.location(in: map)
            let coordinates = map!.convert(location, toCoordinateFrom: map)
            addPin(coordinates: coordinates)
          }
        
     }
}
