//
//  Extension + SpringImageView.swift
//  7TimerApp
//
//  Created by Buba on 12.11.2022.
//

import SpringAnimation

extension SpringImageView {
    func setAnimation() {
        self.animation = "shake"
        self.curve = "easeIn"

        self.duration = 0.5
        
        self.animate()
    }
}
