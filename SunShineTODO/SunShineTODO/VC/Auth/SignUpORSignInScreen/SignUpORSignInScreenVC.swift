//
//  SignUpORSignInScreenVC.swift
//  SunShineTODO
//
//  Created by sooraj kahar on 22/04/25.
//

import UIKit

class SignUpORSignInScreenVCFactory {
    
    func makeVC(isSignUp : Bool) -> SignUpORSignInScreenVC {
        let vc = SignUpORSignInScreenVC.instantiate(from: .main)
        vc.isSignUp = isSignUp
        
        return vc
    }
    
}

class SignUpORSignInScreenVC: UIViewController, StoryboardBased {
    
    @IBOutlet private weak var bottomContainerView: UIView!
    @IBOutlet private weak var lblViewTitle: UILabel!
    
    @IBOutlet private weak var txtName: UITextField!
    @IBOutlet private weak var txtEmail: UITextField!
    @IBOutlet private weak var txtPassword: UITextField!
    @IBOutlet private weak var txtConfimPassword: UITextField!
    
    @IBOutlet private weak var lblAlreadyHaveAnAccount: UILabel!
    
    
    @IBOutlet private weak var btnSignUpOrSignIn: UIButton!
    
    
    var isSignUp: Bool! {
        didSet{
            _=requestBuilder.setIsSignUp(isSignUp)
        }
    }
    
    var vm = SignUpORSignInScreenVM()
    var requestBuilder = AuthenticationRequestBuilder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isSignUp == nil {
            fatalError("Please instantiate this class from factory method.")
        }
        _=requestBuilder.setIsSignUp(isSignUp)
        
        setupUI()
        bindVM()
    }
    
    private func setupUI(){
        txtName.addKeyboardDismissAbilityOnToolBarDoneButton()
        txtName.placeholder = "Name"
        txtName.textColor = .black
        
        txtEmail.addKeyboardDismissAbilityOnToolBarDoneButton()
        txtEmail.placeholder = "Email"
        txtEmail.textColor = .black
        
        txtPassword.addKeyboardDismissAbilityOnToolBarDoneButton()
        txtPassword.placeholder = "Password"
        txtPassword.textColor = .black
        
        txtConfimPassword.addKeyboardDismissAbilityOnToolBarDoneButton()
        txtConfimPassword.placeholder = "Confirm Password"
        txtConfimPassword.textColor = .black
        
        btnSignUpOrSignIn.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        
        updateUIForSignInFlag()
        addKeyBoardOpenCloseHandleUIStateObserver()
    }
    
    private func updateUIForSignInFlag(){
        
        if isSignUp {
            lblViewTitle.text = "Sign Up"
            txtName.superview?.isHidden = false
            txtConfimPassword.superview?.isHidden = false
            
            lblAlreadyHaveAnAccount.text = "Already have an account? Sign in"
            btnSignUpOrSignIn.setTitle("Sign Up", for: .normal)
            
        }else{
            lblViewTitle.text = "Sign In"
            txtName.superview?.isHidden = true
            txtConfimPassword.superview?.isHidden = true
            
            lblAlreadyHaveAnAccount.text = "Don't have an account? Sign up"
            
            btnSignUpOrSignIn.setTitle("Sign In", for: .normal)
            
        }
        
    }
    
    private func bindVM(){
        vm.didRecieveError = { [weak self] error in
            guard let _ = self else { return }
            DispatchQueue.main.async {
                Toast.show(error)
            }
        }
        
        vm.didRecieveSignInResponse = { [weak self] in
            guard let _ = self else { return }
            DispatchQueue.main.async {            
                HomeVC.instantiate(from: .main).rootVC()
            }
        }
        
        vm.didRecieveSignUpResponse = {
            
        }
        
    }
    
    @IBAction private func btnAlreadyHaveAnAccountTapped(_ sender: UIButton) {
        
        isSignUp.toggle()
        updateUIForSignInFlag()
        
        print(#function)
    }
    
    
    @IBAction private func btnSignUpOrSignInTapped(_ sender: UIButton) {
        
        let req = requestBuilder
            .setName(txtName.text)
            .setEmail(txtEmail.text)
            .setPassword(txtPassword.text)
        
        isSignUp ? vm.signUp(requestBuilder: req) : vm.signIn(requestBuilder: req)
        print(#function)
    }
    
}

extension SignUpORSignInScreenVC {
    
    private func addKeyBoardOpenCloseHandleUIStateObserver(){
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main, using: { [weak self] notification in
            guard let self else { return }
            
//                guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
//                else { return }
            
            bottomContainerView.frame.origin.y = 50
            
        })
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main, using: { [weak self] notification in
            guard let self else { return }
            
            guard let _ /*keyboardFrame*/ = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            else { return }
            
            bottomContainerView.frame.origin.y = (view.frame.height)-bottomContainerView.frame.height
            
        })
    }
    
}
