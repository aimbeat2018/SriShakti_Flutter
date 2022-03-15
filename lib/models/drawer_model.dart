import '../strings.dart';

class DrawerModel {
  int? id;
  String? navItemName;
  String? navItemIcon;
  bool? isSelected;
  DrawerModel({this.id,this.navItemName,this.navItemIcon,this.isSelected});
}

List<DrawerModel> drawerListItemFirst = [DrawerModel(id: 1,navItemName: AppContent.home,navItemIcon: "outline_home_24.svg",                      isSelected:true),
                                         DrawerModel(id: 2,navItemName: AppContent.movies,navItemIcon: "outline_movie_24.svg",                   isSelected:false),
                                         DrawerModel(id: 3,navItemName: AppContent.tvSeries,navItemIcon: "outline_local_movies_24.svg",         isSelected:false),
                                         DrawerModel(id: 4,navItemName: AppContent.liveTV,navItemIcon: "outline_live_tv_24.svg",                isSelected:false),
                                         DrawerModel(id: 5,navItemName: AppContent.genre,navItemIcon: "outline_folder_24.svg",                   isSelected:false),
                                         DrawerModel(id: 6,navItemName: AppContent.country,navItemIcon: "outline_outlined_flag_24.svg",          isSelected:false),
                                         DrawerModel(id: 7,navItemName: AppContent.profile,navItemIcon: "outline_person_24.svg",                 isSelected:false),
                                         DrawerModel(id: 8,navItemName: AppContent.favorite,navItemIcon: "outline_favorite_border_24.svg",      isSelected:false),
                                         DrawerModel(id: 9,navItemName: AppContent.purchases,navItemIcon: "ic_subscriptions_black_24dp.svg", isSelected:false),
                                         DrawerModel(id: 10,navItemName: AppContent.settings,navItemIcon: "outline_settings_24.svg",             isSelected:false),
                                         DrawerModel(id: 11,navItemName: AppContent.signOut,navItemIcon: "outline_lock_24.svg",                 isSelected:false),
                                         DrawerModel(id: 12,navItemName: AppContent.darkMode,navItemIcon: "ic_brightness_3_black_24dp.svg",     isSelected:false),
                                         DrawerModel(id: 13,navItemName: AppContent.library,navItemIcon: "ic_file_download_black_24dp.svg",      isSelected:false),];

List<DrawerModel> drawerListItemWithoutLogin = [DrawerModel(id: 1,navItemName: AppContent.home,navItemIcon: "outline_home_24.svg",                      isSelected:true),
                                                DrawerModel(id: 2,navItemName: AppContent.movies,navItemIcon: "outline_movie_24.svg",                   isSelected:false),
                                                DrawerModel(id: 3,navItemName: AppContent.tvSeries,navItemIcon: "outline_local_movies_24.svg",         isSelected:false),
                                                DrawerModel(id: 4,navItemName: AppContent.liveTV,navItemIcon: "outline_live_tv_24.svg",                isSelected:false),
                                                DrawerModel(id: 5,navItemName: AppContent.genre,navItemIcon: "outline_folder_24.svg",                   isSelected:false),
                                                DrawerModel(id: 6,navItemName: AppContent.country,navItemIcon: "outline_outlined_flag_24.svg",          isSelected:false),
                                                DrawerModel(id: 7,navItemName: AppContent.favorite,navItemIcon: "outline_favorite_border_24.svg",      isSelected:false),
                                                DrawerModel(id: 8,navItemName: AppContent.settings,navItemIcon: "outline_settings_24.svg",             isSelected:false),
                                                DrawerModel(id: 9,navItemName: AppContent.signIn,navItemIcon: "outline_lock_24.svg",                  isSelected:false),
                                                DrawerModel(id: 10,navItemName: AppContent.darkMode,navItemIcon: "ic_brightness_3_black_24dp.svg",     isSelected:false),
                                                DrawerModel(id: 11,navItemName: AppContent.library,navItemIcon: "ic_file_download_black_24dp.svg",      isSelected:false),];
