//
//  ViewController.swift
//  ConnectVt
//
//  Created by Jon Savage on 7/3/15.
//  Copyright © 2015 Jon Savage. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgQRCode: UIImageView!
    var qrcodeImage: CIImage! // The QR code
    
    @IBOutlet weak var mylabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var textField: UITextField!
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func CreateButtonPushed(sender: AnyObject) {
        mylabel.text = textField.text
        
        imgQRCode.image = nil
        qrcodeImage = nil

        if textField.text == "" {
            return
        }
        
        let data = textField.text!.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
        
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        filter!.setValue(data, forKey: "inputMessage")
        filter!.setValue("Q", forKey: "inputCorrectionLevel")
        
        qrcodeImage = filter!.outputImage
        
        textField.resignFirstResponder()
        
        displayQRCodeImage()
        
    }
    
    // MARK: Custom method implementation
    
    func displayQRCodeImage() {
        let scaleX = imgQRCode.frame.size.width / qrcodeImage.extent.size.width
        let scaleY = imgQRCode.frame.size.height / qrcodeImage.extent.size.height
        
        let transformedImage = qrcodeImage.imageByApplyingTransform(CGAffineTransformMakeScale(scaleX, scaleY))
        
        imgQRCode.image = UIImage(CIImage: transformedImage)
    }

}

