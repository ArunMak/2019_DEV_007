import XCTest
@testable import BerlinClock

class BerlinClockPresenterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testConversionWithEmptyTime(){
        let expec = expectation(description: "Time cannot be empty")
        let testBerlinClockView = MockUIEmptyTimeView(expectation: expec)
        let conversionPresenter = BerlinClockPresenter(delegate:testBerlinClockView)
        conversionPresenter.getDigitalTime(time: "", tag: 2 )
        wait(for: [expec], timeout: 3)
    }
    func testConversionWithEmptySeconds(){
        let expec = expectation(description: "seconds cannot be empty")
        let testBerlinClockView = MockUIEmptySecondsView(expectation: expec)
        let conversionPresenter = BerlinClockPresenter(delegate:testBerlinClockView)
        conversionPresenter.getBerlinTime(seconds: "",hoursLineOne: "RRRR", hoursLineTwo: "ROOO", minutesLineOne: "YYRYYRYYRYY", minutesLineTwo: "YYYY" )
        wait(for: [expec], timeout: 3)
    }
    func testConversionWithEmptyHourLineOne(){
        let expec = expectation(description: "HourLineOne cannot be empty or less than 4 elements")
        let testBerlinClockView = MockUIEmptyHourLineOneView(expectation: expec)
        let conversionPresenter = BerlinClockPresenter(delegate:testBerlinClockView)
        conversionPresenter.getBerlinTime(seconds: "Y",hoursLineOne: "", hoursLineTwo: "ROOO", minutesLineOne: "YYRYYRYYRYY", minutesLineTwo: "YYYY" )
        wait(for: [expec], timeout: 3)
    }
    func testConversionWithEmptyHourLineTwo(){
        let expec = expectation(description: "HourLineTwo cannot be empty or less than 4 elements")
        let testBerlinClockView = MockUIEmptyHourLineTwoView(expectation: expec)
        let conversionPresenter = BerlinClockPresenter(delegate:testBerlinClockView)
        conversionPresenter.getBerlinTime(seconds: "Y",hoursLineOne: "RRRR", hoursLineTwo: "RO", minutesLineOne: "YYRYYRYYRYY", minutesLineTwo: "YYYY" )
        wait(for: [expec], timeout: 3)
    }
    func testConversionWithEmptyMinLineOne(){
        let expec = expectation(description: "Min Line One cannot be empty or less than 11 elements")
        let testBerlinClockView = MockUIEmptyMinLineOneView(expectation: expec)
        let conversionPresenter = BerlinClockPresenter(delegate:testBerlinClockView)
        conversionPresenter.getBerlinTime(seconds: "Y",hoursLineOne: "RRRR", hoursLineTwo: "ROOO", minutesLineOne: "", minutesLineTwo: "YYYY" )
        wait(for: [expec], timeout: 3)
    }
    func testConversionWithEmptyMinLineTwo(){
        let expec = expectation(description: "Min Line Two cannot be empty or less than 4 elements")
        let testBerlinClockView = MockUIEmptyMinLineTwoView(expectation: expec)
        let conversionPresenter = BerlinClockPresenter(delegate:testBerlinClockView)
        conversionPresenter.getBerlinTime(seconds: "Y",hoursLineOne: "RRRR", hoursLineTwo: "ROOO", minutesLineOne: "YYRYYRYYRYY", minutesLineTwo: "" )
        wait(for: [expec], timeout: 3)
    }
    func testBerlinHourValue(){
        let expec = expectation(description: "Get Berlin Hour Value ")
        let testBerlinClockView = MockUIGetBerlinHourView(expectation: expec)
        let conversionPresenter = BerlinClockPresenter(delegate:testBerlinClockView)
        conversionPresenter.getDigitalTime(time: "20:23:04", tag: 2 )
        wait(for: [expec], timeout: 10)
    }
    func testBerlinMinLineOneValue(){
        let expec = expectation(description: "Get Berlin Line One Min Value ")
        let testBerlinClockView = MockUIGetBerlinMinView(expectation: expec)
        let conversionPresenter = BerlinClockPresenter(delegate:testBerlinClockView)
        conversionPresenter.getDigitalTime(time: "20:59:04", tag: 2 )
        wait(for: [expec], timeout: 10)
    }
    func testGetDigitalTimeValue(){
        let expec = expectation(description: "Get Digital Time Value ")
        let testBerlinClockView = MockUIGetDigitalTimeView(expectation: expec)
        let conversionPresenter = BerlinClockPresenter(delegate:testBerlinClockView)
        conversionPresenter.getBerlinTime(seconds: "Y", hoursLineOne: "RRRR", hoursLineTwo: "OOOO", minutesLineOne: "YYRYYRYYRYO", minutesLineTwo: "YYYY")
        wait(for: [expec], timeout: 10)
    }
    
}

