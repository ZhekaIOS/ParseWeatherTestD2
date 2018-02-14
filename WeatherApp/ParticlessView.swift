//
//  ParticlessView.swift
//  WeatherApp
//
//  Created by Евгений Ковалевский on 16.01.2018.
//  Copyright © 2018 Евгений Ковалевский. All rights reserved.
//

import UIKit
import SpriteKit



let currentDateTime = Date()
// get the user calendar
let userCalendar = Calendar.current
// choose which date and time components are needed
let requestedComponents: Set<Calendar.Component> = [.hour]
// get the components
let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)

class ParticlessView: SKView {
        
    override func didMoveToSuperview() {

        
        let scence = SKScene (size: self.frame.size)
        scence.backgroundColor = UIColor.clear
        self.presentScene(scence)
        self.allowsTransparency = true // разрешаю прозрачность
        self.backgroundColor = UIColor.clear // прозрачный фон
        // размещаем рисунки на сцене
        // если удалось создать частицы, то
        let particlesSnow  = SKEmitterNode (fileNamed : "ParticalScence.sks")
        particlesSnow?.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height) // делим на 2, ибо он появляется снизу в левом углу, таким образом мы его двигаем на пол экрана вправо и вверх
        //указываем пределы рисунков
        particlesSnow?.particlePositionRange = CGVector(dx: self.bounds.size.width, dy: 0)
        //добавляем эти свойства на нашу сцену
        /*
        let particles2  = SKEmitterNode (fileNamed : "MyParticleRain.sks")
        particles2?.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height) // делим на 2, ибо он появляется снизу в левом углу, таким образом мы его двигаем на пол экрана вправо и вверх
        //указываем пределы рисунков
        particles2?.particlePositionRange = CGVector(dx: self.bounds.size.width, dy: 0)
 */
        switch dateTimeComponents.hour {
        case  0?: print("полночь") ; scence.addChild(particlesSnow!) ; scence.backgroundColor = UIColor(red: 0, green: 5.5, blue: 0, alpha: 0)
        case  1?: print("час ночи")  ;scence.backgroundColor = UIColor(red: 0, green: 0, blue: 40, alpha: 0) ; scence.addChild(particlesSnow!)
        case  2?: print("2 часа ночи") ; scence.backgroundColor = UIColor(red: 0, green: 0, blue: 50, alpha: 0) ;  scence.addChild(particlesSnow!)
        case  3?: print("3 часа ночи"); scence.backgroundColor = UIColor(red: 0, green: 0, blue: 60, alpha: 0); scence.addChild(particlesSnow!)
        case  4?: print("4 часа ночи");  scence.backgroundColor = UIColor(red: 0, green: 0, blue: 70, alpha: 0); scence.addChild(particlesSnow!)
        case  5?: print("5 утра");  scence.backgroundColor = UIColor(red: 0, green: 0, blue: 80, alpha: 0); scence.addChild(particlesSnow!)
        case  6?: print("6 утра");scence.backgroundColor = .gray ; scence.addChild(particlesSnow!)
        case  7?: print("7 утра"); scence.backgroundColor = .darkGray; scence.addChild(particlesSnow!)
        case  8?: print("8 утра")  ;scence.backgroundColor = .darkGray; scence.addChild(particlesSnow!)
        case  9?: print("9 утра");scence.backgroundColor = .darkGray; scence.addChild(particlesSnow!)
        case  10?: print("10 утра");scence.backgroundColor = .darkGray; scence.addChild(particlesSnow!)
        case  11?: print("11 утра"); scence.backgroundColor = .darkGray; scence.addChild(particlesSnow!)
        case  12?: print("12 дня");scence.backgroundColor = .darkGray; scence.addChild(particlesSnow!)
        case  13?: print("13 дня");scence.backgroundColor = .darkGray; scence.addChild(particlesSnow!)
        case  14?: print("14 дня") ;       scence.backgroundColor = .darkGray  ; scence.addChild(particlesSnow!)
        case  15?: print("15 дня") ;  scence.backgroundColor = .darkGray; scence.addChild(particlesSnow!)
        case  16?: print("16 дня") ;scence.backgroundColor = .darkGray; scence.addChild(particlesSnow!)
        case  17?: print("17 дня");scence.backgroundColor = .darkGray ; scence.addChild(particlesSnow!)
        case  18?: print("18 вечера");scence.backgroundColor = .darkGray; scence.addChild(particlesSnow!)
        case  19?: print("19 вечера");scence.backgroundColor = .darkGray; scence.addChild(particlesSnow!)
        case  20?: print("20 вечера");scence.backgroundColor = .darkGray; scence.addChild(particlesSnow!)
        case  21?: print("21 вечера");scence.backgroundColor = .darkGray; scence.addChild(particlesSnow!)
        case  22?: print("22 вечера") ;scence.backgroundColor = .darkGray; scence.addChild(particlesSnow!)
        case  23?: print("23 ночи") ;scence.backgroundColor = .darkGray; scence.addChild(particlesSnow!)
        default :  break
        }
    }
}














