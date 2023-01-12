//
//  Double.swift
//  Crypto
//
//  Created by Kim Insub on 2023/01/12.
//

import Foundation

extension Double {

    /// Converts a Double -> Dollar with 2 decimal places
    /// ```
    /// 1234.56 -> $1,234.56
    /// 12.3456 -> $12.3456
    /// 0.123456 -> $0.123456
    /// ```
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
//        formatter.locale = .current
//        formatter.currencyCode = "usd"
//        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }

    /// Converts a Double -> Dollar with 2-6 decimal places
    /// ```
    /// 1234.56 -> "$1,234.56"
    /// 12.3456 -> "$12.3456"
    /// 0.123456 -> "$0.123456"
    /// ```
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }

    /// Converts a Double -> string representation with 2 decimal places
    /// ```
    /// 1234.56 -> "1.23"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }

    /// Converts a Double -> string representation with places and % sign
    /// ```
    /// 1234.56 -> "1.23%"
    /// ```
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
}
