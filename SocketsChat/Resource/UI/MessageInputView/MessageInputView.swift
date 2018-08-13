//
//  MessageInputView.swift
//  SocketsChat
//
//  Created by Алексей on 10.07.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class MessageInputView: UIView {
    
    // MARK: - Outlets
    @IBOutlet weak var messageTextView: UITextView!
    
    @IBOutlet weak var sendButton: UIButton!
    
    // MARK: - Properties
    private var view: UIView?
    
    var delegate: MessageInputProtocol?
    
    var parentViewController: UIViewController?
    
    var task: DispatchWorkItem?
    
    // MARK: - Override funcs
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    // MARK: - Actions
    @IBAction func send(_ sender: Any) {
        delegate?.send(message: messageTextView.text)
        messageTextView.text = ""
        task?.perform()
    }
    
    @IBAction func choosePhotoOfGallery(_ sender: Any) {
        showImageSourceType(.photoLibrary)
    }
    
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Public funcs
    func setup() {
        if let view = self.loadNib() {
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.view = view
            addSubview(view)
            messageTextView.delegate = self
            messageTextView.layer.cornerRadius = 5
            sendButton.layer.cornerRadius = 5
        }
    }
    
    // MARK: - Private funcs
    private func showImageSourceType(_ sourceType: UIImagePickerControllerSourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType),
            let parentViewController = parentViewController else {
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        parentViewController.present(imagePicker, animated: true, completion: nil)
    }
}
