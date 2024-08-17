//
//  AsyncAwaitBootcamp.swift
//  CountdownRobin
//
//  Created by Seung Eun Lee on 8/12/24.
//

import SwiftUI
import Foundation

class AsyncAwaitBootcampViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func addTitle1() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dataArray.append("Title1 : \(Thread.current)")
        }
    }
    
    func addTitle2() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let title = "Title2 : \(Thread.current)"
            DispatchQueue.main.async {
                self.dataArray.append(title)
                
                let title3 = "Title3 : \(Thread.current)"
                self.dataArray.append(title3)
            }
        }
    }
    
    func addAuthor1() async {
        let author1 = "Author1 : \(Thread.current)"
        self.dataArray.append(author1)
        
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        let author2 = "Author2 : \(Thread.current)"
        
        await MainActor.run {
            self.dataArray.append(author2)
            
            let author3 = "Author3 : \(Thread.current)"
            self.dataArray.append(author3)
        }
        await try? await addSomething()
    }
    
    func addSomething() async {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        let sth1 = "Something1 : \(Thread.current)"
        
        await MainActor.run {
            self.dataArray.append(sth1)
            
            let sth2 = "Something2 : \(Thread.current)"
            self.dataArray.append(sth2)
        }
    }
}

struct AsyncAwaitBootcamp: View {
    @StateObject private var viewModel = AsyncAwaitBootcampViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.dataArray, id: \.self) { data in
                Text(data)
            }
        }
        .onAppear {
//            viewModel.addTitle1()
//            viewModel.addTitle2()
            Task {
                await viewModel.addAuthor1()
                
                let finalText = "Final text : \(Thread.current)"
                viewModel.dataArray.append(finalText)
            }
        }
    }
}

#Preview {
    AsyncAwaitBootcamp()
}
