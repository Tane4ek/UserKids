//
//  UserView.swift
//  UserWithKids
//
//  Created by Tatiana Luzanova on 27.02.2022.
//

import Foundation
import UIKit

class UserView: UIView {
    
    private enum Layout {
        static let verticalInset: CGFloat = 5
        static let horizontalInset: CGFloat = 10
    }
    
    private enum FontStyle {
        static let title = UIFont.systemFont(ofSize: 16)
        static let name = UIFont.systemFont(ofSize: 20)
    }
    
    var titleLabel = UILabel()
    var textField = UITextField()
    var delegate: UserTextFieldDelegate?
    
//    MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
//    MARK: - Setup UI
    private func setupUI() {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        setupLabel()
        setupTextField()
        setupLayout()
    }
    
    private func setupLabel() {
        titleLabel.textColor = .lightGray
        titleLabel.font = FontStyle.title
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
    }
    
    private func setupTextField() {
        textField.textColor = .black
        textField.delegate = self
        textField.font = FontStyle.name
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        
    }
   
//    MARK: - Layout
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Layout.verticalInset),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.horizontalInset),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Layout.verticalInset),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.horizontalInset),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Layout.horizontalInset),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Layout.verticalInset)
        ])
    }
}

extension UserView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let delegate = delegate {
            delegate.transfer(index: textField.tag)
        }
        return true;
    }
}
