//
//  BooleanSettingView.swift
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/2/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit

class BooleanSettingView: UIView {
    private let container : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "Option"
        lbl.font = UIFont.systemFont(ofSize: 32, weight: .black)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let selector: UISwitch = {
        let sw = UISwitch()
        sw.setOn(true, animated: false)
        sw.backgroundColor = .clear
        sw.tintColor = UIColor.platinum
        sw.thumbTintColor = UIColor.yankeesBlue
        sw.onTintColor = UIColor.tangerine
        sw.translatesAutoresizingMaskIntoConstraints = false
        return sw
    }()
    
    convenience init(title:String){
        self.init(frame: .zero)
        titleLabel.text = title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(){
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7)
            ])
        addSubview(container)
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3)
            ])
        container.addSubview(selector)
        NSLayoutConstraint.activate([
            selector.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            selector.centerYAnchor.constraint(equalTo: container.centerYAnchor)
            ])
    }
}
