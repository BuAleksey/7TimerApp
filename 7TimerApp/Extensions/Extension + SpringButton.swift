//
//  Extension + Button.swift
//  7TimerApp
//
//  Created by Buba on 12.11.2022.
//

import SpringAnimation

extension SpringButton {
    func setAnimation() {
        self.animation = "morph"
        self.curve = "easeIn"
        self.duration = 0.5
        
        self.animate()
    }
}
