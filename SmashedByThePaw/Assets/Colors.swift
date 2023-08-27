//
//  Colors.swift
//  SmashedByThePaw
//
//  Created by Laslo on 27.08.2023.
//

import SwiftUI

extension Color {
    struct custom {
        static var white: Color {
            Color.white.opacity(0.6)
        }
        
        static var yellow: Color {
            Color("yellow")
        }
        
        static var lightGreen: Color {
            Color("lightGreen")
        }
        
        static var midGreen: Color {
            Color("midGreen")
        }
        
        static var darkGreen: Color {
            Color("darkGreen")
        }
    }
}
