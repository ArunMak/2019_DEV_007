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
    
    // MARK: Instance variable
    private var datePicker : UIDatePicker!
    private var presenter: BerlinClockPresenter?

   
    // MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = BerlinClockPresenter(delegate: self)
        convertButton.isHidden = true
        addPicker()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Add Picker
    fileprivate func addPicker(){
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker.backgroundColor = UIColor.white
        self.datePicker.datePickerMode = UIDatePickerMode.time
        self.datePicker.locale = Locale(identifier: "en_GB")
        digitalTextField.inputView = self.datePicker
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        digitalTextField.inputAccessoryView = toolBar
    }
    @objc func doneClick () {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .long
        dateFormatter.dateFormat = "HH:mm:ss"
        digitalTextField.text = dateFormatter.string(from: datePicker.date)
        digitalTextField.resignFirstResponder()
    }
    @objc func cancelClick() {
        digitalTextField.resignFirstResponder()
    }
    
    // MARK: Convert Option selected action.
    //Used to display from berlin to digital or digital to berlin view based on selection
    @IBAction func changeConverterButtonAction(_ sender: UIButton) {
        clearField()
        for button in selectOptionButton {
            if button.tag == sender.tag{
                button.backgroundColor = UIColor(red: 68, green: 143, blue: 103)
            } else{
                button.backgroundColor = UIColor(red: 175, green: 44, blue: 37)
            }
        }
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
    func clearField(){
        secondsTextField.text = ""
        minuteLineOneTextField.text = ""
        minuteLineTwoTextField.text = ""
        hourLineOneTextField.text = ""
        hourLineTwoTextField.text = ""
        digitalTextField.text = ""
    }
    //Used to select the option to display ouput from digital to berlin format in different options  like seconds in berlin ,or full berlin time
    @IBAction func convertDigitalToBerlin(_ sender: UIButton) {
        for button in selectBerlinOptionButton {
            if button.tag == sender.tag {
                button.backgroundColor = UIColor(red: 68, green: 143, blue: 103)
            }else{
                button.backgroundColor = UIColor(red: 175, green: 44, blue: 37)
            }
        }
         self.presenter?.getDigitalTime(time: digitalTextField.text!, tag: sender.tag)
    }
   
    // MARK: Convert button action
    //Convert to berlin time through digital time input
    @IBAction func convertButtonAction(_ sender: Any) {
        self.presenter?.getBerlinTime(seconds: secondsTextField.text!, hoursLineOne: hourLineOneTextField.text!, hoursLineTwo: hourLineTwoTextField.text!, minutesLineOne: minuteLineOneTextField.text!, minutesLineTwo: minuteLineTwoTextField.text!)
    }
}
extension BerlinClockVC: BerlinClockView {
    // MARK: Conversion View Delegate Methods
    func showBerlinTime(time: Berlin) {
        let berlinObj: Berlin =  time
        self.outputLabel.text = " "
        switch berlinObj.tagValue {
        case 4:
            self.outputLabel.text = " \(berlinObj.seconds) "
        case 5:
            self.outputLabel.text = " \(berlinObj.hoursLineOne)"
        case 6:
            self.outputLabel.text = " \(berlinObj.hoursLineTwo)"
        case 7:
            self.outputLabel.text = " \(berlinObj.minutesLineOne)"
        case 8:
            self.outputLabel.text = " \(berlinObj.minutesLineTwo) "
        case 9:
            self.outputLabel.text = " \(berlinObj.seconds)\(berlinObj.hoursLineOne)\(berlinObj.hoursLineTwo)\(berlinObj.minutesLineOne)\(berlinObj.minutesLineTwo)"
        default:
            self.outputLabel.text = " \(berlinObj.seconds)\(berlinObj.hoursLineOne)\(berlinObj.hoursLineTwo)\(berlinObj.minutesLineOne)\(berlinObj.minutesLineTwo)"
        }
    }
    func showDigitalTime(time: String) {
        self.outputLabel.text = time
    }
    func showErrorMessage(message: String) {
        BerlinClockUtils.showAlert(message: message, vc: self)
    }
}


