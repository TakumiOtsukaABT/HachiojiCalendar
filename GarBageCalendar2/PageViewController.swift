//
//  PageViewController.swift
//  GarBageCalendar2
//
//  Created by Takumi Otsuka on 2021/06/19.
//

import UIKit

class PageViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllers([getFirst()], direction: .forward, animated: true, completion: nil)
        self.dataSource = self
    }

    func getFirst() -> OnboardingPage1ViewController {
        return storyboard!.instantiateViewController(withIdentifier: "Page1") as! OnboardingPage1ViewController
    }
    
    func getSecond() -> OnboardingPage2ViewController {
        return storyboard!.instantiateViewController(withIdentifier: "Page2") as! OnboardingPage2ViewController
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension PageViewController : UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: OnboardingPage1ViewController.self) {
            // 1 -> 2
            return getSecond()
        } else {
            // 3 -> end of the road
            return nil
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: OnboardingPage2ViewController.self) {
            return getFirst()
        } else {
            return nil
        }
    }
}
