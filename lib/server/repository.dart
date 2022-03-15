import 'dart:io';
import 'package:dio/dio.dart';
import '../../models/favourite_response_model.dart';
import '../../models/password_reset_model.dart';
import '../../models/rent_history_model.dart';
import '../../models/video_comments/ad_comments_model.dart';
import '../../models/video_comments/add_reply_model.dart';
import '../../models/video_comments/all_comments_model.dart';
import '../../models/all_package_model.dart';
import '../../models/video_comments/all_reply_model.dart';
import '../../models/content_by_country_model.dart';
import '../../models/country_list_model.dart';
import '../../models/events_details_model.dart';
import '../../models/favourite_model.dart';
import '../../models/genre_list_model.dart';
import '../../models/home_content.dart';
import '../../models/movie_details_model.dart';
import '../../models/password_set_model.dart';
import '../../models/search_result_model.dart';
import '../../models/all_live_tv_by_category.dart';
import '../../models/events_model.dart';
import '../../models/live_tv_details_model.dart';
import '../../models/movie_model.dart';
import '../../models/tv_connection_model.dart';
import '../../models/tv_series_details_model.dart';
import '../../models/user_details_model.dart';
import '../../models/user_model.dart';
import '../../network/api_configuration.dart';
import '../../utils/validators.dart';

class Repository {
  Dio dio = Dio();

