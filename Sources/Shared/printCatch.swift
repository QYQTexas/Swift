//
//  Shared/printCatch.swift
//  QYQTexasPlaygroundPackage
//
//  Created by QYQTexas on 2025/9/20.
//

public func printCatch(of err: Error, say message: String? = nil){
    print("\(type(of: err)): \(err)")
    guard let message = message else{
        return
    }
    print("{\n \(message) \n}")
}
