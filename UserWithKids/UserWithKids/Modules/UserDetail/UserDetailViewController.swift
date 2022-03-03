//
//  UserDetailViewController.swift
//  UserWithKids
//
//  Created by Tatiana Luzanova on 27.02.2022.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    private enum Layout {
        enum Views {
            static let height: CGFloat = 60
        }
        static let subviewInset: CGFloat = 10

        enum KidsListCollectionView {
            static let inset: CGFloat = 10
        }
        
        enum Buttons {
            static let height: CGFloat = 40
            static let width: CGFloat = 200
        }
    }
    
    private let presenter: UserDetailViewOutput
    
    private var userNameView = UserView()
    private var userAgeView = UserView()
    
    private var kidsLabel = UILabel()
    private var addButton = UIButton()
    private var kidsListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    private let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    private var clearButton = UIButton()
    
//    MARK: - Init
    init(presenter: UserDetailViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillAppear()
    }
    
    override func viewDidLayoutSubviews() {
        if presenter.numberOfItems() >= 5 {
            addButton.isHidden = true
        } else {
            addButton.isHidden = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (touches.first) != nil {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
 
//    MARK: Setup UI
    private func setupUI() {
        view.backgroundColor = .white
        setupUserNameView()
        setupUserAgeView()
        setupKidsLabel()
        setupButtonAdd()
        setupKidsListCollectionView()
        setupClearButton()
        registerForKeyboardNotification()
        setupLayout()
    }
    
    private  func setupUserNameView() {
        userNameView = makeviewStyle(name: "Имя", placeholder: "Введите имя")
        userNameView.delegate = self
        userNameView.textField.text = presenter.currentUser().name
        userNameView.textField.tag = 0
        view.addSubview(userNameView)
    }
    
    private  func setupUserAgeView() {
        userAgeView = makeviewStyle(name: "Возраст", placeholder: "Введите возраст")
        userAgeView.delegate = self
        userNameView.textField.text = presenter.currentUser().age
        userAgeView.textField.tag = 1
        view.addSubview(userAgeView)
    }
    
    private func setupKidsLabel() {
        kidsLabel.text = "Дети (макс. 5)"
        kidsLabel.font = UIFont.systemFont(ofSize: 20)
        kidsLabel.textColor = UIColor.black
        kidsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(kidsLabel)
    }
    
    private func setupButtonAdd() {
        addButton.setTitle("Добавить ребенка", for: .normal)
        addButton.setTitleColor(UIColor.systemBlue, for: .normal)
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        addButton.tintColor = UIColor.systemBlue
        addButton.layer.cornerRadius = 20
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor.systemBlue.cgColor
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.addTarget(self, action: #selector(addKidButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(addButton)
    }
    
    private func setupKidsListCollectionView() {
        kidsListCollectionView.register(KidsListCollectionViewCell.self, forCellWithReuseIdentifier: KidsListCollectionViewCell.reusedId)
        layout.scrollDirection = .vertical
        kidsListCollectionView.setCollectionViewLayout(layout, animated: true)
        kidsListCollectionView.delegate = self
        kidsListCollectionView.dataSource = self
        layout.minimumLineSpacing = 10
        kidsListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(kidsListCollectionView)
    }
    
    private func setupClearButton() {
        clearButton.setTitle("Очистить", for: .normal)
        clearButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        clearButton.setTitleColor(UIColor.red, for: .normal)
        clearButton.layer.cornerRadius = 20
        clearButton.layer.borderWidth = 1
        clearButton.layer.borderColor = UIColor.systemRed.cgColor
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.addTarget(self, action: #selector(clearButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(clearButton)
    }
   
//    MARK: - Layout
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            userNameView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Layout.subviewInset),
            userNameView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Layout.subviewInset),
            userNameView.heightAnchor.constraint(equalToConstant: Layout.Views.height),
            userNameView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Layout.subviewInset),
            
            userAgeView.topAnchor.constraint(equalTo: userNameView.bottomAnchor, constant: Layout.subviewInset),
            userAgeView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Layout.subviewInset),
            userAgeView.heightAnchor.constraint(equalToConstant: Layout.Views.height),
            userAgeView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Layout.subviewInset),
            
            addButton.topAnchor.constraint(equalTo: userAgeView.bottomAnchor, constant: Layout.subviewInset),
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Layout.subviewInset),
            addButton.heightAnchor.constraint(equalToConstant: Layout.Buttons.height),
            addButton.widthAnchor.constraint(equalToConstant: Layout.Buttons.width),
            
            kidsLabel.centerYAnchor.constraint(equalTo: addButton.centerYAnchor),
            kidsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Layout.subviewInset),
            
            clearButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            clearButton.widthAnchor.constraint(equalToConstant: Layout.Buttons.width),
            clearButton.heightAnchor.constraint(equalToConstant: Layout.Buttons.height),
            clearButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Layout.subviewInset),
            
            kidsListCollectionView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: Layout.KidsListCollectionView.inset),
            kidsListCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Layout.KidsListCollectionView.inset),
            kidsListCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Layout.KidsListCollectionView.inset),
            kidsListCollectionView.bottomAnchor.constraint(equalTo: clearButton.topAnchor),
        ])
    }
    
