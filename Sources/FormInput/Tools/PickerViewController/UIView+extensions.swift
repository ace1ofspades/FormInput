//
//  File.swift
//  
//
//  Created by Yusuf Tekin on 23.09.2023.
//

import UIKit

extension UIView {
    func addBlur(_ style: UIBlurEffect.Style = .regular) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(blurEffectView, at: 0)
    }

    var activityIndicator: UIActivityIndicatorView {
        if let view = subviews.first(where: { $0.tag == 1023 }) as? UIActivityIndicatorView {
            bringSubviewToFront(view)
            return view
        }
        let view = UIActivityIndicatorView(frame: bounds)
        view.backgroundColor = UIColor(white: 0.6, alpha: 0.4)
        view.tag = 1023
        view.style = .large
        view.stopAnimating()
        addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        view.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true

        return view
    }

    var activityIndicatorWithoutBlur: UIActivityIndicatorView {
        if let view = subviews.first(where: { $0.tag == 1023 }) as? UIActivityIndicatorView {
            bringSubviewToFront(view)
            return view
        }
        let view = UIActivityIndicatorView(frame: bounds)
        view.addBlur(.systemMaterialLight)
        view.tag = 1023
        view.style = .large
        view.stopAnimating()
        addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        view.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true

        return view
    }

    func stopLoader() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in
            activityIndicator.stopAnimating()
        }
    }

    func startLoader() {
        activityIndicator.startAnimating()
    }
}

