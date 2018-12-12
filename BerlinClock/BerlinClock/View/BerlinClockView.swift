import Foundation

protocol BerlinClockView {
    func showBerlinTime(time: Berlin)
    func showDigitalTime(time: String)
    func showErrorMessage(message: String )
}
