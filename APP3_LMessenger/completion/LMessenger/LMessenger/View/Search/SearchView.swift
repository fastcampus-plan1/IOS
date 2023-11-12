//
//  SearchView.swift
//  LMessenger
//
//

import SwiftUI

struct SearchView: View {
    @Environment(\.managedObjectContext) var objectContext
    @StateObject var viewModel: SearchViewModel
    @AccessibilityFocusState var isSearchBarFocused: Bool
    
    var body: some View {
        VStack {
            topView
            
            if viewModel.searchResults.isEmpty {
                RecentSearchView { text in
                    viewModel.send(action: .setSearchText(text))
                    isSearchBarFocused = true
                }
            } else {
                List {
                    ForEach(viewModel.searchResults) { result in
                        HStack(spacing: 8) {
                            URLImageView(urlString: result.profileURL)
                                .frame(width: 26, height: 26)
                                .clipShape(Circle())
                            Text(result.name)
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.bkText)
                        }
                        .listRowInsets(.init())
                        .listRowSeparator(.hidden)
                        .padding(.horizontal, 30)
                    }
                }
                .listStyle(.plain)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
    }
    
    var topView: some View {
        HStack(spacing: 0) {
            Button {
                viewModel.send(action: .pop)
            } label: {
                Image("back_search", label: Text("뒤로가기"))
            }

            SearchBar(text: $viewModel.searchText,
                      shouldBecomeFirstResponder: $viewModel.shouldBecomeFirstResponder) {
                setSearchResultWithContext()
            }
            .accessibilityFocused($isSearchBarFocused)
            
            Button {
                viewModel.send(action: .clearSearchText)
            } label: {
                Image("close_search",label: Text("검색 취소"))
            }
        }
        .padding(.horizontal, 20)
    }
    
    func setSearchResultWithContext() {
        let result = SearchResult(context: objectContext)
        result.id = UUID().uuidString
        result.name = viewModel.searchText
        result.date = Date()
        
        try? objectContext.save()
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: .init(container: .stub, userId: "user1_id"))
    }
}
