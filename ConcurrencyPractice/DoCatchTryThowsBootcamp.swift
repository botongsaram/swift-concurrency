//
//  DoCatchTryThowsBootcamp.swift
//  CountdownRobin
//
//  Created by Seung Eun Lee on 8/11/24.
//

import SwiftUI

// do-catch
// try
// throws

class DoCatchTryThowsBootcampDataManager {
    
    let isActive: Bool = true
    
    func getTitle() -> (title: String?, error: Error?) {
        if isActive {
            return ("New Text", nil)
        } else {
            return (nil, URLError(.badURL))
        }
    }
    
    func getTitle2() -> Result<String, Error> {
        if isActive {
            return.success("New Text")
        } else {
            return .failure(URLError(.appTransportSecurityRequiresSecureConnection))
        }
    }
    
    func getTitle3() throws -> String {
        if isActive {
            //return "NEW TEXT!"
            throw URLError(.badURL)
        } else {
            throw URLError(.badURL)
        }
    }
    
    func getTitle4() throws -> String {
        if isActive {
            return "Final TEXT!"
        } else {
            throw URLError(.badServerResponse)
        }
    }
}

class DoCatchTryThowsBootcampViewModel: ObservableObject {
    @Published var text: String = "Strating test."
    let manager = DoCatchTryThowsBootcampDataManager()
    
    func fetchTitle(){
//        let returnedVal = manager.getTitle()
//        if let newTitle = returnedVal.title {
//            self.text = newTitle
//        } else if let err = returnedVal.error {
//            self.text = err.localizedDescription
//        }
        
//        let result = manager.getTitle2()
//        switch result {
//        case .success(let newTitle):
//            self.text = newTitle
//        case .failure(let error):
//            self.text = error.localizedDescription
//        }
//
        
//        let newTitle = try? manager.getTitle3()
//        if let newTitle = newTitle {
//            self.text = newTitle
//        }
        do {
            let newTitle = try? manager.getTitle3()
            if let newTitle = newTitle {
               self.text = newTitle
            }
            
            let finalText = try manager.getTitle4()
            self.text = finalText
            
        } catch let error {
            self.text = error.localizedDescription
        }
    }
}

struct DoCatchTryThowsBootcamp: View {
    @StateObject private var viewModels = DoCatchTryThowsBootcampViewModel()
    var body: some View {
        Text(viewModels.text)
            .frame(width: 300, height: 300)
            .background(.blue)
            .onTapGesture {
                viewModels.fetchTitle()
            }
    }
}

#Preview {
    DoCatchTryThowsBootcamp()
}
