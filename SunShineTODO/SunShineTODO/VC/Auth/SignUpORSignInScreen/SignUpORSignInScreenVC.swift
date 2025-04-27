//
//  SignUpORSignInScreenVC.swift
//  SunShineTODO
//
//  Created by sooraj kahar on 22/04/25.
//

import UIKit
import SwiftUI


enum AuthType : String {
    case signUp
    case signIn
}


class SignUpORSignInScreenFactory {
    
    func makeVC(authType : AuthType) -> UIViewController {
        SignUpORSignInView(authType: authType).toVC()
    }
    
}


struct SignUpORSignInView: View {

    @State var authType : AuthType = .signIn
    @StateObject private var vm = SignUpORSignInScreenVMFactory().make()

    
    var isHideNavigationBar : Bool = false
    

    private var isSignIn : Bool {
        authType == .signIn
    }
    
    var body: some View {
        
        NavigationStack{
            VStack {
                
                Text(isSignIn ? "Sign In" : "Sign Up")
                    .font(.system(size: 25, weight: .semibold))
                    .background(ignoresSafeAreaEdges: .top)
                    .padding(.top, 30)
                    .padding(.bottom, 50)
                
                VStack(spacing: 20, content: {
                    
                    if !isSignIn{
                        // Name TextField
                        TextField("Enter your name", text: $vm.name)
                            .padding()
                            .overlay( // Border around the text field
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.6), lineWidth: 1) // Blue border with a width of 2
                            )
                    }
                    
                    // Email TextField with validation
                    TextField("Enter your email", text: $vm.email)
                        .padding()
                        .overlay( // Border around the text field
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.6), lineWidth: 1) // Blue border with a width of 2
                        )
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .onChange(of: vm.email) { newValue in
                            vm.validateEmail(email: newValue)
                        }
                    
                    if !vm.isValidEmail {
                        Text("Please enter a valid email address.")
                            .foregroundColor(.red)
                            .font(.caption)
                            .padding(.horizontal)
                    }
                    
                    HStack {
                        // Password field (Secure or plain based on visibility state)
                        if vm.isPasswordVisible {
                            TextField("Enter your password", text: $vm.password)
                                .padding()
                                .onChange(of: vm.password, perform: { newValue in
                                    vm.isValidPassword = (newValue.count >= 6)
                                })
                            
                        } else {
                            SecureField("Enter your password", text: $vm.password)
                                .padding()
                                .onChange(of: vm.password, perform: { newValue in
                                    vm.isValidPassword = (newValue.count >= 6)
                                })
                        }
                        
                        // Eye icon to toggle password visibility
                        Button(action: {
                            vm.isPasswordVisible.toggle()
                        }) {
                            Image(systemName: vm.isPasswordVisible ? "eye.slash" : "eye")
                                .foregroundColor(.gray)
                                .padding(.trailing)
                        }
                    }
                    .overlay( // Border around the text field
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.6), lineWidth: 1) // Blue border with a width of 2
                    )
                    
                    if !vm.isValidPassword {
                        Text("Password must be at least 6 characters.")
                            .foregroundColor(.red)
                            .font(.caption)
                            .padding(.horizontal)
                    }
                    
                    
                    
                })
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
                
                if !isSignIn{
                    HStack {
                        // Checkmark
                        Image(systemName: vm.isChecked ? "checkmark.square.fill" : "square")
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(._7_F_3_DFF)
                            .onTapGesture {
                                vm.isChecked.toggle()
                            }
                            .padding(.trailing, 10)
                        
                        // Terms and Conditions text
                        Text("By signing up, you agree to the ")
                            .foregroundColor(.primary)
                        + Text("Terms of Service and Privacy Policy")
                            .foregroundColor(._7_F_3_DFF)
                    }
                    .padding(.horizontal, 25 )
                }
                
                
                Button(action: {
                    vm.authenticate(authType: authType)
                    
                }, label: {
                    ThemeButtonView(title: isSignIn ? "Login" : "Sign Up")
                })
                .padding(.horizontal, 20)
                .padding(.vertical, 20)

                HStack{
                    // Terms and Conditions text
                    Text( isSignIn ? "Don’t have an account yet? " : "Already have an account? ")
                        .foregroundColor(.primary)
                        .font(.system(size: 15, weight: .medium))
                    
                    Button(action: {
                        
                        authType = isSignIn ? .signUp : .signIn
                        
                    }, label: {
                        Text(isSignIn ? "Sign UP" : "Sign In")
                            .foregroundColor(._7_F_3_DFF)
                            .font(.system(size: 16, weight: .bold))
                            .underline()
                    })
                }
                
                Spacer()
                
            }
            .navigationBarBackButtonHidden(isHideNavigationBar)
        }
    }
}

#Preview {
    SignUpORSignInView(authType: .signIn)
}
