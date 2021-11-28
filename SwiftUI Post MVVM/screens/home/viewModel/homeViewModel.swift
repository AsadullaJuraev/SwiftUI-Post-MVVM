//
//  homeViewModel.swift
//  SwiftUI Post MVVM
//
//  Created by Asadulla Juraev on 28/11/21.
//

import Foundation

class homeViewModel: ObservableObject{
    
    @Published var isLoading = false
    @Published var post = [Post]()
    
    func apiPostList() {
        self.isLoading = true
        AFHttp.get(url: AFHttp.API_POST_LIST, params: AFHttp.paramsEmpty()) { response in
            self.isLoading = false
            switch response.result {
            case .success:
                let posts = try! JSONDecoder().decode([Post].self, from: response.data!)
                self.post = posts
                
            case let .failure(error):
                print(error)
                self.post = [Post]()
            }
        }
    }
    
    func apiPostDelete(post: Post, completion: @escaping (Bool) -> Void) {
        self.isLoading = true
        AFHttp.del(url: AFHttp.API_POST_DELETE + post.id!, params: AFHttp.paramsEmpty(), handler: { response in
            self.isLoading = false
            switch response.result {
            case .success:
                print(response.result)
                completion(true)
            case let .failure(error):
                print(error)
                completion(false)
            }
        })
    }
}
