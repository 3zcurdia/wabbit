//
//  GraphViewCell.swift
//  Wabbit
//
//  Created by Luis Ezcurdia on 1/2/18.
//  Copyright © 2018 Luis Ezcurdia. All rights reserved.
//

import UIKit
import Charts

class GraphViewCell: UICollectionViewCell {
    var reportGroup: ReportGroup? {
        didSet {
            updateGraph()
        }
    }
    let graph: HorizontalBarChartView = {
        let chart = HorizontalBarChartView(frame: .zero)
        chart.leftAxis.enabled = false
        chart.xAxis.enabled = false
        chart.translatesAutoresizingMaskIntoConstraints = false
        return chart
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayout() {
        addSubview(graph)
        NSLayoutConstraint.activate([
            graph.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            graph.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            graph.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            graph.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
            ])
    }

    private func updateGraph() {
        guard let report = reportGroup else { return }

        let valueObjC = BarChartDataEntry(x: Double(1), y: Double(report.objcReport.baselineComparison()))
        let valueSwift = BarChartDataEntry(x: Double(0), y: Double(report.swiftReport.baselineComparison()))

        let charEntriesObjC: [BarChartDataEntry] = [valueObjC]
        let charEntriesSwift: [BarChartDataEntry] = [valueSwift]

        let dataSetObjC = BarChartDataSet(values: charEntriesObjC, label: "Objective C")
        dataSetObjC.colors = [.yankeesBlue]
        let dataSetSwift = BarChartDataSet(values: charEntriesSwift, label: "Swift")
        dataSetSwift.colors = [.tangerine]

        let data = BarChartData(dataSets: [dataSetObjC, dataSetSwift])
        data.barWidth = 0.5
        graph.data = data
        graph.chartDescription?.text = "\(report.title) comparison"
        graph.chartDescription?.font = UIFont.boldSystemFont(ofSize: 12)
        graph.groupBars(fromX: 0, groupSpace: 0.09, barSpace: 0.01)
    }
}
