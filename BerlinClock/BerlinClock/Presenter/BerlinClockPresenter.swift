import Foundation

class BerlinClockPresenter {
    var delegate: BerlinClockView
    init(delegate: BerlinClockView) {
        self.delegate = delegate
    }
    // MARK: Get BerlinTime from Digital Input
    func getDigitalTime(time: String, tag: Int ) {
        if time.isEmpty {
            delegate.showErrorMessage(message: "Time cannot be empty")
        }else{
            let timeArray:[Int] = time.split(separator: ":").flatMap{ Int($0) }
            let berlinObj = Berlin( seconds: getSeconds(seconds: timeArray[2]), hoursLineOne: getHoursAndMinLineOne(hours: timeArray[0],value: "R",lampsCount: 4), hoursLineTwo: getHoursAndMinLineTwo(hours: timeArray[0],value: "R"), minutesLineOne: getHoursAndMinLineOne(hours: timeArray[1],value: "Y",lampsCount: 11), minutesLineTwo: getHoursAndMinLineTwo(hours: timeArray[1],value: "Y"), tagValue: tag)
            delegate.showBerlinTime(time: berlinObj)
        }
    }
    //get seconds output in berlin format
    func getSeconds(seconds: Int) -> String {
        if (seconds % 2 == 0) {
            return "Y";
        }else{
            return "O";
        }
    }
    //get hours line ouput in berlin format
    func getHoursAndMinLineOne(hours: Int, value: String, lampsCount: Int) -> String {
        let rest = hours / 5;
        if  lampsCount == 11 {
            return getCharacterSequence(number: rest, lamps: lampsCount, symbol: value);
        }else{
            return getCharacterSequence(number: rest, lamps: lampsCount, symbol: value).replacingOccurrences(of: "YYY", with: "YYR" );
        }
    }
    func getHoursAndMinLineTwo(hours: Int, value: String) -> String {
        let rest = hours % 5;
        return getCharacterSequence(number: rest, lamps: 4, symbol: value);
    }
    fileprivate func getCharacterSequence(number: Int, lamps: Int, symbol: String) -> String {
        var out = "" ;
        /* For the first of number of lamps create the String with the appropriate symbol*/
        for _ in 0..<number{
            out += symbol;
        }
        /* For the rest of lamps create the String with the appropriate symbol*/
        for _ in 0..<(lamps - number){
            out += "O";
        }
        return out;
    }
    // MARK: Get Digital Output from Berlin input
    func getBerlinTime(seconds: String,hoursLineOne: String, hoursLineTwo: String, minutesLineOne: String, minutesLineTwo: String ){
        if ( evaluateHoursAndMin(value: hoursLineOne, name: "HoursLineOne", limit: 4) &&  evaluateHoursAndMin(value: hoursLineTwo, name: "HoursLineTwo", limit: 4) && evaluateminuteLineOne(value:  minutesLineOne ) && evaluateHoursAndMin(value: minutesLineTwo, name: "MinutesLineTwo", limit: 4 )  &&  evaluateEmptyField(fieldText: seconds, fieldLimit: 1, fieldName: "Seconds") ){
            delegate.showDigitalTime(time: String(format: "%02d:%02d:%02d", convertBerlinHourAndMinute(hour: hoursLineOne, character: "R", count: 5) + convertBerlinHourAndMinute(hour: hoursLineTwo,character: "R", count: 1 )  , convertBerlinMinuteLineOne(minutes: minutesLineOne) + convertBerlinHourAndMinute(hour: hoursLineTwo,character: "Y", count: 1) , convertBerlinSeconds(seconds: seconds)))
            
        }
    }
    func evaluateEmptyField(fieldText: String , fieldLimit: Int , fieldName: String ) -> Bool {
        if fieldText.isEmpty || fieldText.count < fieldLimit {
            delegate.showErrorMessage(message: "\(fieldName) is empty or less than \(fieldLimit) elements")
            return false
        }
        return true
    }
    //Evaluate if the hours format input is valid
    func evaluateHoursAndMin(value: String, name: String , limit: Int) -> Bool {
        if (evaluateEmptyField(fieldText: value, fieldLimit: limit, fieldName: name )){
            var isOn:Bool = true
            for char in value.lowercased() {
                if ( char == "o"){
                    isOn = false
                }else{
                    if (!isOn){
                        delegate.showErrorMessage(message: "Invalid input in \(name) field" )
                        return isOn
                    }
                }
            }
        }
        return true
    }
    //Evaluate if minutes input is valid or not
    func evaluateminuteLineOne(value: String ) -> Bool {
        if (evaluateEmptyField(fieldText: value, fieldLimit: 11, fieldName: "MinutesLineOne" )){
            var isOn:Bool = true
            var seqCount = 0
            for char in value.lowercased() {
                seqCount += 1
                if (char == "o"){
                    isOn = false
                }else if (seqCount % 3 == 0){
                    if (char != "r" ){
                        isOn = false
                        delegate.showErrorMessage(message:"Every 3rd Character in sequence should be R or O and not Y" )
                        return isOn
                    }
                }else{
                    if (char == "r" ){
                        isOn = false
                        delegate.showErrorMessage(message:"R should come only in Multiple of 3rd sequence " )
                        return isOn
                    }
                }
                if (char == "y" || char == "r"){
                    if(!isOn){
                        delegate.showErrorMessage(message: "Wrong input in minutes Line one ")
                        return isOn
                    }
                }
            }
        }
        return true
    }
    func convertBerlinSeconds(seconds: String) -> Int {
        //generating random number as we cant get the exact seconds in digital format through berlin input .Only exact minutes and hours can be found through berlin input
        let randomNumber: Int = Int(arc4random_uniform(60))
        if (seconds.uppercased() == "O") {
            if randomNumber % 2 == 0 {
                return randomNumber + 1
            }else{
                return randomNumber
            }
        }else{
            if randomNumber % 2 == 0 {
                return randomNumber
            }else{
                return randomNumber + 1
            }
        }
    }
    //Convert berlin input to digital hour
    func convertBerlinHourAndMinute(hour: String, character: Character, count: Int) -> Int {
        var hours = 0
        for char in hour.uppercased() {
            if (char == character){
                hours += 5
            }
        }
        return hours
    }
    //Convert berlin input to digital minutes
    func convertBerlinMinuteLineOne(minutes: String ) -> Int {
        var minute = 0
        for char in minutes.uppercased() {
            if (char == "Y" || char == "R"){
                minute += 5
            }
        }
        return minute
    }
}

