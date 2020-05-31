
import Foundation
import ArgumentParser

struct Transparency: ParsableCommand {
    
    struct RGBColor {
        let red: Int
        let green: Int
        let blue: Int
    }
    
    @Option(name: .shortAndLong,
            help: ArgumentHelp("The original color in format R:G:B. Range of components 0...255.", valueName: "r:g:b"))
    var color: RGBColor
    
    @Option(name: .shortAndLong,
            default: 1.0,
            help: ArgumentHelp("Desired opacity for the original color. Range 0.0...1.0.", valueName: "o"))
    var opacity: Double
    
    @Option(name: .shortAndLong,
            default: .white,
            help: ArgumentHelp("The background color in format R:G:B. Range of components 0...255.", valueName: "r:g:b"))
    var background: RGBColor
    
    func run() {
        let target = targetColor(from: color, opacity: opacity, background: background)
        print("Target color is \(target.red):\(target.green):\(target.blue)")
    }
    
    func targetColor(from original: RGBColor, opacity: Double, background: RGBColor) -> RGBColor {
        let cappedOpacity = min(max(opacity, 0.0), 1.0)
        
        // target = opacity * original + (1 - opacity) * background
        let targetRed = Int(cappedOpacity * Double(original.red) + (1 - cappedOpacity) * Double(background.red))
        let targetGreen = Int(cappedOpacity * Double(original.green) + (1 - cappedOpacity) * Double(background.green))
        let targetBlue = Int(cappedOpacity * Double(original.blue) + (1 - cappedOpacity) * Double(background.blue))
        
        return RGBColor(red: targetRed,
                        green: targetGreen,
                        blue: targetBlue)
    }
}

extension Transparency.RGBColor: ExpressibleByArgument {
    init?(argument: String) {
        let trimmedArgument = argument.trimmingCharacters(in: .whitespaces)
        let arguments = trimmedArgument.split(separator: ":")
        
        guard arguments.count == 3 else { return nil }
        guard let red = Int(arguments[0]), let green = Int(arguments[1]), let blue = Int(arguments[2]) else { return nil }
        
        self.init(red: min(max(red, 0), 255),
                  green: min(max(green, 0), 255),
                  blue: min(max(blue, 0), 255))
    }
    
    static let white = Transparency.RGBColor(red: 255, green: 255, blue: 255)
    static let black = Transparency.RGBColor(red: 0, green: 0, blue: 0)
}

Transparency.main()
