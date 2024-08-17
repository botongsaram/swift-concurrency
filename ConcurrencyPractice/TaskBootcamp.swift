//
//  TaskBootcamp.swift
//  CountdownRobin
//
//  Created by Seung Eun Lee on 8/16/24.
//
import Foundation
import SwiftUI

class TaskBootcampViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var image2: UIImage? = nil
    
    func fetchImage() async {
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        do {
            guard let url = URL(string: "https://picsum.photos/200") else { return }
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            await MainActor.run {
                self.image = UIImage(data: data)
                print("Image Returned")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchImage2() async {
        do {
            guard let url = URL(string: "https://picsum.photos/200") else { return }
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            await MainActor.run {
                self.image2 = UIImage(data: data)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct TaskBootcampHomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink("Click Me!!") {
                    TaskBootcamp()
                }
            }
        }
    }
}

struct TaskBootcamp: View {
    
    @StateObject private var viewModel = TaskBootcampViewModel()
    @State private var fetchImageTask: Task<(), Never>? = nil
    
    var body: some View {
        VStack(spacing: 40) {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            if let image2 = viewModel.image2 {
                Image(uiImage: image2)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .task {
            await viewModel.fetchImage()
            await viewModel.fetchImage2()
        }
//        .onDisappear {
//            fetchImageTask?.cancel()
//        }
//        .onAppear {
//            fetchImageTask = Task {
//                print("IMAGE1: \(Task.currentPriority)")
//                await viewModel.fetchImage()
//            }
//            Task {
//                print("IMAGE2: \(Task.currentPriority)")
//                await viewModel.fetchImage2()
//            }
//        }
    }
}

#Preview {
    TaskBootcamp()
}
