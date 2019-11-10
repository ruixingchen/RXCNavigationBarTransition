//
//  RNBSetting.swift
//  RXCNavigationBarTransition
//
//  Created by ruixingchen on 11/7/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import Foundation

public enum RNBSetting<T>: CustomStringConvertible {

    case setted(T)
    case notset

    public init(_ value:T) {
        self = RNBSetting.setted(value)
    }

    public var setted:Bool {
        switch self {
        case .setted(_): return true
        default: return false
        }
    }

    public var value:T? {
        switch self {
        case .setted(let o): return o
        default: return nil
        }
    }

    public var description: String {
        switch self {
        case .notset: return "notset"
        case .setted(let value):
            return "setted: \(value)"
        }
    }

}
