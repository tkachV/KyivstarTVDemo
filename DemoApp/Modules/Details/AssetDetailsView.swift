//
//  AssetDetailsView.swift
//  DemoApp
//
//  Created by Vlad Tkach on 17.08.2024.
//

import Foundation
import SwiftUI
import Combine
import SDWebImageSwiftUI

enum AssetDetailsViewHostingAction {
    case dismiss
}

enum AssetDetailsViewEvent {
    case viewAppear
}

struct AssetDetailsView: View {
    
    enum State {
        case idl
        case loading
        case loaded(AssetDetailsModel)
        case error(Error)
    }

    let asset: ContentGroup.Asset
    
    //uses for output actions with hosting controller subclass
    let hostingOutputSubject = PassthroughSubject<AssetDetailsViewHostingAction, Never>()

    @StateObject var viewModel: AssetDetailsViewModel = AssetDetailsViewModel()
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .loaded(let assetDetails):
                AssetDetailsContentView(model: assetDetails, hostingOutputSubject: hostingOutputSubject)
            case .error(let error):
                VStack {
                    Text(error.localizedDescription)
                    Button("Exit") {
                        hostingOutputSubject.send(.dismiss)
                    }
                }
            case .idl:
                Text("Idl")
            }
        }.onAppear(perform: {
            viewModel.asset = asset
            viewModel.viewEventSubject.send(.viewAppear)
        })
    }
}

struct AssetDetailsContentView: View {
    
    let model: AssetDetailsModel
    let hostingOutputSubject: PassthroughSubject<AssetDetailsViewHostingAction, Never>
    
    var body: some View {
        VStack {
            imageSection()
            buttonsSection()
            Divider()
                .padding([.leading, .trailing])
            
            textSection()
            similarSection()
        }
    }
}

extension AssetDetailsContentView {
    private func imageSection() -> some View {
        ZStack(alignment: .topLeading){
            WebImage(url: URL(string: model.image)) { image in
                image.resizable()
            } placeholder: {
                Rectangle().foregroundColor(.gray)
            }
            .resizable()
            .scaledToFit()
            Button {
                hostingOutputSubject.send(.dismiss)
            } label: {
                Image(uiImage: UIImage(resource: ImageResource.assetDetailsBack))
            }
            .frame(width: 40.0, height: 40.0).offset(x: 24.0, y: 4.0)
        }
    }
    
    private func buttonsSection() -> some View {
        HStack {
            Button(action: { }) {
                HStack {
                    Image(systemName: "play.fill")
                        .foregroundColor(.white)
                    Text("Play")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }.buttonStyle(CustomButtonStyle(backgroundColor: Color(red: 0/255, green: 99/255, blue: 198/255),
                                            strokeColor: Color(red: 34/255, green: 159/255, blue: 255/255)))
            .frame(width: 129, height: 40)
            
            Spacer()
            
            Button(action: { }) {
                Image(systemName: "star.fill")
                    .foregroundColor(Color(red: 49/255, green: 61/255, blue: 84/255))
            }.buttonStyle(CustomButtonStyle(backgroundColor: Color(red: 233/255, green: 231/255, blue: 231/255),
                                            strokeColor: Color(red: 254/255, green: 254/255, blue: 254/255)))
            .frame(width: 66.0, height: 40.0)
        }
        .padding(EdgeInsets.init(top: 12.0, leading: 24.0, bottom: 12.0, trailing: 24.0))
    }
    
    private func textSection() -> some View {
        VStack(alignment: .leading) {
            Text(model.name.isEmpty ? "The SpongeBob Movie: Sponge on the Run" : model.name)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
            Spacer(minLength: 12.0)
            Text(model.moviewGenreString + " • " + model.durationString + " • " + model.releaseYearString)
                .font(.body)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
            Spacer(minLength: 12.0)
            Text(model.description)
                .font(.subheadline)
                .fontWeight(.regular)
                .multilineTextAlignment(.leading)
        }
        .padding(EdgeInsets.init(top: 12.0, leading: 23.0, bottom: 12.0, trailing: 23.0))//leading/trailing design 24 - not work correctly, visual better 23 ???
    }
    
    private func similarSection() -> some View {
        VStack(alignment: .leading) {
            Text("Similar")
                .font(.title2)
                .fontWeight(.bold)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 104))]) {
                ForEach(model.similar, id: \.self) { item in
                    ZStack(alignment: .topLeading){
                        WebImage(url: URL(string: item.image)) { image in
                            image.resizable()
                        } placeholder: {
                            Rectangle()
                                .foregroundColor(.gray)
                        }
                        .resizable()
                        .scaledToFit()
                        Group {
                            if !item.purchased {
                                Image.init(.homeVideoLocked)
                                    .frame(width: 24.0, height: 24.0).offset(x: 8.0, y: 8.0)
                            }
                            if item.progress != 0 {
                                ProgressView(value: Double(item.progress)/100.0)
                                    .frame(height: 4.0).offset(y: 152.0)
                            }
                        }
                    }.scaledToFit()
                    .frame(height: 156.0)
                    .cornerRadius(12.0)
                }
            }
        }.padding(EdgeInsets.init(top: 12.0, leading: 24.0, bottom: 12.0, trailing: 24.0))
    }
}

struct CustomButtonStyle: ButtonStyle {
    
    let backgroundColor: Color
    let strokeColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            let offset: CGFloat = 2
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(backgroundColor)
                .offset(y: offset)
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(backgroundColor)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(strokeColor, lineWidth: 1))
                .offset(y: configuration.isPressed ? offset : 0)
            configuration.label
                .offset(y: configuration.isPressed ? offset : 0)
                .compositingGroup()
                .shadow(radius: 6, y: 4)
        }
    }
}

