//
//  Post.swift
//  SwiftUI Post MVVM
//
//  Created by Asadulla Juraev on 28/11/21.
//

import Foundation

struct Post: Decodable{
    var id: String? = ""
    var title: String? = ""
    var body: String? = ""
    
    init(){
        
    }
    
    init(title: String, body: String){
        self.title = title
        self.body = body
    }
}
