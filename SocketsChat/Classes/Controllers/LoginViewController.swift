//
//  ViewController.swift
//  SocketsChat
//
//  Created by Алексей on 10.07.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var loginTextField: UITextField!
    
    // MARK: - Propertvar
    let segueGoChat = "segueGoChat"
    
    // MARK: - Override funcs
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == segueGoChat {
            return loginTextField.text != ""
        }
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier,
            identifier == segueGoChat,
            let vc = segue.destination as? ChatViewController,
            let nickname = loginTextField.text else {
            return
        }
        
        vc.user = User(nickname: nickname, isOnline: true)
    }
    @IBAction func changeServer(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            ServerConfiguration.typeServer = .home
        case 1:
            ServerConfiguration.typeServer = .work
        case 2:
            ServerConfiguration.typeServer = .rost
        default:
            break
        }
        SocketIOManager.shared.changeUrl(urlString: ServerConfiguration.fullUrlString)
    }
}
