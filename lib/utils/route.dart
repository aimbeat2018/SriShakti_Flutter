import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:oxoo/screen/content_by_star_screen.dart';
import '../../screen/all_country_screen.dart';
import '../../screen/content_country_based_screen.dart';
import '../../screen/downloads_screen.dart';
import '../../screen/favourite_screen.dart';
import '../../screen/genre_screen.dart';
import '../../screen/landing_screen.dart';
import '../../screen/live_tv_screen.dart';
import '../../screen/movie_by_genere_id.dart';
import '../../screen/movie_screen.dart';
import '../../screen/movie/movie_details_screen.dart';
import '../../screen/movie/movie_reply_screen.dart';
import '../../screen/movies_by_star_id.dart';
import '../../screen/pass_reset_screen.dart';
import '../../screen/phon_auth_screen.dart';
import '../../screen/subscription/premium_subscription_screen.dart';
import '../../screen/tv_series_screen.dart';
import '../../screen/auth/auth_screen.dart';
import '../../screen/auth/signIn_screen.dart';
import '../../screen/auth/sign_up_screen.dart';
import '../../screen/profile/my_profile_screen.dart';
import '../../screen/settings_screen.dart';
import '../../screen/subscription/my_subscription_screen.dart';
import '../../screen/terms_polices.dart';
import '../../server/phone_auth_repository.dart';
import '../../widgets/live_tv/live_tv_channels_card.dart';
import '../app.dart';
import '../screen/auth/splash_screen.dart';

class Routes {
  static final userRepository = UserRepository(firebaseAuth: FirebaseAuth.instance);

  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      SplashScreen.route: (_) => SplashScreen(),
      LoginPage.route: (_) => LoginPage(),
      SignUpScreen.route: (_) => SignUpScreen(),
      AuthScreen.route: (_) => AuthScreen(),
      MoviesScreen.route: (_) => MoviesScreen(),
      MoviesScreenByGenereID.route: (_) => MoviesScreenByGenereID(),
      MoviesScreenByStarID.route: (_) => MoviesScreenByStarID(),
      TvSeriesScreen.route: (_) => TvSeriesScreen(),
      LiveTvScreen.route: (_) => LiveTvScreen(),
      GenreScreen.route: (_) => GenreScreen(),
      AllCountryScreen.route: (_) => AllCountryScreen(),
      MyProfileScreen.route: (_) => MyProfileScreen(),
      SettingScreen.route: (_) => SettingScreen(),
      MySubscriptionScreen.route: (_) => MySubscriptionScreen(),
      FavouriteScreen.route: (_) => FavouriteScreen(),
      PremiumSubscriptionScreen.route: (_) => PremiumSubscriptionScreen(),
      ContentCountryBasedScreen.route: (_) => ContentCountryBasedScreen(),
      MovieReplyScreen.route: (_) => MovieReplyScreen(),
      MovieDetailScreen.route: (_) => MovieDetailScreen(),
      TermsPolices.route: (_) => TermsPolices(),
      PhoneAuthScreen.route: (_) => PhoneAuthScreen(
            userRepository: userRepository,
          ),
      LiveTvChannelsCard.route: (_) => LiveTvChannelsCard(),
      LandingScreen.route: (_) => LandingScreen(),
      DownloadScreen.route: (_) => DownloadScreen(),
      MyApp.route: (_) => MyApp(),
      RenderFirstScreen.route: (_) => RenderFirstScreen(),
      ResetPassword.route: (_) => ResetPassword(),
      ContentByStarScreen.route: (_) => ContentByStarScreen(),
    };
  }
}
