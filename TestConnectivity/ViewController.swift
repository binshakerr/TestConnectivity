//
//  ViewController.swift
//  TestConnectivity
//
//  Created by Eslam Shaker on 21/01/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        observeConnectivity()
    }

}


extension UIViewController {
    
    func observeConnectivity() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleConnectivityChange), name: .connectionStatusChanged, object: nil)
    }
    
    @objc
    private func handleConnectivityChange(_ notification: Notification) {
        guard let object = notification.object as? ConnectionObject else { return }
        if object.status != .satisfied {
            let alert = UIAlertController(title: "Error", message: "no internet connection", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
}

