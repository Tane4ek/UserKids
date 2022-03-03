//
//  KidsListCollectionViewCell.swift
//  UserWithKids
//
//  Created by Tatiana Luzanova on 27.02.2022.
//

import UIKit

class KidsListCollectionViewCell: UICollectionViewCell {
    
    private enum Paddings {
        static let horizontalInset: CGFloat = 10
    }
    
    static let reusedId = "KidsListCollectionViewCell"
    
    private var containerView = UIView(frame: .zero)
    private var kidNameView = UserView()
    private var kidAgeView = UserView()
    private var deleteButton = UIButton()
    
    var textFieldIndex: Int?
    
    weak var delegate: KidsCellDelegate?
    
//    MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUICell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//  MARK: - Setup UI
    private func setupUICell() {
        setupContainerView()
        setupKidNameView()
        setupKidAgeView()
        setupDeleteButton()
        setupLayoutCell()
    }
    
    private func setupContainerView() {
        containerView.layer.cornerRadius = 10
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
    }
    
    private func setupKidNameView() {
        kidNameView = viewStyle(name: "Имя", placeholder: "Введите имя")
        kidNameView.textField.delegate = self
        kidNameView.textField.tag = 0
        containerView.addSubview(kidNameView)
    }
    
    private func setupKidAgeView() {
        kidAgeView = viewStyle(name: "Возраст", placeholder: "Введите возраст")
        kidAgeView.textField.delegate = self
        kidAgeView.textField.tag = 1
        containerView.addSubview(kidAgeView)
    }
    private func setupDeleteButton() {
        deleteButton.setTitle("Удалить", for: .normal)
        deleteButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        deleteButton.setTitleColor(UIColor.systemBlue, for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(deleteButton)
    }
    
//    MARK: - Layout
    private func setupLayoutCell() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            kidNameView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Paddings.horizontalInset),
            kidNameView.topAnchor.constraint(equalTo: topAnchor, constant: Paddings.horizontalInset),
            kidNameView.widthAnchor.constraint(equalToConstant: 200),
            
            kidAgeView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Paddings.horizontalInset),
            kidAgeView.topAnchor.constraint(equalTo: kidNameView.bottomAnchor, constant: Paddings.horizontalInset),
            kidAgeView.widthAnchor.constraint(equalToConstant: 200),
            
            deleteButton.centerYAnchor.constraint(equalTo: kidNameView.centerYAnchor),
            deleteButton.leadingAnchor.constraint(equalTo: kidNameView.trailingAnchor, constant: Paddings.horizontalInset)
            
        ])
    }
    
//  MARK: - Style methods
    private func viewStyle(name: String, placeholder: String) -> UserView {
        let view = UserView()
        view.titleLabel.text = name
        view.textField.placeholder = placeholder
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    
//    MARK: - Configure
    func configure (model: Person) {
        kidNameView.textField.text = model.name
        kidAgeView.textField.text = String(model.age)
     }
    
    @objc func deleteButtonTapped(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.deleteKid(index: textFieldIndex ?? 0)
        }
    }
}


//  MARK: - UITextFieldDelegate
extension KidsListCollectionViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
        kidAgeView.textField.becomeFirstResponder()
        } else if textField.tag == 1 {
            kidAgeView.textField.resignFirstResponder()
        }
        return true;
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 1 {
            let allowCharacters = CharacterSet(charactersIn: "0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            let shouldReplace = allowCharacters.isSuperset(of: characterSet)
            if !shouldReplace {
                return false
            }
        }
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if let delegate = delegate {
            delegate.getData(data: updatedText, textIndex: textField.tag, kidIndex: textFieldIndex ?? 0)
        }
        
        return updatedText.count <= 20
    }
}


