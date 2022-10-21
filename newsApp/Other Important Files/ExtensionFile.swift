//
//  ExtensionFile.swift
//  newsApp
//
//  Created by manukant tyagi on 21/10/22.
//

import Foundation
import UIKit

//MARK: - UIView
extension UIView{
    func activityStartAnimating() {
        DispatchQueue.main.async {
            let activityIndicator = UIActivityIndicatorView(style: .medium)
            activityIndicator.center = self.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.startAnimating()
            activityIndicator.tag = 475647
            self.isUserInteractionEnabled = false
            self.addSubview(activityIndicator)
        }
    }
    
    func activityStopAnimating() {
        DispatchQueue.main.async{
            if let background = self.viewWithTag(475647){
                background.removeFromSuperview()
                self.isUserInteractionEnabled = true
            }
        }
    }
}

extension UIViewController{
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 160, y: self.view.frame.size.height-150, width: 320, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 20
        toastLabel.clipsToBounds  =  true
        toastLabel.layoutMargins.bottom = 200
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
