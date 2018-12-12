import Foundation

class BerlinClockPresenter {
    var delegate: BerlinClockView
    init(delegate: BerlinClockView) {
        self.delegate = delegate
    }
  // MARK: Get BerlinTime from Digital Input
    func getDigitalTime(time: String, tag: Int ) {
        if time.isEmpty {
            self.delegate.showErrorMessage(message: "Time cannot be empty")
        }else{
            let timeArray:[Int] = time.split(separator: ":").flatMap{ Int($0) }
            let berlinObj = Berlin( seconds: getSeconds(seconds: timeArray[2]), hoursLineOne: getHoursLineOne(hours: timeArray[0]), hoursLineTwo: getHoursLineTwo(hours: timeArray[0]), minutesLineOne: getMinutesLineOne(minutes: timeArray[1]), minutesLineTwo: getMinutesLineTwo(minutes: timeArray[1]), tagValue: tag)
            self.delegate.showBerlinTime(time: berlinObj)
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
    func getHoursLineOne(hours: Int) -> String {
        let rest = hours / 5;
        return getCharacterSequence(number: rest, lamps: 4, symbol: "R");
    }
    func getHoursLineTwo(hours: Int) -> String {
        let rest = hours % 5;
        return getCharacterSequence(number: rest, lamps: 4, symbol: "R");
    }
    
    //get minutes line output in berlin format
    func getMinutesLineOne(minutes: Int) -> String {
        let rest = minutes / 5;
        /*Replace all "YYY" char sequence with "YYR"*/
        return getCharacterSequence(number: rest, lamps: 11, symbol: "Y").replacingOccurrences(of: "YYY", with: "YYR" );
    }
    func getMinutesLineTwo(minutes: Int) -> String {
        let rest = minutes % 5;
        return getCharacterSequence(number: rest, lamps: 4, symbol: "Y" );
    }
    
    func getCharacterSequence(number: Int, lamps: Int, symbol: String) -> String {
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
        
        if seconds.isEmpty {
            self.delegate.showErrorMessage(message: "Seconds field is empty")
            return
        }
        if hoursLineOne.isEmpty || hoursLineOne.count < 4 {
            self.delegate.showErrorMessage(message: "Hour Line One Field is empty or has less than 4 elements")
            return
        }
        if hoursLineTwo.isEmpty || hoursLineTwo.count < 4 {
            self.delegate.showErrorMessage(message: "Hour Line Two Field is empty or has less than 4 elements")
            return
        }
        if minutesLineOne.isEmpty || minutesLineOne.count < 11 {
            self.delegate.showErrorMessage(message: "Minutes Line One is empty or has less than 11 elements")
            return
        }
        if minutesLineTwo.isEmpty || minutesLineTwo.count < 4 {
            self.delegate.showErrorMessage(message: "Minutes Line Two is empty or has less than 4 elements")
            return
        }
        
        if (  evaluateHours(value: hoursLineOne, row: 1) &&  evaluateHours(value: hoursLineTwo, row: 2) && evaluateminuteRowOne(value:  minutesLineOne ) && evaluateMinuteSecondRow(value: minutesLineTwo )  ){
            
            self.delegate.showDigitalTime(time: String(format: "%02d:%02d:%02d", convertBerlinHourLineOne(hour: hoursLineOne) + convertBerlinHourLineTwo(hour: hoursLineTwo)  , convertBerlinMinuteLineOne(minutes: minutesLineOne) + convertBerlinMinuteLineTwo(minutes: minutesLineTwo) , convertBerlinSeconds(seconds: seconds)))
            
        }
        
        
        
        
        
    }
    
    //Evaluate if the hours format input is valid
    func evaluateHours(value: String, row: Int ) -> Bool {
        var isOn:Bool = true
        for char in value.lowercased() {
            if ( char == "o"){
                isOn = false
            }else{
                if (!isOn){
                    self.delegate.showErrorMessage(message: "Wrong hour row \(row) input" )
                    return isOn
                }
            }
            
        }
        return true
    }
    
    //Evaluate if minutes input is valid or not
    func evaluateminuteRowOne(value: String ) -> Bool {
        var isOn:Bool = true
        var seqCount = 0
        for char in value.lowercased() {
            seqCount += 1
            if (char == "o"){
                isOn = false
            }else if (seqCount % 3 == 0){
                
                if (char != "r" ){
                    isOn = false
                    self.delegate.showErrorMessage(message:"Every 3rd Character in sequence should be R or O and not Y" )
                    return isOn
                }
            }else{
                if (char == "r" ){
                    isOn = false
                    self.delegate.showErrorMessage(message:"R should come only in Multiple of 3rd sequence " )
                    return isOn
                }
                
            }
            if (char == "y" || char == "r"){
                if(!isOn){
                    self.delegate.showErrorMessage(message: "Wrong input in minutes row one ")
                    return isOn
                }
            }
            
            
            
        }
        
        return true
    }
    
    func evaluateMinuteSecondRow(value: String ) -> Bool {
        var isOn:Bool = true
        for char in value.lowercased(){
            if ( char == "o"){
                isOn = false
            }else{
                if (!isOn){
                    self.delegate.showErrorMessage(message: "Wrong input in minutes row two" )
                    return isOn
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
    func convertBerlinHourLineOne(hour: String) -> Int {
        var hours = 0
        for char in hour.uppercased() {
            if (char == "R"){
                hours += 5
            }
        }
        
        return hours
    }
    
    func convertBerlinHourLineTwo(hour: String) -> Int {
        var hours  = 0
        for char in hour.uppercased() {
            if(char == "R"){
                hours += 1
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
    func convertBerlinMinuteLineTwo(minutes : String ) -> Int {
        var minute = 0
        for char in minutes.uppercased() {
            if (char == "Y"){
                minute += 1
            }
        }
        return minute
    }
    
    
    
    
    
    
    
    
  
}
