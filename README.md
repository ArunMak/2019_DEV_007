# 2019_DEV_007

## Berlin Clock

The Berlin Clock (Mengenlehreclock or Berlin Uhr) is a clock that tells the time using a series of illuminated coloured blocks, as you can see in the picture for this project.
The top lamp blinks to show seconds- it is illuminated on even seconds and off on odd seconds.
The next two rows represent hours. The upper row represents 5 hour blocks and is made up of 4 red lamps. The lower row represents 1 hour blocks and is also made up of 4 red lamps.
The final two rows represent the minutes. The upper row represents 5 minute blocks, and is made up of 11 lamps- every third lamp is red, the rest are yellow. The bottom row represents 1 minute blocks, and is made up of 4 yellow lamps.

## Support
Architecture: MVP (Model-View-Presenter) + Data Services
Xcode 9.2
Support iOS 10+
Swift 4


## ABOUT MVP
In MVP(Model-View -Presenter), the presenter assumes the functionality of the "middle-man". In MVP, all presentation logic is pushed to the presente

The model is an interface defining the data to be displayed or otherwise acted upon in the user interface.
The view is a passive interface that displays data (the model) and routes user commands (events) to the presenter to act upon that data.
The presenter acts upon the model and the view. It retrieves data from repositories (the model), and formats it for display in the view

## The Code
This Project is built with Xcode version 9.2 and Swift 4.0 and with a deployment target of 10.0

Presenter :
Protocol as a bridge to connect 2 classes (presenter and ViewController)
protocol BerlinClockView {
func showBerlinTime(time: Berlin)
func showDigitalTime(time: String)
func showErrorMessage(message: String )
}

Use extentions to manage protocol implementations :
extension BerlinClockVC: BerlinClockView {
// MARK: Conversion View Delegate Methods
func showBerlinTime(time: Berlin) {}
}
func showDigitalTime(time: String) {
self.outputLabel.text = time
}
func showErrorMessage(message: String) {
BerlinClockUtils.showAlert(message: message, vc: self)
}
}

