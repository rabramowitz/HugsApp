//
//  Parser.swift
//  HUGS
//
//  Created by Becky Abramowitz on 3/19/18.
//  Copyright © 2018 HUGS. All rights reserved.
//

public func parseCurrValueString(_ str: String) {
    print(str);
    var h_index : Int!;
    var n_index : Int!;
    var t_index : Int!;
    var a_index : Int!;
    var i_index : Int!;
    for (index, char) in str.enumerated() {
        if (char == "h" && h_index == nil) { h_index = index; }
        if (char == "n" && n_index == nil) { n_index = index; }
        if (char == "t" && t_index == nil) { t_index = index; }
        if (char == "a" && a_index == nil) { a_index = index; }
        if (char == "i" && i_index == nil) { i_index = index; }

    }
    if (h_index != nil && n_index != nil && n_index > h_index) {
        let tempHR = str.substring(with:h_index+1..<n_index);
        setHR(Int(tempHR)!);
    }
    if (n_index != nil && t_index != nil && t_index > n_index) {
        let tempNoise = str.substring(with:n_index+1..<t_index);
        setNoise(Double(tempNoise)!);
    }
    if (t_index != nil && a_index != nil && a_index > t_index) {
        let tempTemp = str.substring(with:t_index+1..<a_index);
        setTemp(Int(tempTemp)!);
    }
    if (a_index != nil && i_index != nil && i_index > a_index) {
        let tempAccel = str.substring(with: a_index+1..<i_index);
        setAccel(Double(tempAccel)!);
    }
    if (i_index != nil && i_index + 1 < str.count) {
        setActivationStatus(str.substring(with: i_index+1..<i_index+2) == "1");
    }
}

public func createThresholdString(_ threshold:Threshold) -> String {
    var s : String = ""
    if (threshold == heartRateThreshold) { s += "h"; }
    if (threshold == noiseThreshold) { s += "n"; }
    if (threshold == tempThreshold) { s += "t"; }
    if (threshold == accelThreshold) { s += "a"; }
    if (threshold == lightThreshold) { s += "l"; }
    s += ",";
    s += String(threshold.isOn ? 1 : 0);
    if (threshold.lowerBound != nil) {
        s += "," + String(format: "%.2f", threshold.lowerBound);
    }
    if (threshold.upperBound != nil) {
        s += "," + String(format: "%.2f", threshold.upperBound);
    }
    s+="\n";
//    print(s);
    return s;
}

public func createSettingsString() -> String {
    var s : String = "s,";
    s += String(inProactiveMode ? 1 : 0);
    s += ",";
    s += String(getActivationStatus() ? 1 : 0);
    s += ",";
    s += String(userVars.userWeight);
    s+="\n";
    return s;
}
