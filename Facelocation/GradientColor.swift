import Foundation
import UIKit

class GradientColor {
    let colorTop = UIColor(red: 145.0 / 255.0, green: 174.0 / 255.0, blue: 251.0 / 255.0, alpha: 1.0).cgColor
    let colorBottom = UIColor(red: 137.0 / 255.0, green: 208.0 / 255.0, blue: 251.0 / 255.0, alpha: 1.0).cgColor
    
    var gl:CAGradientLayer!
    
    init() {
        gl = CAGradientLayer()
        gl.colors = [colorTop, colorBottom]
        gl.locations = [0.0, 1.0]
    }
}
