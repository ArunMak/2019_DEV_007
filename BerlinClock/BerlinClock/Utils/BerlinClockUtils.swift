import UIKit

class BerlinClockUtils {
    //Display alert view
    static func showAlert(message:String, vc: UIViewController ) {
        let alert = UIAlertController(title: "Alert", message: message,    preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        vc.present(alert, animated: true, completion: nil)
    }
}


