//
//  SwiftUIViewHostingController.swift
//  RandomUser4Justo
//
//  Created by user218634 on 8/27/22.
//

import Foundation
import SwiftUI

class SwiftUIViewHostingController: UIHostingController<SplashScreenView> {
    var homeViewController: UIViewController!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: SplashScreenView())
    }
    
    //When splashScreen finished loading then wait 2.5 seconds while the animation finishes to present the
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainNavigationController")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            print("SHOULD DIMISS")
            self.homeViewController.modalPresentationStyle = .fullScreen
            self.present(self.homeViewController, animated: true, completion: nil)
        }
    }
    
}
