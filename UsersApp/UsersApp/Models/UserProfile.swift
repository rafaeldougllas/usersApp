//
//  UserProfile.swift
//  UsersApp
//
//  Created by Rafael Douglas on 17/12/22.
//

public struct UserProfile: Decodable {
    let id: Int
    let email: String
    let icon: String
    let firstName: String
    let lastName: String
    var isFavorite: Bool? = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case icon = "avatar"
        case firstName = "first_name"
        case lastName = "last_name"
    }
    
    public init(id: Int,
                email: String,
                icon: String,
                firstName: String,
                lastName: String,
                isFavorite: Bool? = false) {
        self.id = id
        self.email = email
        self.icon = icon
        self.firstName = firstName
        self.lastName = lastName
        self.isFavorite = isFavorite
    }
}
// MARK: Fixture
extension UserProfile {
    static func fixture(
        id: Int = 1,
        email: String = "email@gmail.com",
        icon: String = "https://reqres.in/img/faces/1-image.jpg",
        firstName: String = "Fake",
        lastName: String = "Junior",
        isFavorite: Bool? = false
    ) -> UserProfile {
        return .init(id: id,
                     email: email,
                     icon: icon,
                     firstName: firstName,
                     lastName: lastName)
    }
}
// MARK: Equatable
extension UserProfile: Equatable {
    public static func ==(lhs: UserProfile, rhs: UserProfile) -> Bool {
        return lhs.id == rhs.id &&
            lhs.firstName == rhs.firstName &&
            lhs.lastName == rhs.lastName &&
            lhs.icon == rhs.icon
    }
}
