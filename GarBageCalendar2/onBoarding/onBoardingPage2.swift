//
//  onBoardingPage2.swift
//  GarBageCalendar2
//
//  Created by Takumi Otsuka on 2021/06/19.
//

import UIKit

class OnboardingPage2ViewController: UIViewController {
    let userDefaults = UserDefaults.standard
    @IBAction func skipAction(_ sender: Any) {
        userDefaults.setValue(true, forKey: "moreThanOnce")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "first") as ViewController
        let window = UIApplication.shared.windows[0] as UIWindow;
        UIView.transition(
            from: window.rootViewController!.view,
            to: vc.view,
            duration: 0.65,
            options: .transitionCrossDissolve,
            completion: {
                finished in window.rootViewController = vc
            })
    }
}
