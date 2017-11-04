//
//  ReportGroup.swift
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/4/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import Foundation

typealias VoidFuncClosure = (()->Void)

struct ReportGroup {
    let title : String
    let objcReport : Report
    let swiftReport : Report
    
    static func build(_ titleName: String, objcMethod: @escaping VoidFuncClosure, swiftMethod: @escaping VoidFuncClosure) -> ReportGroup {
        var oReport = Benchmark.sharedSession.run("\(titleName) [ObjC]", block: objcMethod)
        var sReport = Benchmark.sharedSession.run("\(titleName) [Swift]", block: swiftMethod)
        let baseline = [oReport, sReport].baselineTime()
        oReport.baseline = baseline
        sReport.baseline = baseline
        return ReportGroup(title: titleName, objcReport: oReport, swiftReport: sReport)
    }
}
