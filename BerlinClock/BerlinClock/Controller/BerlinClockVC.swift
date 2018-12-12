import UIKit
class BerlinClockVC: UIViewController {
    @IBOutlet weak var secondsTextField: BerlinClockCustomTextField!
    @IBOutlet weak var hourLineTwoTextField: BerlinClockCustomTextField!
    @IBOutlet weak var minuteLineOneTextField: BerlinClockCustomTextField!
    @IBOutlet weak var hourLineOneTextField: BerlinClockCustomTextField!
    @IBOutlet weak var minuteLineTwoTextField: BerlinClockCustomTextField!
    @IBOutlet weak var digitalTextField: BerlinClockCustomTextField!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var berlinClockView: UIView!
    @IBOutlet weak var digitalView: UIView!
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet var selectOptionButton: [UIButton]!
    @IBOutlet var selectBerlinOptionButton: [UIButton]!
    
    // MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        convertButton.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: Convert Option selected action.
    //Used to display from berlin to digital or digital to berlin view based on selection
    @IBAction func changeConverterButtonAction(_ sender: UIButton) {
        if sender.tag == 2 {
            convertButton.isHidden = true
            digitalView.isHidden = false
            berlinClockView.isHidden = true
            
        }else{
            convertButton.isHidden = false
            digitalView.isHidden = true
            berlinClockView.isHidden = false
            
        }
    }
    //Used to select the option to display ouput from digital to berlin format in different options  like seconds in berlin ,or full berlin time
    @IBAction func convertDigitalToBerlin(_ sender: UIButton) {
    }
   
    // MARK: Convert button action
    //Convert to berlin time through digital time input
    @IBAction func convertButtonAction(_ sender: Any) {
        
    }
}

