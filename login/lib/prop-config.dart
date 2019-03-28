

class prompts{
  static const String updateProfile = 'Update Profile';
  static const String updateYourProfile = 'Update Your Profile';
  static const String updateDoc = 'Documented Update';
  static const String login = 'Log In';
  static const String signup = 'Sign Up';
  static const String type_email = 'Please type and email';
  static const String email_verif = 'Email not Verified';
  static const String passwrd = 'Password';
  static const String passwrd_valid = 'Password must be longer than 6 characters';
  static const String email_err_1 = 'Your email has not been verified ';
  static const String email_err_2 = 'please click the verification link sent to ';
  static const String name = 'Enter Full Name';
}

class headers{
  static const String spotBuddy = 'SpotBuddy ';
  static const String buddies = 'Buddies';
  static const String profile = 'Profile';
  static const String username = 'Username';
  static const String email = 'Email';
  static const String close = 'Close';
  static const String resend = 'Resend link';
  static const String search = 'Search';
  static const String settings = 'Settings';

  static const String welcomePage = 'Welcome Page';
}

class path{
  static const String user = 'users';
}

class assets{
  static const String image = "assets/background.jpg";
}

class user_info{
  static const String fullName = 'Full Name';
  static const String age = 'Age';
  static const String gender = 'Gender';
  static const String gender0 = 'Male';
  static const String gender1 = 'Female';
  static const String gender2 = 'Other';

  static const String occupation = 'Occupation';
  static const String mobileNumber = 'Mobile Number';
  static const String update = 'Update';


}

class pattern{
  static const String integers = r'(^[0-9]*$)';
  static const String characters = r'(^[a-z]*$)';

}

class requirements{
  static const String name = 'Name is Required';
  static const String range = 'Name must be a-z and A-Z';
  static const String age = 'Age is Required';
  static const String age_valid = 'Age must be digits';
  static const String gender = 'Gender is required';
  static const String gender_valid = 'Gender must be a-z and A-Z';

  static const String occupation = 'Occupation is Required';
  static const String occupation_valid = 'Occupation must be a-z and A-Z';
  static const String mobile = 'Mobile is Required';
  static const String mobile_valid_1 = 'Mobile numbermust be 10 digits';
  static const String mobile_valid_2 = 'Mobile number must be digits';




}

class events{
  static const String login = 'login';
  static const String signup = 'signup';

  static const String update = 'toUpdateProfile';
  static const String profileUpdated = 'profile_updated';

  static const String profile = 'nav_to_proflie';
  static const String search = 'nav_to_search';
  static const String buddies = 'nav_to_buddies';
  static const String settings = 'nav_to_settings';

  static const String emailverif = 'email_verification';
  static const String login_success = 'login_successful';

  static const String new_signup = 'new_sign_up';

  static const String searching = 'searching';
  static const String to_settings = 'to_settings';

  static const String to_buddies = 'to_buddies';
}

class screens{
  static const String welcome = 'welcome_page';
  static const String welcomeOver = 'WelcomePage';

  static const String profile = 'profile_page';
  static const String profileOver = 'ProfileOver';

  static const String updateProfile = 'update_profile_page';
  static const String updateOver = 'UpdateProfileOver';

  static const String login = 'login_page';
  static const String loginOver = 'Login_Over';

  static const String signup = 'signup_page';
  static const String signupOver = 'Signup_Over';

  static const String search = 'search_page';
  static const String searchOver = 'SearchOver';

  static const String buddies = 'buddies_page';
  static const String buddiesOver = 'BuddiesOver';

  static const String settings = 'settings_page';
  static const String settingsOver = 'SettingsOver';
}