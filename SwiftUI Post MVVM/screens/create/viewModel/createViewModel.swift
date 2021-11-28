//
//  createViewModel.swift
//  SwiftUI Post MVVM
//
//  Created by Asadulla Juraev on 28/11/21.
//

import Foundation

class createViewModel: ObservableObject{
    @Published var isLoading = false
    
    func apiCreatePost(post: Post, completion: @escaping (Bool) -> Void) {
        self.isLoading = true
        AFHttp.post(url: AFHttp.API_POST_CREATE, params: AFHttp.paramsPostCreate(post: post)) { response in
            self.isLoading = false
            switch response.result {
            case .success:
                print("SUCCESS")
                completion(true)
            case let .failure(error):
                print(error)
                completion(false)
            }
        }
    }
}
