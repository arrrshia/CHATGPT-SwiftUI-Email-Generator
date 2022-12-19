//
//  Extensions.swift
//  CGPT
//
//  Created by Andrew Almasi on 12/13/22.
//

import Foundation
import SwiftUI
extension String {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
extension UIColor {

    var bgColor: UIColor {
        //choose your custom rgb values
        return UIColor(red: 0.17, green: 0.18, blue: 0.26, alpha: 1.00)
    }
    
    var textColor: UIColor {
        return UIColor(red: 0.55, green: 0.60, blue: 0.68, alpha: 1.00)
    }
    
    var tColor: UIColor {
        return UIColor(red: 0.93, green: 0.95, blue: 0.96, alpha: 1.00)
    }

}

extension View {
    func textEditorBackground<V>(@ViewBuilder _ content: () -> V) -> some View where V : View {
        self
            .onAppear {
                UITextView.appearance().backgroundColor = .clear
            }
            .background(content())
    }
}
