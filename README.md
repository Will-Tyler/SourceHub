# SourceHub

**Will Tyler** and **Yong Dong**

A GitHub client application built for iOS.

## 1. User Stories (Required and Optional)

**Required Must-have Stories**

 * The user is able to sign in using their GitHub account.
 * The user is able to view their GitHub feed.
 * The user can view a profile page, highlighting information about their repositories and contributions.
 * The user sees their profile picture in the profile page.
 * The user sees their GitHub username in the profile page.
 * The user can view their personal repositories.
 * The user is able to browse the content in the repositories, including browsing the source code.

**Optional Nice-to-have Stories**

 * The user can register a GitHub account in the application.
 * The user is able to edit the source code in the application.
 * The user can create a pull request within the application.
 * When a user selects a directory, instead of opening a new view controller, the application displays content of the directory in a dropdown.
 * The application will have a dark theme option.

## 2. Screen Archetypes

 * Feed
 	* The user is able to view their GitHub feed.
 * Profile
 	* The user can view a profile page, highlighting information about their repositories and contributions.
	* The user sees their profile picture in the profile page.
	* The user sees their GitHub username in the profile page.
 * Repository
 	* The user is able to browse the content in the repositories, including browsing the source code.
 * Sign In
 	* The user is able to sign in using their GitHub account.
 * Content
 	* The user is able to browse the content in the repositories, including browsing the source code.
 * File
 	* The user is able to browse the content in the repositories, including browsing the source code.

## 3. Navigation

**Tab Navigation** (Tab to Screen)

 * Feed
 	* Repository
 * Profile
 	* Repository

**Flow Navigation** (Screen to Screen)

 * Repository
 	* Content
 * SignIn
 	* Feed
 * Content
 	* File
	* Content

## Schema 
### Models
#### AuthenticatedUser
```swift
struct AuthenticatedUser: Codable {

let login: String
let id: Int
let avatarURL: URL
let reposURL: URL
let name: String
let email: String
let bio: String

}
```

#### Owner
```swift
struct Owner: Codable {

let login: String
let id: Int
let url: String
let reposURL: URL

}
```

#### Repository
```swift

struct Repository: Codable {

let id: Int
let nodeID: String
let name: String
let fullName: String
let owner: Owner
let isPrivate: Bool
let description: String
let isFork: Bool
let url: URL
let defaultBranch: String

}
```

### Networking
#### List of network requests by screen
- Feed Screen
	- (GET) Get user's events when application is opened.
- Profile Screen
	- (GET) Basic information about the current user.
- Repository Screen
	- (GET) Retrieve the directories and files belonging to a repository.
- Sign In Screen
	- (POST) Create an authorization to create an auth token and gain access to the user's information.
- Content Screen
	- (GET) Retrieve the directories and files in a repository.
- File Screen
	- (GET) Retrieve the contents of the file

#### [OPTIONAL:] Existing API Endpoints
##### An API Of Ice And Fire
- Base URL - [http://www.anapioficeandfire.com/api](http://www.anapioficeandfire.com/api)

HTTP Verb | Endpoint | Description
----------|----------|------------
`GET`    | /characters | get all characters
`GET`    | /characters/?name=name | return specific character by name
`GET`    | /houses   | get all houses
`GET`    | /houses/?name=name | return specific house by name

##### Game of Thrones API
- Base URL - [https://api.got.show/api](https://api.got.show/api)

HTTP Verb | Endpoint | Description
----------|----------|------------
`GET`    | /cities | gets all cities
`GET`    | /cities/byId/:id | gets specific city by :id
`GET`    | /continents | gets all continents
`GET`    | /continents/byId/:id | gets specific continent by :id
`GET`    | /regions | gets all regions
`GET`    | /regions/byId/:id | gets specific region by :id
`GET`    | /characters/paths/:name | gets a character's path with a given name