class MockUIEmptyTimeView: BerlinClockView {
    var expec: XCTestExpectation
    init(expectation: XCTestExpectation) {
        self.expec = expectation
    }
    func showBerlinTime(time: Berlin){}
    func showDigitalTime(time: String){}
    func showErrorMessage(message: String ) {
        XCTAssertEqual(message, "Time cannot be empty")
        self.expec.fulfill()
    }
}
class MockUIEmptySecondsView: BerlinClockView {
    var expec: XCTestExpectation
    init(expectation: XCTestExpectation) {
        self.expec = expectation
    }
    func showBerlinTime(time: Berlin){}
    func showDigitalTime(time: String){}
    func showErrorMessage(message: String ) {
        XCTAssertEqual(message, "Seconds is empty or less than 1 elements")
        self.expec.fulfill()
    }
}
class MockUIEmptyHourLineOneView: BerlinClockView {
    var expec: XCTestExpectation
    init(expectation: XCTestExpectation) {
        self.expec = expectation
    }
    func showBerlinTime(time: Berlin){}
    func showDigitalTime(time: String){}
    func showErrorMessage(message: String ) {
        XCTAssertEqual(message, "HoursLineOne is empty or less than 4 elements")
        self.expec.fulfill()
    }
}
class MockUIEmptyHourLineTwoView: BerlinClockView {
    var expec: XCTestExpectation
    init(expectation: XCTestExpectation) {
        self.expec = expectation
    }
    func showBerlinTime(time: Berlin){}
    func showDigitalTime(time: String){}
    func showErrorMessage(message: String ) {
        XCTAssertEqual(message, "HoursLineTwo is empty or less than 4 elements")
        self.expec.fulfill()
    }
}
class MockUIEmptyMinLineOneView: BerlinClockView {
    var expec: XCTestExpectation
    init(expectation: XCTestExpectation) {
        self.expec = expectation
    }
    func showBerlinTime(time: Berlin){}
    func showDigitalTime(time: String){}
    func showErrorMessage(message: String ) {
        XCTAssertEqual(message, "MinutesLineOne is empty or less than 11 elements")
        self.expec.fulfill()
    }
}
class MockUIEmptyMinLineTwoView: BerlinClockView {
    var expec: XCTestExpectation
    init(expectation: XCTestExpectation) {
        self.expec = expectation
    }
    func showBerlinTime(time: Berlin){}
    func showDigitalTime(time: String){}
    func showErrorMessage(message: String ) {
        XCTAssertEqual(message, "MinutesLineTwo is empty or less than 4 elements")
        self.expec.fulfill()
    }
}
class MockUIGetBerlinHourView: BerlinClockView {
    var expec: XCTestExpectation
    init(expectation: XCTestExpectation) {
        self.expec = expectation
    }
    func showBerlinTime(time: Berlin){
        print(time)
        XCTAssertEqual(time.hoursLineOne, "RRRR")
        self.expec.fulfill()
    }
    func showDigitalTime(time: String){}
    func showErrorMessage(message: String ) {}
}

class MockUIGetBerlinMinView: BerlinClockView {
    var expec: XCTestExpectation
    init(expectation: XCTestExpectation) {
        self.expec = expectation
    }
    func showBerlinTime(time: Berlin){
        XCTAssertEqual(time.minutesLineOne, "YYRYYRYYRYY")
        self.expec.fulfill()
    }
    func showDigitalTime(time: String){}
    func showErrorMessage(message: String ) {}
}


class MockUIGetDigitalTimeView: BerlinClockView {
    var expec: XCTestExpectation
    init(expectation: XCTestExpectation) {
        self.expec = expectation
    }
    func showBerlinTime(time: Berlin){}
    func showDigitalTime(time: String){
        XCTAssertEqual(String(time.prefix(5)), "20:54")
        self.expec.fulfill()
    }
    func showErrorMessage(message: String ) {}
}



