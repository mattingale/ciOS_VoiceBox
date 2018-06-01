//
//  ViewController.swift
//  VoiceBox
//
//  Created by Soy Christmas on 5/5/18.
//  Copyright © 2018 Soy Christmas. All rights reserved.
//

import UIKit
import CsoundiOS
import CircleMenu
import fluid_slider


                //UICOLOR extension//
extension UIColor {
        static func color(_ red: Int, green: Int, blue: Int, alpha: Float) -> UIColor {
            return UIColor(
            red: 1.0 / 255.0 * CGFloat(red),
            green: 1.0 / 255.0 * CGFloat(green),
            blue: 1.0 / 255.0 * CGFloat(blue),
            alpha: CGFloat(alpha))
        }
}

        //Main Viewcontroller with CircleMenuDelegation//
class ViewController: UIViewController, CircleMenuDelegate {
    
        //slider height width variables for different interfaces
            // Iphone 8Plus = W: 250, H: 5.
            // Iphone 6s = W: , H:
    
        //slider origin variables for different interfaces
            // Iphone 8Plus = X: 85, Y: 100.
            // Iphone 6s = X: 65, Y: 75.
    
        let sliderheightwidth: [Int] = [250, 20]
         let sliderorigins: [CGFloat] = [65, 75]
    
    
        var ptrTest: UnsafeMutablePointer<Float>?
        var csTest = 0.0
    
        var ptrTest1: UnsafeMutablePointer<Float>?
        var ptrTest1copy: UnsafeMutablePointer<Float>?
        var csTest1 = 0.0
    
        var ptrTest2: UnsafeMutablePointer<Float>?
        var ptrTest2copy: UnsafeMutablePointer<Float>?
        var csTest2copy = 0.0
        var csTest2 = 0.0
    
        var ptrTest3: UnsafeMutablePointer<Float>?
         var ptrTest3copy: UnsafeMutablePointer<Float>?
        var csTest3 = 0.0
    
        var globalTest = 0
                //create menu items for the circle menu//
        let items: [(icon: String, color: UIColor)] = [
        ("", UIColor(red: 0, green: 0.68, blue: 0.94, alpha: 1)),
        ("", UIColor(red: 0.93, green: 0, blue: 0.55, alpha: 1)),
        ("", UIColor(red: 1, green: 0.95, blue: 0, alpha: 1)),
        ("", UIColor(red: 0, green: 0, blue: 0, alpha: 1))
        ]
        let csound = SharedInstances.csound
 
        @IBOutlet weak var PowerSwitch: UISwitch!
        @IBInspectable var buttonsCount: Int = 3
        @IBInspectable var duration: Double = 2 // circle animation duration
        @IBInspectable var distance: Float = 200 // distance between center button and buttons
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                 //iphone 8s 175, 520, 60, 60
                 // ihpone 6s 155, 480, 60, 60
            let presetsMenu1 = CircleMenu(
            frame: CGRect(x: 155, y: 480, width: 60, height: 60),
            normalIcon:"Button150.png",
            selectedIcon:"Button2.png",
            buttonsCount: 4,
            duration: 0.8,
            distance: 150)
            presetsMenu1.delegate = self
            presetsMenu1.layer.cornerRadius = presetsMenu1.frame.size.width / 2.0
            view.addSubview(presetsMenu1)
            presetsMenu1.center.x = self.view.center.x
            presetsMenu1.center.y = self.view.center.y + (self.view.center.y / 2)

