//
//  AuthenticationView.swift
//  Skedul
//
//  Created by skedul on 29/10/24.
//

import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseAuth
import CryptoKit
import AuthenticationServices

class AuthenticationView: ObservableObject {
    
    @Published var isLoginSuccessed = false
    
    func signInWithGoogle(completion: @escaping (Bool) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: Application_utility.rootViewController) { user, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(false)
                return
            }
            
            guard let user = user?.user, let idToken = user.idToken else {
                completion(false)
                return
            }
            let accessToken = user.accessToken
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { res, error in
                if let error = error {
                    print(error.localizedDescription)
                    completion(false)
                    return
                }
                guard let user = res?.user else {
                    completion(false)
                    return
                }
                print(user)
                completion(true)
            }
        }
    }
    

    func logout() async throws {
        GIDSignIn.sharedInstance.signOut()
        try Auth.auth().signOut()
    }
    
    
    func randomNonceString(length: Int = 32) -> String {
            precondition(length > 0)
            var randomBytes = [UInt8](repeating: 0, count: length)
            let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
            if errorCode != errSecSuccess {
                fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
            }

            let charset: [Character] =
                Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

            let nonce = randomBytes.map { byte in
                charset[Int(byte) % charset.count]
            }

            return String(nonce)
        }

        @available(iOS 13, *)
        func sha256(_ input: String) -> String {
            let inputData = Data(input.utf8)
            let hashedData = SHA256.hash(data: inputData)
            let hashString = hashedData.compactMap {
                String(format: "%02x", $0)
            }.joined()

            return hashString
        }

        func handleAppleSignIn(result: Result<ASAuthorization, Error>, currentNonce: String?, completion: @escaping (Bool) -> Void) {
            switch result {
            case .success(let authResults):
                switch authResults.credential {
                case let appleIDCredential as ASAuthorizationAppleIDCredential:

                    guard let nonce = currentNonce else {
                        fatalError("Invalid state: A login callback was received, but no login request was sent.")
                    }
                    guard let appleIDToken = appleIDCredential.identityToken else {
                        fatalError("Invalid state: A login callback was received, but no login request was sent.")
                    }
                    guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                        print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                        completion(false)
                        return
                    }

                    let credential = OAuthProvider.credential(
                        withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
                    Auth.auth().signIn(with: credential) { (authResult, error) in
                        if let error = error {
                            print(error.localizedDescription)
                            completion(false)
                            return
                        }
                        print("signed in")
                        completion(true)
                    }

                default:
                    completion(false)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
        }
}
  
