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
