<p align="center">
  <img width="250" height="150" src="https://github.com/adrsh-23/ChallengeTillFIT/blob/Dev/assets/logo.PNG">
</p>

# ChallengeTillFIT

### Simple and elegant social app to maintain your healthy lifestyle.!

## Tracks
  * Social Good
  * Fun and Entertainment
  * Open Innovation

## Problem it Solves
  Health is defined as a state of physical, mental, and social well being and not merely physical well being.
  Health and fitness go hand in hand but with this fast moving world people are becoming more and more ignorant towards fitness and health.

  Our app is our initiative to again make this society fit and promote good deeds in society in a very fun and exciting way.
  It is a social media app where user can challenge  other users to perform challenges that can bring a positive change in their life and to the people around them.
  The main crisp of adding challenges in this app is to make people compete with each other in order to maintain their health.
  
  ```
  competing + health + friends = FUN 
  ```
  
  Through this app people can share their day to day activities they do which in turn achieves them a fit and healthy lifestyle.
  It also spreads awareness about health, well being, fitness , care towards nature and fellow beings.
  The major goal of our app is to tell the people that even a small step today can lead to a happy and healthy tomorrow. 

## Features
  * Provides features like Social Media app
  * User can challenge other users 
  * User can post their accomplishments and good deeds
  * Standard Login/SignUp 
  * Users can search globally other users
  * Easy UI/UX
  
## Challenges We Faced

  *  In order to connect to the backend i.e Firebase we had to provide the sha-256 but due to internal error we had to switch to traditional login and signup instead of google sign up.
  *  The overall responsiveness of the app had to be handled due to multiple devices being used to debug (Used Media query in order for responsiveness)
  *  Data from the firebase was not being retrieved due to firestore rules being different (changed firestore rules i.e if auth.user!=null access granted)
  *  Multiple Flutter packages were causing inter-dependancy issues (Tried each package combination to get the optimal versioning)
  *  Sign up page was first loading the homepage rather than signing in first (asynchronous function was used)
  *  Data being retrived late due to poor internet connectivity caused null error (added circular progress indicator)
  *  Notifications page had to be refreshed in order for new notifications to be shown (Stream builder was used which dynamically checks for updates)
  *  Pixels overflow in profile and dashboard page (Media Query Used)
  *  In order to accept the users challenge, the document's id was not being retrieved causing this feature to bug out. (Current index of the listview was used in order to execute the complete function)


## Technologies Used
  * Flutter
  * Dart
  * Firebase
  * Android Studio
  * Git

## App Demo Link
####  [Click Here!](https://drive.google.com/file/d/1ocmutfSGEnEuONXqmM4BuM1DAKNDzl_n/view?usp=sharing)
