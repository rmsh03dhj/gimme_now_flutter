# Gimme Now

This is a mobile application developed using Flutter Framework. I have followed [flutter clean TDD architecture](https://pub.dev/packages/flutter_clean_architecture) and used [flutter bloc](https://pub.dev/packages/flutter_bloc) for state management.

The main thing I wanted to show case here is integrating AWS services for user authenication. I have used [amazon_cognito_identity_dart_2](https://pub.dev/packages/amazon_cognito_identity_dart_2) third party library for it.

For project demo, I have attached a video below.
<p align="center">
<img src="gimme_now.gif" width="220" height="450"/>
</p>

## Short Description
This app can create a user in aws congito using email address which can be used for authentication. When user signs up, he will receive an confirmation code on that email address. Then user can enter the code and sign up successfully.

Once sign up is successful, then user can use it for signing in when required. 