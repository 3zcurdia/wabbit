//
//  ReportViewCell.swift
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/3/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit

class ReportViewCell: UICollectionViewCell {
    var reportGroup: ReportGroup? {
        didSet {
            updateViews()
        }
    }
    private let titleLabel: UILabel = {
        let tv = UILabel()
        tv.text = "Report Group"
        tv.textColor = .white
        tv.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        tv.backgroundColor = .black
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    private let objcReportView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .platinum
        tv.isSelectable = false
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    private let swiftReportView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .platinum
        tv.isSelectable = false
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayout() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        addSubview(objcReportView)
        NSLayoutConstraint.activate([
            objcReportView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            objcReportView.leadingAnchor.constraint(equalTo: leadingAnchor),
            objcReportView.bottomAnchor.constraint(equalTo: bottomAnchor),
            objcReportView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
            ])
        addSubview(swiftReportView)
        NSLayoutConstraint.activate([
            swiftReportView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            swiftReportView.leadingAnchor.constraint(equalTo: objcReportView.trailingAnchor, constant: 1.5),
            swiftReportView.trailingAnchor.constraint(equalTo: trailingAnchor),
            swiftReportView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }

    private func updateViews() {
        guard let report = reportGroup else { return }
        titleLabel.text = report.title
        objcReportView.attributedText = extractFormattedText(report: report.objcReport)
        swiftReportView.attributedText = extractFormattedText(report: report.swiftReport)
    }

    private func extractFormattedText(report: Report) -> NSAttributedString {
        let elapsed = (report.time*1000).rounded(toDigits: 10)
        let ips = report.ips()
        let comparison = report.baselineComparison().rounded(toDigits: 2)
        let elapsedAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]
        let attributedText = NSMutableAttributedString(string: "\(elapsed) [ms]", attributes: elapsedAttributes)

        let ipsAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]
        attributedText.append(NSAttributedString(string: "\n\(ips) [ips]", attributes: ipsAttributes))

        let comparisonAttributs = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14, weight: .bold)]
        attributedText.append(NSAttributedString(string: "\n\(comparison)x", attributes: comparisonAttributs))
        return attributedText
    }
}
