//
//  ClickableCalloutAnnotationView.swift
//  On_The_Map
//
//  Created by Shailaja on 30/01/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import MapKit

protocol ClickableCalloutAnnotationViewDelegate: class {
    func didTapCallout(for annotation: MKAnnotation)
}

class ClickableCalloutAnnotationView: MKPinAnnotationView {
    
    static let preferredReuseIdentifier = Bundle.main.bundleIdentifier! + ".customAnnotationView"

    weak var delegate: ClickableCalloutAnnotationViewDelegate?

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        canShowCallout = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapAnnotationView(_:)))
        self.addGestureRecognizer(tap)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func didTapAnnotationView(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self)

        if bounds.contains(location) { return }

        delegate?.didTapCallout(for: annotation!)
    }
}
