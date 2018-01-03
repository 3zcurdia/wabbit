//
//  LoaderView.swift
//  Wabbit
//
//  Created by Luis Ezcurdia on 12/27/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit

class LoaderView: UIView {
    lazy var pulseLayer: CAShapeLayer = {
        let shape = self.buildCircleShape(fillColor: UIColor.platinum.opaque(by: 0.2), strokeColor: .clear)
        return shape
    }()
    lazy var trackLayer: CAShapeLayer = {
        let shape = self.buildCircleShape(fillColor: .yankeesBlue, strokeColor: .platinum)
        return shape
    }()
    lazy var shapeLayer: CAShapeLayer = {
        let shape = self.buildCircleShape(fillColor: .clear, strokeColor: .tangerine)
        shape.strokeEnd = 0
        shape.transform = CATransform3DMakeRotation(-CGFloat.pi/2.0, 0, 0, 1)
        return shape
    }()
    var shapeCenter: CGPoint? {
        didSet {
            guard let shapeCenter = self.shapeCenter else { return }
            shapeLayer.position = shapeCenter
            trackLayer.position = shapeCenter
            pulseLayer.position = shapeCenter
        }
    }
    var progress: CGFloat? {
        didSet {
            guard let unrappedProgress = self.progress else { return }
            DispatchQueue.main.async { [weak self] in
                self?.shapeLayer.strokeEnd = unrappedProgress
            }
        }
    }
    private let logoView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "wabbit")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private func buildCircleShape(fillColor: UIColor, strokeColor: UIColor) -> CAShapeLayer {
        let shape = CAShapeLayer()
        let circle = UIBezierPath(arcCenter: .zero, radius: 130, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        shape.path = circle.cgPath
        shape.fillColor = fillColor.cgColor
        shape.strokeColor = strokeColor.cgColor
        shape.lineWidth = 15
        shape.lineCap = kCALineCapRound
        return shape
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSublayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSublayout() {
        self.backgroundColor = .yankeesBlue
        self.layer.addSublayer(pulseLayer)
        self.layer.addSublayer(trackLayer)
        self.layer.addSublayer(shapeLayer)
        animatePuslatingLayer()
        self.addSubview(logoView)
        NSLayoutConstraint.activate([
            logoView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            logoView.widthAnchor.constraint(equalToConstant: 200),
            logoView.heightAnchor.constraint(equalToConstant: 200)
            ])
    }

    func animatePuslatingLayer() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.3
        animation.duration = 1
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        pulseLayer.add(animation, forKey: "pulsating.cirlce")
    }
}
