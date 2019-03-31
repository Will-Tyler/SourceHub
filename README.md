# SourceHub

**Will Tyler** and **Yong Dong**

A GitHub client application built for iOS.

<img src='Sprint1.gif' width='' alt='Video Walkthrough' />

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

#### Existing API Endpoints
##### GitHub API
- Base URL - [https://api.github.com](https://api.github.com)

HTTP Verb | Endpoint | Description
----------|----------|------------
`POST`    | /authorizations | Create a new authorization
`GET`    | /users/:username/received_events | Get the user's events
`GET`    | /user | Retrieve the information about the authenticated user
`GET`    | /user/repos | Get the user's repositories.
`GET`    | /repos/:owner/:repo/contents/:path | Get the contents of a repository or directory
