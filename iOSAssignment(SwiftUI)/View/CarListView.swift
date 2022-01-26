//
//  ContentView.swift
//  iOSAssignment(SwiftUI)
//
//  Created by Alex Yang on 2022-01-26.
//

import SwiftUI

struct CarListView: View {
    
    @StateObject var viewModel: CarListViewModel = CarListViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.items) { item in
                itemCell(item)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .onAppear(perform: viewModel.fetchCars)
    }
}


extension CarListView {
    
    @ViewBuilder
    fileprivate func itemCell(_ item: CarListItem) -> some View {
        VStack(alignment: .leading) {
            if let url = item.listingImageUrl, let data = try? Data(contentsOf: url) {
                Image(uiImage: UIImage(data: data) ?? UIImage())
                    .resizable()
                    .cornerRadius(Constants.cornerRadius)
                    .frame(maxWidth: .infinity, maxHeight: Constants.imageHeight)
                    .scaledToFill()
            } else {
                Image("Default_Image")
                    .resizable()
                    .cornerRadius(Constants.cornerRadius)
                    .frame(maxWidth: .infinity, maxHeight: Constants.imageHeight)
                    .scaledToFill()
            }
            //            AsyncImage(url: item.listingImageUrl) { phase in
            //                            switch phase {
            //                            case .success(let image):
            //                                image.resizable()
            //                                     .aspectRatio(contentMode: .fit)
            //                            case .empty, .failure:
            //                                Image("Default_Image")
            //                                    .resizable()
            //                            @unknown default:
            //                                Image("Default_Image")
            //                                    .resizable()
            //                            }
            //                        }
            //            .cornerRadius(Constants.cornerRadius)
            //            .frame(maxWidth: .infinity, maxHeight: Constants.imageHeight)
            //            .scaledToFill()
            HStack{
                VStack(alignment:.leading) {
                    Text("\(String(item.year)) \(item.make) \(item.model) \(item.trim)")
                    HStack {
                        Text("$\(Int(item.listPrice))")
                        Text("|")
                        Text("\(item.mileageStr) Mi")
                        Text("|")
                        Text("\(item.dealer.city),")
                        Text(item.dealer.state)
                    }
                }
                .lineLimit(1)
                
                Spacer()
                
                Button {
                    phoneCall(item.dealer.phone)
                } label: {
                    Image(systemName: "phone")
                        .font(.system(size: 30))
                }
                .padding()
                .foregroundColor(.white)
                .background(.cyan)
                .cornerRadius(Constants.cornerRadius)
                .buttonStyle(.plain)
            }
            
        }
    }
    
    private func phoneCall(_ number: String) {
        let telephone = "tel://\(number)"
        guard let url = URL(string: telephone) else { return }
        UIApplication.shared.open(url)
    }
    
    
    private struct Constants {
        static let cornerRadius: CGFloat = 8
        static let imageHeight: CGFloat = 240
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CarListView()
    }
}
