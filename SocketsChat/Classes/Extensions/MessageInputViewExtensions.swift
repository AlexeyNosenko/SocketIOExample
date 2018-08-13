//
//  MessageInputViewExtensions.swift
//  SocketsChat
//
//  Created by Алексей on 01.08.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

// MARK: - Delegate UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension MessageInputView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            delegate?.send(image: image.withRenderingMode(.alwaysOriginal))
        } else if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            delegate?.send(image: image.withRenderingMode(.alwaysOriginal))
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Delegate UITextViewDelegate
extension MessageInputView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        delegate?.didChangeMessage(textView)
        delegate?.didBeginChangeMessage(textView)
        
        task?.cancel()
        task = DispatchWorkItem { [weak self] in
            self?.delegate?.didEndChangeMessage(textView)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: task!)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
    }
}
