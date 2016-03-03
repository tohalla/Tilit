//
//  AccountNumberHelper.swift
//  tilit
//
//  Created by Touko Hallasmaa on 03.03.16.
//  Copyright © 2016 Touko Hallasmaa. All rights reserved.
//
// https://en.wikipedia.org/wiki/International_Bank_Account_Number

import Foundation

struct AccountNumberHelper {
    static var countrySettings = [
        "AD": CountrySettings("AD", 24),
        "AE": CountrySettings("AE", 23),
        "AL": CountrySettings("AL", 28),
        "AO": CountrySettings("AO", 25),
        "AT": CountrySettings("AT", 20),
        "AZ": CountrySettings("AZ", 28),
        "BA": CountrySettings("BA", 20),
        "BE": CountrySettings("BE", 16),
        "BF": CountrySettings("BF", 27),
        "BG": CountrySettings("BG", 22),
        "BH": CountrySettings("BH", 22),
        "BI": CountrySettings("BI", 16),
        "BJ": CountrySettings("BJ", 28),
        "BR": CountrySettings("BR", 29),
        "CH": CountrySettings("CH", 21),
        "CI": CountrySettings("CI", 28),
        "CM": CountrySettings("CM", 27),
        "CR": CountrySettings("CR", 21),
        "CV": CountrySettings("CV", 25),
        "CY": CountrySettings("CY", 28),
        "CZ": CountrySettings("CZ", 24),
        "DE": CountrySettings("DE", 22),
        "DK": CountrySettings("DK", 18),
        "DO": CountrySettings("DO", 28),
        "DZ": CountrySettings("DZ", 24),
        "EE": CountrySettings("EE", 20),
        "ES": CountrySettings("ES", 24),
        "FI": CountrySettings("FI", 18),
        "FO": CountrySettings("FO", 18),
        "FR": CountrySettings("FR", 27),
        "GB": CountrySettings("GB", 22),
        "GE": CountrySettings("GE", 22),
        "GI": CountrySettings("GI", 23),
        "GL": CountrySettings("GL", 18),
        "GR": CountrySettings("GR", 27),
        "GT": CountrySettings("GT", 28),
        "HR": CountrySettings("HR", 21),
        "HU": CountrySettings("HU", 28),
        "IE": CountrySettings("IE", 22),
        "IL": CountrySettings("IL", 23),
        "IR": CountrySettings("IR", 26),
        "IS": CountrySettings("IS", 26),
        "IT": CountrySettings("IT", 27),
        "JO": CountrySettings("JO", 30),
        "KW": CountrySettings("KW", 30),
        "KZ": CountrySettings("KZ", 20),
        "LB": CountrySettings("LB", 28),
        "LC": CountrySettings("LC", 32),
        "LI": CountrySettings("LI", 21),
        "LT": CountrySettings("LT", 20),
        "LU": CountrySettings("LU", 20),
        "LV": CountrySettings("LV", 21),
        "MC": CountrySettings("MC", 27),
        "MD": CountrySettings("MD", 24),
        "ME": CountrySettings("ME", 22),
        "MG": CountrySettings("MG", 27),
        "MK": CountrySettings("MK", 19),
        "ML": CountrySettings("ML", 28),
        "MR": CountrySettings("MR", 27),
        "MT": CountrySettings("MT", 31),
        "MU": CountrySettings("MU", 30),
        "MZ": CountrySettings("MZ", 25),
        "NL": CountrySettings("NL", 18),
        "NO": CountrySettings("NO", 15),
        "PK": CountrySettings("PK", 24),
        "PL": CountrySettings("PL", 28),
        "PS": CountrySettings("PS", 29),
        "PT": CountrySettings("PT", 25),
        "QA": CountrySettings("QA", 29),
        "RO": CountrySettings("RO", 24),
        "RS": CountrySettings("RS", 22),
        "SA": CountrySettings("SA", 24),
        "SE": CountrySettings("SE", 24),
        "SI": CountrySettings("SI", 19),
        "SK": CountrySettings("SK", 24),
        "SM": CountrySettings("SM", 27),
        "SN": CountrySettings("SN", 28),
        "ST": CountrySettings("ST", 25),
        "TL": CountrySettings("TL", 23),
        "TN": CountrySettings("TN", 24),
        "TR": CountrySettings("TR", 26),
        "UA": CountrySettings("UA", 29),
        "VG": CountrySettings("VG", 24),
        "XK": CountrySettings("XK", 20)
    ]

    static func isBankNumberValid(bankNumber: String?) -> Bool {
        if (bankNumber == nil || bankNumber!.characters.count < 2) {
           return false
        }
        var bankNumber = bankNumber!.uppercaseString.stringByReplacingOccurrencesOfString(" ", withString: "")
        let settings = countrySettings[bankNumber.substringToIndex(advance(bankNumber.startIndex, 2))]
        if (settings == nil || settings!.length != bankNumber.characters.count as Int) {
            return false
        }
        // move last 4 chars to the end of the string
        bankNumber = bankNumber.substringFromIndex(advance(bankNumber.startIndex, 4)) + bankNumber.substringToIndex(advance(bankNumber.startIndex, 4))
        print(bankNumber)
        // create numeric string for ascii values of the chars
        var numericString = ""
        for char in [Character](bankNumber.characters) {
            //if character, add as ascii value
            let asciiVal = getNumericValue(char)
            if (asciiVal < 10) {
                numericString.append(char)
            } else {
                numericString += String(asciiVal)
            }
        }
        return (mod97(numericString) == 1)
    }
    // when checking iban A = 10 ... Z = 35
    private static func getNumericValue(char: Character) -> Int
    {
        return Int(String(char).unicodeScalars.first!.value) - 55
    }
    
    // requires separate function due to lack of bigint in swift
    private static func mod97(numericString: String) -> Int64 {
        var numericString = numericString
        while (numericString.characters.count > 2) {
            let len = min(19, numericString.characters.count)
            let part = (numericString.substringToIndex(advance(numericString.startIndex, len)) as NSString).longLongValue
            numericString = String(part % 97) + numericString.substringFromIndex(advance(numericString.startIndex, len))
        }

        let mod = (numericString as NSString).longLongValue % 97
        return mod
    }

    struct CountrySettings {
        let code: String
        let length: Int

        private init(_ code: String, _ length: Int) {
            self.code = code
            self.length = length
        }
    }
}