//  MARK: - Style methods
    
    private func makeviewStyle(name: String, placeholder: String) -> UserView {
        let view = UserView()
        view.titleLabel.text = name
        view.textField.placeholder = placeholder
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
//    MARK: - Button action
    @objc private func addKidButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        presenter.buttonAddTapped()
    }
    
    @objc private func clearButtonTapped(_ sender: UIButton) {
        presenter.buttonClearTapped()
    }
    
    private func registerForKeyboardNotification() {
        self.registerForKeyboardWillShowNotification(self.kidsListCollectionView)
        self.registerForKeyboardWillHideNotification(self.kidsListCollectionView)
    }
}

//  MARK: - UserDetailInput
extension UserDetailViewController: UserDetailViewInput {
    func reloadUI() {
        kidsListCollectionView.reloadData()
        userNameView.textField.text = presenter.currentUser().name
        userAgeView.textField.text = presenter.currentUser().age
    }
}

// MARK: - UICollectionViewDelegate
extension UserDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: - UICollectionViewDataSource
extension UserDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = kidsListCollectionView.dequeueReusableCell(
            withReuseIdentifier: KidsListCollectionViewCell.reusedId,
            for: indexPath) as! KidsListCollectionViewCell
        let modelOfIndex = presenter.modelOfIndex(index: indexPath.row)
        cell.configure(model: modelOfIndex)
        cell.textFieldIndex = indexPath.row
        cell.delegate = self
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension UserDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 2 * Layout.KidsListCollectionView.inset, height: 150)
    }
}

// MARK: - UserViewDelegate
extension UserDetailViewController: UserViewDelegate {
    func getUserData(data: String, index: Int) {
        if index == 0 {
            presenter.addUserName(name: data)
        } else if index == 1 {
            presenter.addUserAge(age: data)
        }
    }
    
    func transfer(index: Int) {
        if index == 0 {
            userAgeView.textField.becomeFirstResponder()
        } else if index == 1 {
            userAgeView.textField.resignFirstResponder()
        }
    }
}

//  MARK: - KidsCellDelegate
extension UserDetailViewController: KidsCellDelegate {
    func getData(data: String, textIndex: Int, kidIndex: Int) {
        if textIndex == 0 {
            presenter.addKidName(name: data, index: kidIndex)
        } else if textIndex == 1 {
            presenter.addKidAge(age: data, index: kidIndex)
        }
    }
    
    func deleteKid(index: Int) {
        presenter.buttonDeleteTapped(index: index)
    }
}

//MARK: - registerForKeyboardNotification
extension UserDetailViewController {
    func registerForKeyboardWillShowNotification(_ scrollView: UIScrollView, usingBlock block: ((CGSize?) -> Void)? = nil) {
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil, using: { notification -> Void in
            let userInfo = notification.userInfo!
            let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue.size
            self.kidsListCollectionView.setContentInsetAndScrollIndicatorInsets(UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0))
        })
    }
    
    func registerForKeyboardWillHideNotification(_ scrollView: UIScrollView, usingBlock block: ((CGSize?) -> Void)? = nil) {
        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil, using: { notification -> Void in
            self.kidsListCollectionView.setContentInsetAndScrollIndicatorInsets(UIEdgeInsets.zero)
        })
    }
}

extension UIScrollView {
    func setContentInsetAndScrollIndicatorInsets(_ edgeInsets: UIEdgeInsets) {
        self.contentInset = edgeInsets
        self.scrollIndicatorInsets = edgeInsets
    }
}