                //----------------------------_First Slider---------------------------------//
            let slider = Slider()
            slider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 3
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 100) as NSNumber) ?? ""
            return NSAttributedString(string: string)
            }
            slider.setMinimumLabelAttributedText(NSAttributedString(string: ""))
            slider.setMaximumLabelAttributedText(NSAttributedString(string: ""))
            slider.fraction = 0.5
            slider.shadowOffset = CGSize(width: 0, height: 10)
            slider.shadowBlur = 0
            slider.shadowColor = UIColor(white: 0, alpha: 0.0)
            slider.contentViewColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1)
            slider.valueViewColor = UIColor(red: 0, green: 0.68, blue: 0.94, alpha: 1)
            slider.layer.cornerRadius = 12
            slider.frame.size = CGSize(width: sliderheightwidth[0], height: sliderheightwidth[1])
            slider.center.x = self.view.center.x
            slider.center.y = (self.view.center.y - (self.view.center.y * 0.80)) + (self.view.center.y * 0.1)

            view.addSubview(slider)
        
            slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)  //slider listening
        
        
                //---------------------Second Slider-----------------------------//
        
        
            let slider1 = Slider()
            slider1.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 1
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 100) as NSNumber) ?? ""
            return NSAttributedString(string: string)
        }
            slider1.setMinimumLabelAttributedText(NSAttributedString(string: ""))
            slider1.setMaximumLabelAttributedText(NSAttributedString(string: ""))
            slider1.fraction = 0.5
            slider1.shadowOffset = CGSize(width: 0, height: 10)
            slider1.shadowBlur = 2
            slider1.shadowColor = UIColor(white: 0, alpha: 0.0)
            slider1.contentViewColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1)
            slider1.valueViewColor = UIColor(red: 0.93, green: 0, blue: 0.55, alpha: 1)

            slider1.layer.cornerRadius = 12
            slider1.frame.size = CGSize(width: sliderheightwidth[0], height: sliderheightwidth[1])
            slider1.center.x = self.view.center.x
            slider1.center.y = (self.view.center.y - (self.view.center.y * 0.60)) + (self.view.center.y * 0.1)

        
            view.addSubview(slider1)
        
            slider1.addTarget(self, action: #selector(sliderValueChanged1), for: .valueChanged) //slider listening
        
        
                //---------------------Third Slider-----------------------------//
        
        
        let slider2 = Slider()
        slider2.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 1
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 100) as NSNumber) ?? ""
            return NSAttributedString(string: string)
        }
        slider2.setMinimumLabelAttributedText(NSAttributedString(string: ""))
        slider2.setMaximumLabelAttributedText(NSAttributedString(string: ""))
        slider2.fraction = 0.5
        slider2.shadowOffset = CGSize(width: 0, height: 10)
        slider2.shadowBlur = 2
        slider2.shadowColor = UIColor(white: 0, alpha: 0.0)
        slider2.contentViewColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1)
        slider2.valueViewColor = UIColor(red: 1, green: 0.95, blue: 0, alpha: 1)

        slider2.layer.cornerRadius = 12
        slider2.frame.size = CGSize(width: sliderheightwidth[0], height: sliderheightwidth[1])
        slider2.center.x = self.view.center.x
        slider2.center.y = (self.view.center.y - (self.view.center.y * 0.40)) + (self.view.center.y * 0.1)
        view.addSubview(slider2)
        
        slider2.addTarget(self, action: #selector(sliderValueChanged2), for: .valueChanged) //slider listening
        
                //---------------------Fourth Slider-----------------------------//
        
        
        let slider3 = Slider()
        slider3.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 1
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 100) as NSNumber) ?? ""
            return NSAttributedString(string: string)
        }
        slider3.setMinimumLabelAttributedText(NSAttributedString(string: ""))
        slider3.setMaximumLabelAttributedText(NSAttributedString(string: ""))
        slider3.fraction = 0.5
        slider3.shadowOffset = CGSize(width: 0, height: 10)
        slider3.shadowBlur = 2
        slider3.shadowColor = UIColor(white: 0, alpha: 0.0)
        slider3.contentViewColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1)
        slider3.valueViewColor = .white

        slider3.layer.cornerRadius = 12
        slider3.frame.size = CGSize(width: sliderheightwidth[0], height: sliderheightwidth[1])
        slider3.center.x = self.view.center.x
        slider3.center.y = (self.view.center.y - (self.view.center.y * 0.20)) + (self.view.center.y * 0.1)
        view.addSubview(slider3)
        
        slider3.addTarget(self, action: #selector(sliderValueChanged3), for: .valueChanged) //slider listening
        
        
       
        
                //---------------------Csound Setup---------------------------------//
        
        
            csound.setMessageCallback(#selector(printMessage(_:)), withListener: self)
            let csdPath = Bundle.main.path(forResource: "VoiceBox", ofType: "csd")
            csound.useAudioInput = true
            csound.play(csdPath)
            csound.addBinding(self)

     
        
        }

                    @IBAction func sliderValueChanged(_ sender: Slider){
                      let localTest = sender.fraction
                      csTest = Double(localTest)
                    }
    
                    @IBAction func sliderValueChanged1(_ sender: Slider){
                        let localTest = sender.fraction
                        csTest1 = Double(localTest)
                    }
    
                    @IBAction func sliderValueChanged2(_ sender: Slider){
                        let localTest = sender.fraction
                        csTest2 = Double(localTest)
                    }
    
                    @IBAction func sliderValueChanged3(_ sender: Slider){
                        let localTest = sender.fraction
                        csTest3 = Double(localTest)
                    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func printMessage(_ infoObj: NSValue) {
        var info = Message()
        infoObj.getValue(&info)
        let message = UnsafeMutablePointer<Int8>.allocate(capacity: 1024)
        let va_ptr: CVaListPointer = CVaListPointer(_fromUnsafeMutablePointer: &(info.valist))
        vsnprintf(message, 1024, info.format, va_ptr)
        let output = String(cString: message)
        print(output)
        
    }
    func circleMenu(_: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
        button.backgroundColor = items[atIndex].color
        
        button.setImage(UIImage(named: items[atIndex].icon), for: .normal)
        
        // set highlited image
        let highlightedImage = UIImage(named: items[atIndex].icon)?.withRenderingMode(.alwaysTemplate)
        button.setImage(highlightedImage, for: .highlighted)
        button.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        switch atIndex{
        case 0: print("")
         
        case 1: print("")
        case 2: print("")
        case 3: print("")
        default:
            print("")
        }
    }
    
    func circleMenu(_: CircleMenu, buttonWillSelected _: UIButton, atIndex: Int) {
        print("button will selected: \(atIndex)")
    }
    
    func circleMenu(_: CircleMenu, buttonDidSelected _: UIButton, atIndex: Int) {
        print("button did selected: \(atIndex)")
        switch atIndex {
        case 0: csound.sendScore("i1.1 0 -1")
                csound.sendScore("i-2.1 0 1")
                csound.sendScore("i-3.1 0 1")
                csound.sendScore("i-4.1 0 1")
        case 1: csound.sendScore("i-1.1 0 1")
                csound.sendScore("i2.1 0 -1")
                csound.sendScore("i-3.1 0 1")
                csound.sendScore("i-4.1 0 1")
        case 2: csound.sendScore("i-1.1 0 1")
                csound.sendScore("i-2.1 0 1")
                csound.sendScore("i3.1 0 -1")
                csound.sendScore("i-4.1 0 1")
        case 3: csound.sendScore("i-1.1 0 1")
                csound.sendScore("i-2.1 0 1")
                csound.sendScore("i-3.1 0 1")
                csound.sendScore("i4.1 0 -1")
        default:
            print("")
        
        }
    }

}
extension ViewController: CsoundBinding {
    func setup(_ csoundObj: CsoundObj) {
        // Setup channel pointers for manual Csound binding
        ptrTest = csoundObj.getInputChannelPtr("ptrTest", channelType: CSOUND_CONTROL_CHANNEL)
        ptrTest1 = csoundObj.getInputChannelPtr("ptrTest1", channelType: CSOUND_CONTROL_CHANNEL)
        ptrTest1copy = csoundObj.getInputChannelPtr("ptrTest1copy", channelType: CSOUND_CONTROL_CHANNEL)
        ptrTest2 = csoundObj.getInputChannelPtr("ptrTest2", channelType: CSOUND_CONTROL_CHANNEL)
            ptrTest2copy = csoundObj.getInputChannelPtr("ptrTest2copy", channelType: CSOUND_CONTROL_CHANNEL)
        ptrTest3 = csoundObj.getInputChannelPtr("ptrTest3", channelType: CSOUND_CONTROL_CHANNEL)
        ptrTest3copy = csoundObj.getInputChannelPtr("ptrTest3copy", channelType: CSOUND_CONTROL_CHANNEL)
        
    }
    
    func updateValuesToCsound() {
        // Update values at channel pointer addresses
        ptrTest?.pointee = Float(csTest)
        ptrTest1?.pointee = Float(csTest1)
            ptrTest1copy?.pointee = Float(csTest1)
        ptrTest2?.pointee = Float(csTest2)
            ptrTest2copy?.pointee = Float(csTest2)
        ptrTest3?.pointee = Float(csTest3)
         ptrTest3copy?.pointee = Float(csTest3)
       
    }
}

