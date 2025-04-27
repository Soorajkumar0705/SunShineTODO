//
//  OnboardingView.swift
//  SunRiseExpenseTracker
//
//  Created by Suraj kahar on 29/03/25.
//

import SwiftUI

struct OnboardingView: View {
    
    @State private var currentIndex: Int = 0
    
    var body: some View {
        
        NavigationStack{
            VStack{
                Spacer()
                    
                TabView(selection: $currentIndex, content: {
                    
                    ForEach(datasource, content: { data in
                        VStack(alignment: .center, content: {
                            
                            Image(uiImage: data.img)
                            
                            Text(String(data.title))
                                .font(.system(size: 32, weight: .bold))
                                .padding(.top, 10)
                                .foregroundStyle(Color._212325)
                                .multilineTextAlignment(.center)
                                .layoutPriority(10)
                            
                            Text(data.subTitle)
                                .font(.system(size: 16, weight: .medium))
                                .padding(.top, 5)
                                .padding(.bottom, 50)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(Color._91919_F)
                                .foregroundStyle(Color.black)
                            
                        })
                        .tag(data.id)
                        
                    })
                })
                .padding(.horizontal, 20)
                .clipped()
                .tabViewStyle(.page(indexDisplayMode: .automatic))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                
                
                VStack(spacing: 16, content: {
                    
                    Button(action: {
                        let vc = SignUpORSignInScreenFactory().makeVC(authType: .signUp)
                        AppNavigationCoordinator.shared.setRootVC(vc)
                        
                    }, label: {
                        ThemeButtonView(title: "Sign Up")
                    })
                    
                    Button(action: {
                        
                        let vc = SignUpORSignInScreenFactory().makeVC(authType: .signIn)
                        AppNavigationCoordinator.shared.setRootVC(vc)
                        
                    }, label: {
                        ThemeButtonView(
                            title: "Login",
                            backgroundColor: .EEE_5_FF,
                            foregroundColor: ._7_F_3_DFF
                        )
                    })
                    
                })
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                
            }
        }
        
    }
}

#Preview {
    OnboardingView()
}




fileprivate var datasource : [OnboardingPagerDataModel] = [

    OnboardingPagerDataModel(
        id: 0,
        img: .onboardingPage1Hand,
        title: Strings.Onboarding.onboardingPage1Title,
        subTitle: Strings.Onboarding.onboardingPage1Description
    ),
    
    OnboardingPagerDataModel(
        id: 1,
        img: .onboardingPage2FloatingNote,
        title: Strings.Onboarding.onboardingPage2Title,
        subTitle: Strings.Onboarding.onboardingPage2Description
    ),
    
    OnboardingPagerDataModel(
        id: 2,
        img: .onboardingPage3PlanningSheet,
        title: Strings.Onboarding.onboardingPage3Title,
        subTitle: Strings.Onboarding.onboardingPage3Description
    )
    
]
