//
//  ParticleView.swift
//  MARS
//
//  Created by Mac on 2/26/19.
//  Copyright © 2019 kubapolakowski. All rights reserved.
//

import UIKit

class ParticleView: UIView {
    var image: UIImage?
    var color: CGColor?
    
    override class var layerClass: AnyClass {
        return CAEmitterLayer.self
    }
    
    func makeEmitterCell(velocity: CGFloat, scale: CGFloat, direction: CGFloat, directionRange: CGFloat, amount: Float) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = amount
        cell.lifetime = 20.0
        cell.lifetimeRange = 0
        cell.color = color
        cell.velocity = velocity
        cell.velocityRange = velocity / 4
        cell.emissionLongitude = direction
        cell.emissionRange = directionRange
        cell.scale = scale
        cell.scaleRange = scale / 4
        
        cell.contents = image?.cgImage
        return cell
    }
    
    func addEmitterCells(for weather: Weather) {
        let emitterLayer = layer as! CAEmitterLayer
        
        emitterLayer.emitterShape = .line
        emitterLayer.emitterPosition = CGPoint(x: bounds.midX, y: 0)
        emitterLayer.emitterSize = CGSize(width: 2.5 * bounds.size.width, height: 1)
        
        switch weather.precipitation {
        case .drizzle:
            color = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
            let cell = makeEmitterCell(velocity: 700, scale: 0.035, direction: .pi, directionRange: 0, amount: 800)
            emitterLayer.emitterCells = [cell]
        case .rain:
            color = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 0.7052921661)
            let directionOfRain = CGFloat.pi * 1.1
            let smallCell = makeEmitterCell(velocity: 900, scale: 0.07, direction: directionOfRain, directionRange: 0, amount: 700)
            let mediumCell = makeEmitterCell(velocity: 1000, scale: 0.075, direction: directionOfRain, directionRange: 0, amount: 700)
            let bigCell = makeEmitterCell(velocity: 1200, scale: 0.08, direction: directionOfRain, directionRange: 0, amount: 700)
            emitterLayer.emitterCells = [smallCell, mediumCell, bigCell]
        case .snow:
            color = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.5139929366)
            let directionOfRain = CGFloat.pi * 1.05
            let directionRange = CGFloat.pi / 4
            let smallCell = makeEmitterCell(velocity: 80, scale: 0.1, direction: directionOfRain, directionRange: directionRange, amount: 50)
            let mediumCell = makeEmitterCell(velocity: 100, scale: 0.15, direction: directionOfRain, directionRange: directionRange, amount: 50)
            let bigCell = makeEmitterCell(velocity: 120, scale: 0.2, direction: directionOfRain, directionRange: directionRange, amount: 50)
            emitterLayer.emitterCells = [smallCell, mediumCell, bigCell]
        case .none:
            return
        }

    }

}