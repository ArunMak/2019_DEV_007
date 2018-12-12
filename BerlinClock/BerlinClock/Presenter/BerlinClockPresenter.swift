import Foundation

class BerlinClockPresenter {
    var delegate: BerlinClockView
    init(delegate: BerlinClockView) {
        self.delegate = delegate
    }
  // MARK: Get BerlinTime from Digital Input
    func getDigitalTime(time: String, tag: Int ) {
       
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
    
  
}
