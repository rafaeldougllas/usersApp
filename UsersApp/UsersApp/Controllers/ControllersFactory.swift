//
//  ControllersFactory.swift
//  UsersApp
//
//  Created by Rafael Douglas Sousa Barreto Dos Santos on 13/04/23.
//

import Foundation

final class ControllersFactory {
    
    static func makeUsersVC(coordinator: UsersCoordinatorProtocol) -> UsersVC {
        let httpClient = HttpClient(service: URLSession.shared)
        let usersUseCase = UsersUseCase(client: httpClient)
        let usersViewModel = UsersViewModel(usersUseCase: usersUseCase)
        usersViewModel.coordinator = coordinator
        let usersView = UsersView()
        let usersVC = UsersVC(usersView: usersView,
                              viewModel: usersViewModel)
        return usersVC
    }
    
    static func makeUserDetailVC(coordinator: UsersCoordinatorProtocol,
                                 user: UserProfile) -> UserDetailVC {
        let userDetailView = UserDetailView()
        let userDetailViewModel = UserDetailViewModel(user: user)
        userDetailViewModel.coordinator = coordinator
        let userDetailVC = UserDetailVC(userDetailView: userDetailView,
                                        userDetailViewModel: userDetailViewModel)
        return userDetailVC
    }
    
    static func makeFavoritesVC(coordinator: FavoritesCoordinatorProtocol) -> FavoritesVC {
        let favoritesView = FavoritesView()
        let favoritesViewModel = FavoritesViewModel()
        favoritesViewModel.coordinator = coordinator
        let favoritesVC = FavoritesVC(favoritesView: favoritesView,
                                      viewModel: favoritesViewModel)
        return favoritesVC
    }
    
    static func makeAboutMeVC(coordinator: AboutMeCoordinatorProtocol) -> AboutMeVC {
        let aboutMeView = AboutMeView()
        let aboutMeViewModel = AboutMeViewModel()
        aboutMeViewModel.coordinator = coordinator
        let aboutMeVC = AboutMeVC(aboutMeView: aboutMeView,
                                  aboutMeViewModel: aboutMeViewModel)
        return aboutMeVC
    }
}
