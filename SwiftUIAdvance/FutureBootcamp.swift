//
//  FutureBootcamp.swift
//  SwiftUIAdvance
//
//  Created by Khanh Nguyen on 14/9/25.
//

import SwiftUI
import Combine

//download with combine
//download with @escaping closure
// convert @escaping closure to combine

class FutureBootcampViewModel: ObservableObject {
    @Published var title: String = "Start title"
    let url = URL(string: "https://www.google.com")
    var canclelables = Set<AnyCancellable>()
    
    init() {
        download()
    }
     
    func download() {
//        getEscapingClosure { [weak self] value, error in
//            self?.title = value
//        }
        
//        getCombinePublisher()
//            .sink { completion in
//                switch completion {
//                case .finished:
//                    print("finished")
//                case .failure(let error):
//                    print("he he")
//                }
//            } receiveValue: { [weak self] returnValue in
//                self?.title = returnValue
//            }
//            .store(in: &canclelables)
        
        getFuturePublisher().sink { completion in
            
        } receiveValue: { [weak self] returnValue in
            self?.title = returnValue
        }
        .store(in: &canclelables)
        // In combine sink and also other operator return to AnyCancellable, if we don't keep reference to AnyCancellable, it will be deallocated right after it created, so when subscription is canceled(deallocated), publisher will stop email the event and UI will not update


    }
    
    func getCombinePublisher() -> AnyPublisher<String, URLError> {
        URLSession.shared.dataTaskPublisher(for: url!)
            .timeout(1, scheduler: DispatchQueue.main)
            .map { _ in
                return "new value"
            }
            .eraseToAnyPublisher()
    }
    
    func getEscapingClosure(
        completationHandler: @escaping(_ value: String, _ error: Error?) -> Void
    ){
        URLSession.shared.dataTask(with: url!) { data, response, error in
            completationHandler("New value 2", nil)
        }
        .resume()
    }
    
    func getFuturePublisher() -> Future<String, Error> {
        Future { promise in
            self.getEscapingClosure { value, error in
                if let error = error {
                    promise(.failure(error))
                }else {
                    promise(.success(value))
                }
            }
        }
    }
}

struct FutureBootcamp: View {
    @StateObject private var viewModel = FutureBootcampViewModel()
    var body: some View {
        Text(viewModel.title)
    }
}

#Preview {
    FutureBootcamp()
}