  Future<AuthUser?> getLoginAuthUser(String email, String password) async {
    dio.options.headers = ConfigApi().getHeaders();
    FormData formData = new FormData.fromMap({"email": email, "password": password});
    try {
      final response = await dio.post("${ConfigApi().getApiUrl()}/login?", data: formData);
      AuthUser user = AuthUser.fromJson(response.data);
      if (user.status == 'success') {
        return user;
      } else {
        showShortToast(response.data['data']);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<AuthUser?> getRegistrationAuthUser({String? name, String? email, String? password}) async {
    dio.options.headers = ConfigApi().getHeaders();
    FormData formData = new FormData.fromMap({"email": email, "password": password, "name": name});
    try {
      final response = await dio.post("${ConfigApi().getApiUrl()}/signup", data: formData);
      print(response);
      print("Registration_aPI");
      AuthUser user = AuthUser.fromJson(response.data);
      if (user.status == 'success') {
        return user;
      } else {
        showShortToast(response.data['data']);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<AuthUser?> getFirebaseAuthUser({
    required String uid,
    String? email,
    String? phone,
  }) async {
    dio.options.headers = ConfigApi().getHeaders();
    FormData formData = new FormData.fromMap({
      "uid": uid,
      "email": email,
      "phone": phone,
    });
    try {
      final response = await dio.post("${ConfigApi().getApiUrl()}/firebase_auth", data: formData);
      AuthUser user = AuthUser.fromJson(response.data);
      if (user.status == 'success') {
        return user;
      } else {
        showShortToast(response.data['message']);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<ProfileDetailsModel?> userDetailsData({String? userID}) async {
    dio.options.headers = ConfigApi().getHeaders();
    try {
      final response = await dio.get("${ConfigApi().getApiUrl()}/user_details_by_user_id?id=$userID");
      if (response.statusCode == 200) {
        ProfileDetailsModel userDetailsModel = ProfileDetailsModel.fromJson(response.data);
        return userDetailsModel;
      }
    } catch (ex) {
      return null;
    }
  }

  Future<SubmitResponseModel?> setUserPassword({String? userID, String? password, String? firebaseAuthUid}) async {
    dio.options.headers = ConfigApi().getHeaders();
    FormData formData = FormData.fromMap({
      "user_id": userID,
      "password": password,
      "firebase_auth_uid": firebaseAuthUid,
    });
    try {
      final response = await dio.post("${ConfigApi().getApiUrl()}/set_password?id=$userID", data: formData);
      print(response);
      if (response.statusCode == 200) {
        SubmitResponseModel submitResponseModel = SubmitResponseModel.fromJson(response.data);
        return submitResponseModel;
      }
    } catch (ex) {
      return null;
    }
  }

  Future<PasswordResetModel?> passwordReset({String? userEmail}) async {
    dio.options.headers = ConfigApi().getHeaders();
    FormData formData = FormData.fromMap({"email": userEmail});
    try {
      final response = await dio.post("${ConfigApi().getApiUrl()}/password_reset", data: formData);
      print(response);
      if (response.statusCode == 200) {
        PasswordResetModel submitResponseModel = PasswordResetModel.fromJson(response.data);
        return submitResponseModel;
      }
    } catch (ex) {
      return null;
    }
  }

  Future<SubmitResponseModel?> userUpdateData({required ProfileDetailsModel profileDetailsModel, String? password, File? image}) async {
    dio.options.headers = ConfigApi().getHeaders();
    FormData formData = FormData.fromMap({
      "id": profileDetailsModel.userId,
      "name": profileDetailsModel.name,
      "email": profileDetailsModel.email,
      "phone": profileDetailsModel.phone,
      "current_password": password,
      "gender": profileDetailsModel.gender,
      "photo": image != null ? await MultipartFile.fromFile(image.path) : null,
    });
    try {
      final response = await dio.post("${ConfigApi().getApiUrl()}/update_profile", data: formData);
      if (response.statusCode == 200) {
        return SubmitResponseModel.fromJson(response.data);
      }
    } catch (ex) {
      return null;
    }
  }

  Future<List<MovieModel>?> getAllMovies(String pageNumber) async {
    dio.options.headers = ConfigApi().getHeaders();
    try {
      final response = await dio.get("${ConfigApi().getApiUrl()}/movies?page=$pageNumber");
      if (response.statusCode == 200) {
        MovieListModel mobilistModel = MovieListModel.fromJson(response.data);
        return mobilistModel.movieList;
      }
    } catch (ex) {
      print(ex.toString());
      return null;
    }
  }

  Future<List<MovieModel>?> getMovieByGenereID(String pageNumber, String? genereID) async {
    dio.options.headers = ConfigApi().getHeaders();
    try {
      final response = await dio.get("${ConfigApi().getApiUrl()}/content_by_genre_id?id=$genereID");
      if (response.statusCode == 200) {
        MovieListModel mobilistModel = MovieListModel.fromJson(response.data);
        return mobilistModel.movieList;
      }
    } catch (ex) {
      return null;
    }
  }

  Future<List<MovieModel>?> getMovieByStarID(String pageNumber, String? starId) async {
    dio.options.headers = ConfigApi().getHeaders();
    try {
      final response = await dio.get("${ConfigApi().getApiUrl()}/content_by_star_id?id=$starId&page=$pageNumber");
      if (response.statusCode == 200) {
        MovieListModel mobilistModel = MovieListModel.fromJson(response.data);
        return mobilistModel.movieList;
      }
    } catch (ex) {
      return null;
    }
  }

  Future<LiveTVListModel?> getAllLiveTV() async {
    dio.options.headers = ConfigApi().getHeaders();
    try {
      final response = await dio.get("${ConfigApi().getApiUrl()}/all_tv_channel_by_category");
      if (response.statusCode == 200) {
        LiveTVListModel liveTVListModel = LiveTVListModel.fromJson(response.data);
        return liveTVListModel;
      } else {
        return null;
      }
    } catch (e) {
      print("-----------Error from getAllLiveTV: " + e.toString());
      return null;
    }
  }

  Future<LiveTvDetailsModel?> getLiveTVDetailsData({String? liveTvId, String? userId}) async {
    try {
      dio.options.headers = ConfigApi().getHeaders();
      final response = await dio.get("${ConfigApi().getApiUrl()}/single_details?type=tv&id=$liveTvId&user_id=$userId");
      if (response.statusCode == 200) {
        LiveTvDetailsModel liveTvDetailsModel = LiveTvDetailsModel.fromJson(response.data);
        return liveTvDetailsModel;
      }
    } catch (ex) {
      return null;
    }
  }

  Future<List<MovieModel>?> getAllTVSeries(String pageNumber) async {
    dio.options.headers = ConfigApi().getHeaders();
    try {
      final response = await dio.get("${ConfigApi().getApiUrl()}/tvseries?page=$pageNumber");
      if (response.statusCode == 200) {
        MovieListModel seriesList = MovieListModel.fromJson(response.data);
        return seriesList.movieList;
      }
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  Future<TvSeriesDetailsModel?> getTvSeriesDetailsData({String? seriesId, String? userId}) async {
    dio.options.headers = ConfigApi().getHeaders();
    try {
      final response = userId != null
          ? await dio.get("${ConfigApi().getApiUrl()}/single_details?type=tvseries&id=$seriesId&user_id=$userId")
          : await dio.get("${ConfigApi().getApiUrl()}/single_details?type=tvseries&id=$seriesId");

      print(response.statusCode);
      if (response.statusCode == 200) {
        TvSeriesDetailsModel tvSeriesDetailsModel = TvSeriesDetailsModel.fromJson(response.data);
        print(tvSeriesDetailsModel.title);
        return tvSeriesDetailsModel;
      }
    } catch (ex) {
      return null;
    }
  }

  Future<List<EventsModel>?> getEventsList() async {
    dio.options.headers = ConfigApi().getHeaders();
    try {
      final response = await dio.get("${ConfigApi().getApiUrl()}/event?");
      if (response.statusCode == 200) {
        EventsListModel eventsListModel = EventsListModel.fromJson(response.data);
        return eventsListModel.eventsList;
      }
    } catch (ex) {
      return null;
    }
  }

  Future<EventDetailsModel?> getEventDetails({String? eventId, String? userId}) async {
    dio.options.headers = ConfigApi().getHeaders();
    try {
      final response = await dio.get("${ConfigApi().getApiUrl()}/single_details?type=event&id=$eventId&user_id=$userId");
      if (response.statusCode == 200) {
        EventDetailsModel eventsListModel = EventDetailsModel.fromJson(response.data);
        return eventsListModel;
      }
    } catch (ex) {
      return null;
    }
  }

  Future<List<AllGenre>?> getGenreList(String page) async {
    dio.options.headers = ConfigApi().getHeaders();
    try {
      final response = await dio.get("${ConfigApi().getApiUrl()}/all_genre");
      if (response.statusCode == 200) {
        return GenreListModel.fromJson(response.data).genereList;
      }
    } catch (ex) {
      return null;
    }
  }

  Future<List<AllCountry>?> getCountryList(String page) async {
    dio.options.headers = ConfigApi().getHeaders();
    try {
      final response = await dio.get("${ConfigApi().getApiUrl()}/all_country");
      if (response.statusCode == 200) {
        CountryListModel countryListModel = CountryListModel.fromJson(response.data);
        print(countryListModel.allCountry.length);
        print("Testing_Genre");
        return countryListModel.allCountry;
      }
    } catch (ex) {
      return null;
    }
  }

  Future<MovieDetailsModel> getMovieDetailsData({String? movieId, String? userId}) async {
    dio.options.headers = ConfigApi().getHeaders();

    final response = await dio.get("${ConfigApi().getApiUrl()}/single_details?type=movie&id=$movieId");
    if (response.statusCode == 200) {
      MovieDetailsModel movieDetailsModel = MovieDetailsModel.fromJson(response.data);
      return movieDetailsModel;
    } else {
      throw Exception("Can't fetch movie data");
    }
  }

  Future<SearchResultModel?> searchResultData({String? query}) async {
    dio.options.headers = ConfigApi().getHeaders();
    try {
      final response = await dio.get("${ConfigApi().getApiUrl()}/search?q=$query&type=null&range=null");

      print("response");
      print(response);

      if (response.statusCode == 200) {
        SearchResultModel searchResultModel = SearchResultModel.fromJson(response.data);
        return searchResultModel;
      }
    } catch (ex) {
      return null;
    }
  }

  Future<ContentByCountryModel> contentByCountry({required String countryID}) async {
    dio.options.headers = ConfigApi().getHeaders();
    try {
      final response = await dio.get("${ConfigApi().getApiUrl()}/content_by_country_id?id=$countryID");
      if (response.statusCode == 200) {
        ContentByCountryModel contentByCountryModel = ContentByCountryModel.fromJson(response.data);
        return contentByCountryModel;
      } else {
        throw Exception("country data loading error.");
      }
    } catch (ex) {
      throw Exception("country data loading error. $ex");
    }
  }

  Future<List<FavouriteModel>?> favouriteData(String? userID, String pageNumber) async {
    print("userID:$userID");
    dio.options.headers = ConfigApi().getHeaders();
    try {
      final response = await dio.get("${ConfigApi().getApiUrl()}favorite?user_id=$userID");
      if (response.statusCode == 200) {
        FavouriteListModel favouriteListModel = FavouriteListModel.fromJson(response.data);
        return favouriteListModel.favouriteListModel;
      }
    } catch (ex) {
      return null;
    }
  }

  Future<FavouriteResponseModel?> addFavourite(String? userID, String? videoId) async {
    dio.options.headers = ConfigApi().getHeaders();
    try {
      final response = await dio.get("${ConfigApi().getApiUrl()}add_favorite?user_id=$userID&videos_id=$videoId");
      if (response.statusCode == 200) {
        FavouriteResponseModel favouriteResponseModel = FavouriteResponseModel.fromJson(response.data);
        return favouriteResponseModel;
      }
    } catch (ex) {
      return null;
    }
  }

  Future<FavouriteResponseModel?> removeFavourite(String? userID, String? videoId) async {
    dio.options.headers = ConfigApi().getHeaders();
    try {
      final response = await dio.get("${ConfigApi().getApiUrl()}remove_favorite?user_id=$userID&videos_id=$videoId");
      if (response.statusCode == 200) {
        FavouriteResponseModel favouriteResponseModel = FavouriteResponseModel.fromJson(response.data);
        return favouriteResponseModel;
      }
    } catch (ex) {
      return null;
    }
  }

  Future<FavouriteResponseModel?> verifyFavourite(String? userID, String? videoId) async {
    dio.options.headers = ConfigApi().getHeaders();
    try {
      final response = await dio.get("${ConfigApi().getApiUrl()}verify_favorite_list?user_id=$userID&videos_id=$videoId");
      if (response.statusCode == 200) {
        FavouriteResponseModel favouriteResponseModel = FavouriteResponseModel.fromJson(response.data);
        return favouriteResponseModel;
      }
    } catch (ex) {
      return null;
    }
  }

  //add comment to movie section
  Future<AllCommentModelList?> getAllComments(String? videoId) async {
    //videoId will be added here
    dio.options.headers = ConfigApi().getHeaders();
    try {
      final response = await dio.get("${ConfigApi().getApiUrl()}/all_comments?id=$videoId");
      if (response.statusCode == 200) {
        AllCommentModelList allCommentModelList = AllCommentModelList.fromJson(response.data);
        return allCommentModelList;
      }
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  Future<AddCommentsModel?> addComments(String? videoId, String? userId, String comments) async {
    dio.options.headers = ConfigApi().getHeaders();
    try {
      final response = await dio.get("${ConfigApi().getApiUrl()}/add_comments?videos_id=$videoId&user_id=$userId&comment=$comments");
      if (response.statusCode == 200) {
        AddCommentsModel addCommentsModel = AddCommentsModel.fromJson(response.data);
        return addCommentsModel;
      }
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  Future<AllReplyModelList?> getAllReply(String? id) async {
    dio.options.headers = ConfigApi().getHeaders();
    try {
      final response = await dio.get("${ConfigApi().getApiUrl()}/all_replay?id=$id");
      AllReplyModelList allReplyModel = AllReplyModelList.fromJson(response.data);
      return allReplyModel;
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  Future<AddReplyModel?> addReplyModel({String? comment, String? commentsID, String? videosID, String? userId}) async {
    dio.options.headers = ConfigApi().getHeaders();
    try {
      final response = await dio.get("${ConfigApi().getApiUrl()}/add_replay?comment=$comment&comments_id=$commentsID&videos_id=$videosID&user_id=1");
      AddReplyModel addReplyModel = AddReplyModel.fromJson(response.data);
      return addReplyModel;
    } catch (ex) {
      print(ex.toString());
    }
  }

  Future<AllReplyModelList?> getEventAllReply(String id) async {
    dio.options.headers = ConfigApi().getHeaders();
    try {
      final response = await dio.get("${ConfigApi().getApiUrl()}/all_event_replay?id=$id");
      AllReplyModelList allReplyModel = AllReplyModelList.fromJson(response.data);
      return allReplyModel;
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  Future<AddReplyModel?> addEventReplyModel({String? comment, String? commentsID, String? eventID, String? userId}) async {
    dio.options.headers = ConfigApi().getHeaders();
    try {
      final response =
          await dio.get("${ConfigApi().getApiUrl()}/add_replay?comment=$comment&comments_id=$commentsID&event_id=$eventID&user_id=$userId");
      AddReplyModel addReplyModel = AddReplyModel.fromJson(response.data);
      return addReplyModel;
    } catch (ex) {
      print(ex.toString());
    }
  }

  //End comment to event section

  Future<TvConnectionModel?> tvConnectionCode({String? userId}) async {
    print("userId:$userId");
    dio.options.headers = ConfigApi().getHeaders();
    try {
      final response = await dio.get("${ConfigApi().getApiUrl()}tv_connection_code?id=$userId");
      TvConnectionModel tvConnectionModel = TvConnectionModel.fromJson(response.data);
      return tvConnectionModel;
    } catch (ex) {
      print(ex.toString());
    }
  }

  Future<AllPackageModel?> getAllPackageData({String? userId}) async {
    dio.options.headers = ConfigApi().getHeaders();
    try {
      final response = await dio.get("${ConfigApi().getApiUrl()}/all_package");
      return AllPackageModel.fromJson(response.data);
    } catch (ex) {
      print(ex.toString());
    }
  }

  Future<SubmitResponseModel?> accountDeactivate({String? userId, String? reason}) async {
    dio.options.headers = ConfigApi().getHeaders();
    FormData formData = new FormData.fromMap({"id": userId, "reason": reason, "password": "adminadmin"});
    try {
      final response = await dio.post("${ConfigApi().getApiUrl()}deactivate_account/", data: formData);
      SubmitResponseModel deactivate = SubmitResponseModel.fromJson(response.data);
      showShortToast(deactivate.data!);
      if (deactivate.status == 'success') {
        return deactivate;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<RentHistoryModel?> getRentalHistory(String userID) async {
    dio.options.headers = ConfigApi().getHeaders();
    try {
      final response = await dio.get("${ConfigApi().getApiUrl()}/rental_history?user_id=$userID");
      if (response.statusCode == 200) {
        return RentHistoryModel.fromJson(response.data);
      }
    } catch (ex) {
      return null;
    }
  }

  Future<bool?> saveChargeData({String? planID, String? userId, String? paidAmount, String? paymentInfo, String? paymentMethod}) async {
    dio.options.headers = ConfigApi().getHeaders();
    FormData formData = new FormData.fromMap(
        {"plan_id": planID, "user_id": userId, "paid_amount": paidAmount, "payment_info": paymentInfo, "payment_method": paymentMethod});
    try {
      final response = await dio.post("${ConfigApi().getApiUrl()}/store_payment_info/", data: formData);
      if (response.statusCode == 200) {
        print("Update_Active_Status");
        return true;
      }
    } catch (ex) {
      return null;
    }
  }

  //verify purchase from play console
  Future<bool> verifyMarketInApp({String? signedData, String? signature, String? publicKey}) async {
    dio.options.headers = ConfigApi().getHeaders();
    FormData formData = new FormData.fromMap({
      "signed_data": signedData,
      "signature": signature,
      "public_key_base64": publicKey,
    });
    try {
      final response = await dio.post("${ConfigApi().getApiUrl()}/verify_market_in_app", data: formData);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  //verify purchase from app store
  Future<bool> verifyMarketInAppStore({String? receipt, bool? isSandbox}) async {
    dio.options.headers = ConfigApi().getHeaders();
    FormData formData = new FormData.fromMap({
      "receipt": receipt,
      "is_sandbox": isSandbox,
    });
    try {
      final response = await dio.post("${ConfigApi().getApiUrl()}/verify_app_store_in_app", data: formData);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<HomeContent> getHomeContent() async {
    late HomeContent homeContent;
    dio.options.headers = ConfigApi().getHeaders();
    try {
      final response = await dio.get(ConfigApi().getApiUrl() + "/home_content_for_android");
      if (response.statusCode == 200) {
        homeContent = HomeContent.fromJson(response.data);
      }
      return homeContent;
    } catch (e) {
      throw Exception();
    }
  }
}
