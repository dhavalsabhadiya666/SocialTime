import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class AppConstants {
//String

  static const String appName = "Pinmetar";
  static const String signUpWithPinMeter = "Sign Up Pinmetar";
  static const String signInWithPinMeter = "Sign In Pinmetar";
  static const String signUpWithOneOfFollowingOptions =
      "Sign up with one of following options.";
  static const String signInWithOneOfFollowingOptions =
      "Sign in with one of following options.";
  static const String signUpWithWeChat = "Sign Up with WeChat";
  static const String signInWithWeChat = "Sign In with WeChat";
  static const String signInWithGoogle = "Sign In with Google";
  static const String signInWithFacebook = "Sign In with Facebook";
  static const String signInWithApple = "Sign In with Apple";
  static const String signUpWithAlipay = "Sign Up with Alipay";
  static const String signInWithAlipay = "Sign In with Alipay";
  static const String skipSignIn = "Skip Sign In";
  static const String skipSignUp = "Skip Sign Up";
  static const String alreadyHaveAnAccount = "Already have an account?";
  static const String signIn = "Sign In";
  static const String signUp = "Sign up";
  static const String home = "Home";
  static const String job = "Job";
  static const String messages = "Messages";
  static const String me = "Me";
  static const String selection = "Selection";
  static const String follow = "Follow";
  static const String no = "No";
  static const String yes = "Yes";
  static const String thankYouForYourDonation = "Thank you for your donation.";
  static const String joinChatGroup = "Join Chat Group";
  static const String pianistChatGroup = "Pianist chat group";
  static const String violinistChatGroup = "Violinist chat group";
  static const String chatWithJohnDoePrivately = "Chat with John Doe privately";
  static const String confirm = "Confirm";
  static const String warning1 =
      "There’s no any applicant match search result.";
  static const String warning2 =
      "Would you like to see this talent in the future?";
  static const String doneString =
      "Thanks, we'll notify you of there's someone in our data pool.";
  static const String chooseAnOption = "Choose an option";
  static const String applyJobList = "Apply Job List";
  static const String maybeList = "Maybe List";
  static const String notInterestedJob = "Not Interested Job";
  static const String cancel = "Cancel";
  static const String save = "Save";
  static const String memberProfileVideoList = "Member  Profile - Video List";
  static const String Josephine = "Josephine";
  static const String videos = "Videos";
  static const String sMS = "SMS";
  static const String message = "Message";
  static const String whatsApp = "WhatsApp";
  static const String messenger = "Messenger";
  static const String instagram = "Instagram";
  static const String shareTo = "Share to";
  static const String downloadString = "Download";
  static const String copyLinkText = "Copy Link";
  static const String reportString = "Report";
  static const String review = "Reviews";
  static const String hotSearchKeyword = "Hot Search Keyword:";
  static const String searchResult = "Search Result";
  static const String productDesigner = "product designer";
  static const String jobHelpDetails = "Job Help Details";

  static const String willChargeTokenOnceApplyTheJob =
      "Will charge token once apply the job?";
  static const String dontAskMeAgain = "Don't ask me again";
  static const String whichVideoWouldYouLikeToSubmitToRequester =
      "Which Video would you like to submit to requester?";
  static const String useApplicantProfileVideo = "Use Applicant Profile Video";
  static const String recordLivVideo = "Record Live Video";
  static const String areYouSureYouWantToDeleteTheSelectedVideos =
      "Are you sure you want to delete the selected videos ?";
  static const String whichVideoWouldYouLikeToPost =
      "Which video would you like to post?";
  static const String uploadVideo = "Upload Video";
  static const String recordLiveVideo = "Record Live Video";
  static const String whoCanViewThisVideo = "Who Can view this Video?";
  static const String publicVisibleToEveryone = "Public - Visible to everyone";
  static const String mutualForDonatedFollowerOnly =
      "Mutual- For donated follower only";
  static const String privateVisibleToMeOnly = "Private - Visible to me only";
  static const String otherMembersCanDonate = "Other members can donate";
  static const String atleast = "at least";

  static const String createChatRoom = "Create Chat Room";
  static const String file = "File";
  static const String images = "Images";
  static const String pOST = "POST";
  static const String dRAFT = "DRAFT";

  static const String applicantProfile = 'Applicant Profile';
  static const String fillInApplicantDetails = 'Fill In Applicant Details';
  static const String actualName = 'Actual Name';
  static const String title = 'Title';
  static const String birthday = 'Birthday';
  static const String skill = 'Skill';
  static const String cVCertificate = 'CV & Certificate';
  static const String edit = 'Edit';
  static const String confirmApply = 'Confirm & Apply';
  static const String applyApplicant = 'Apply Applicant';
  static const String privateFans = 'Private Fans';
  static const String totalLikes = 'Total Likes';
  static const String totalCoins = 'Total Coins';
  static const String postVideo = 'Post Video';
  static const String myVideo = 'My Video';
  static const String saveJob = 'Save Job';
  static const String recommendJob = 'Recommend Job';
  static const String likeVideo = 'Like Video';
  static const String postHelpType = 'Post Help Type';
  static const String cleaningService = 'Cleaning Service';
  static const String applyListNew = 'Apply List New';
  static const String hireNumber = 'Hire Number';
  static const String shortList = 'Short List';
  static const String saveList = 'Save List';
  static const String rejectList = 'Reject List';
  static const String savePostHelp = 'Save Post Help';
  static const String connect = 'Connect';
  static const String connectList = 'Connect List';
  static const String account = 'Account';
  static const String youCurrentlyUseAlipayToLogin =
      'You currently use Alipay to login.';
  static const String rememberSignInInfo = 'Remember Signin Info.';
  static const String logOut = 'Log Out';
  static const String location = "Location";
  static const String applyRecord = 'Apply Record';
  static const String pocket = 'Pocket';
  static const String availableCoins = 'Available Coins';
  static const String buyNow = 'Buy Now';
  static const String inviteFriends = 'Invite Friends';
  static const String donateString = 'Donate';
  static const String coinsHistory = 'Coins History';
  static const String donatedBy = 'Donated by';
  static const String following = 'Following';
  static const String postHelpPreview = "Post Help Preview";
  static const String postFillIn = "Post & Fill In";
  static const String step1Of3PostFillIn = "Step 1 Of 3  -  Post & Fill In";
  static const String postHelp = "Post Help";
  static const String uploadPhotoOrVideo = "+Upload Photo or Video";
  static const String next = "NEXT";
  static const String location1 = "Location?";
  static const String step2Of3Location = "Step 2 Of 3  -  Location?";
  static const String currentLocation = "Current Location";
  static const String onLine = "On-Line";
  static const String enterByMyself = "Enter by Myself";
  static const String step3Of3PostHelpPreview =
      "Step 3 Of 3  -  Post Help Preview";
  static const String mathematicsTutor = "Mathematics Tutor";
  static const String tempAddress = "1043 Andell Road, Westerville";
  static const String iWantToFindATutor =
      "I want to find a Mathematics\nTutor for teaching statics.";
  static const String post = 'Post';
  static const String coinsToChatWithMe = "coins to chat with me.";
  static const String start = "Start";
  static const String howManyCoinsDoYouWantToBuy =
      "How many coins do you want to buy?";
  static const String applyNow = "Apply Now";
  static const String myPicture = "My Picture";
  static const String strProfile = "Profile";
  static const String applyLater = "Apply Later";
  static const String notInterested = "Not Interested";
  static const String interested = "Interested";
  static const String myFans = "My Fans";
  static const String privateChat = "Private Chat";
  static const String attendees = "Attendees";
  static const String enterChatRoomTitle = "Enter Chat Room Title";
  static const String reject = "reject";
  static const String shortlist = "Short list";
  static const String postHelpTitle = "Post Help Title";
  static const String johnDoe = "John Doe";
  static const String videoSelfIntroduction = "Video\nSelf Introduction";
  static const String enterActualName = "Enter actual name";
  static const String enterTitle = "Enter title";
  static const String enterYear = "Enter year";
  static const String enterPhoneNumber = "Enter phone number";
  static const String chooseLocations = "Choose Locations";
  static const String chooseEmploymentType = "Choose Employment Type";
  static const String enterSkill = "Enter skill";
  static const String addToCVCertificate = "Add to CV & Certificate";
  static const String allowToAttach =
      "(Allow to attach PDF, PNG, JEPG, Word file)";
  static const String employmentType = "Employment Type";
  static const String currentlyAvailable = "Currently Available";
  static const String unavailable = "Unavailable";
  static const String partiallyAvailable = "Partially Available";
  static const String phoneNumber = "Phone number";
  static const String hashtags = "# Hashtags";
  static const String friends = "@ Friends";
  static const String allowThisVideoToBeDownloaded =
      "Allow this video to be downloaded?";

  static const String setting = 'Setting';
  static const String userSettings = 'User Settings';
  static const String coinsToBecomeMyFans = 'Coins to become my fans';
  static const String accountAndSecurity = 'Account and Security';
  static const String privacySetting = 'Privacy Setting';
  static const String legal = 'Legal';
  static const String privacyPolicy = 'Privacy Policy';
  static const String userAgreement = 'User Agreement';
  static const String termsOfService = 'Terms of Service';
  static const String all = 'All';
  static const String mutualFollowing = 'Mutual Following';
  static const String onlyMyself = 'Only Myself';
  static const String notification = 'Notification';
  static const String flip = 'Flip';
  static const String timer = 'Timer';
  static const String filters = 'Filters';
  static const String beauty = 'Beauty';
  static const String trim = 'Trim';
  static const String text = 'TEXT';
  static const String strSticker = 'Sticker';
  static const String finish = 'Finish';
  static const String enterReport = 'Enter Report';

  //color
  static const Color clrWhite = Color(0xFFFFFFFF);
  static const Color clrBlack = Color(0xFF000000);
  static const Color clrTransparent = Color(0x00000000);
  static const Color clrBorderGreyColor = Color(0xff707070);
  static const Color clrGreyText = Color(0xff939393);
  static const Color clrHintText = Color(0xff9C9BA0);
  static const Color clrButtonGreen = Color(0xff2DC100);
  static const Color clrPrimary = Color(0xff2DC100);
  static const Color clrLightGreyTxt = Color(0xff585861);
  static const Color clrSkyBlueTxt = Color(0xff01DBFA);
  static const Color clrBtnGrey = Color(0xffEEEEEE);
  static const Color clrBtnBlueText = Color(0xff56ABE4);
  static const Color clrBtnBlueGradient1 = Color(0xff06C2DD);
  static const Color clrBtnBlueGradient2 = Color(0xff2ED60E);
  static const Color clrDialogBg = Color(0xff272D38);
  static const Color clrDialogBtnNoBg = Color(0xff363E4D);
  static const Color clrDialogBtnYesBg = Color(0xff0970E6);
  static const Color clrBlack26 = Color(0xFF1C1D23);
  static const Color clrDivider = Color(0xFFDADBDB);
  static const Color clrDivider1 = Color(0xFF2D2E37);
  static const Color clrBtnTeal = Color(0xFF0BC5C3);
  static const Color clrRadioOffBtn = Color(0xFFDADADA);
  static const Color clrDarkGreyText = Color(0xFF9C9BA0);
  static const Color clrGrey = Color(0xFF797F8A);
  static const Color clrRed = Colors.red;
  static const Color clrLightYellow = Color(0xFFFFF9BE);
  static const Color clrRed08 = Color(0xFFFF375F);
  static const Color clrGreen08 = Color(0xFF2DD510);
  static const Color clrBlue08 = Color(0xFF27A3F9);
  static const Color clrSkyBlue = Color(0xFF01DBFA);
  static const Color clrLightBorder = Color(0xff585861);
  static const Color clrLightTODarkGrey = Color(0xff9C9BA0);

//images
  static const String root_image = "assets/images";
  static const String wechat_image_button = '$root_image/wechat.png';
  static const String alipay_image_button = '$root_image/alipay.png';
  static const String home_icon = '$root_image/home.png';
  static const String message_icon = '$root_image/message.png';
  static const String person_icon = '$root_image/person.png';
  static const String pin_icon = '$root_image/pin.png';
  static const String like_icon = '$root_image/like.png';
  static const String image = '$root_image/Image.jpeg';
  static const String search_icon = '$root_image/search.png';
  static const String db_image = '$root_image/db.png';
  static const String done_image = '$root_image/done.png';
  static const String warning_image = '$root_image/warning.png';
  static const String userProfile = '$root_image/user_profile.png';
  static const String chat = '$root_image/chat.png';
  static const String donate = '$root_image/donate.png';
  static const String privateFan = '$root_image/private_fan.png';
  static const String likes = '$root_image/likes.png';
  static const String videoImage = '$root_image/video_image.png';
  static const String play = '$root_image/play.png';
  static const String videoProfile = '$root_image/video_profile.png';
  static const String addUser = '$root_image/add_user.png';
  static const String userAdd = '$root_image/user_add.png';
  static const String shared = '$root_image/shared.png';
  static const String comment = '$root_image/comment.png';
  static const String instagramLogo = '$root_image/Instagram_logo.png';
  static const String fbMessenger = '$root_image/fb_messenger.png';
  static const String whatsAppLogo = '$root_image/whatsApp_logo.png';
  static const String smsLogo = '$root_image/sms_logo.png';
  static const String copyLink = '$root_image/copy_link.png';
  static const String report = '$root_image/report.png';
  static const String download = '$root_image/download.png';
  static const String messageRed = '$root_image/message_red.png';
  static const String sticker = '$root_image/sticker.png';
  static const String document = '$root_image/document.png';
  static const String unsplash = '$root_image/unsplash.png';
  static const String selectAllList = '$root_image/select_all_list.png';
  static const String checkCircle = '$root_image/check_circle.png';
  static const String goldImage = '$root_image/gold.png';
  static const String profile = '$root_image/profile.png';
  static const String video = '$root_image/video.png';
  static const String delete = '$root_image/delete.png';
  static const String upload = '$root_image/upload.png';
  static const String mic = '$root_image/mic.png';
  static const String sendMessage = '$root_image/send_message.png';
  static const String sendFile = '$root_image/send_file.png';
  static const String fileRound = '$root_image/file_round.png';
  static const String imageRound = '$root_image/image_round.png';
  static const String redPin = '$root_image/redPin.png';
  static const String locationImage = '$root_image/location.png';
  static const String editImage = '$root_image/edit.png';
  static const String previewImage = '$root_image/preview.png';
  static const String calendarImage = '$root_image/calendar.png';
  static const String gradient_cv = '$root_image/gradient_cv.png';
  static const String gradient_date = '$root_image/gradient_date.png';
  static const String gradient_location = '$root_image/gradient_location.png';
  static const String gradient_person = '$root_image/gradient_person.png';
  static const String gradient_skill = '$root_image/gradient_skill.png';
  static const String gradient_title = '$root_image/gradient_title.png';
  static const String speaker = '$root_image/speaker.png';
  static const String help = '$root_image/help.png';
  static const String add = '$root_image/add.png';
  static const String private_fan = '$root_image/private_fan.png';
  static const String favorite_red = '$root_image/favorite_red.png';
  static const String wallet = '$root_image/wallet.png';
  static const String work = '$root_image/work.png';
  static const String paper = '$root_image/paper.png';
  static const String like_thunmb = '$root_image/like_thunmb.png';
  static const String following_image = '$root_image/following.png';
  static const String temp_image = '$root_image/temp_image.png';
  static const String select_list = '$root_image/select_list.png';
  static const String heart = '$root_image/heart.png';
  static const String temp_job = '$root_image/temp_job.png';
  static const String tick = '$root_image/tick.png';
  static const String info = '$root_image/info.png';
  static const String logout = '$root_image/logout.png';
  static const String undoL = '$root_image/undo_l.png';
  static const String undoR = '$root_image/undo_r.png';
  static const String like1 = '$root_image/like1.png';
  static const String unselectCircle = '$root_image/unselect_circle.png';
  static const String chatProfile = '$root_image/chate_profile.png';
  static const String editSquare = '$root_image/edit_square.png';
  static const String userJobProfile = '$root_image/user_job_profile.png';
  static const String icEmployment = '$root_image/ic_employment.png';
  static const String icLocations = '$root_image/ic_locations.png';
  static const String icPhone = '$root_image/ic_phone.png';
  static const String icPlus = '$root_image/ic_plus.png';
  static const String icSkill = '$root_image/ic_skill.png';
  static const String icTitle = '$root_image/ic_title.png';
  static const String icUser = '$root_image/ic_user.png';
  static const String icYear = '$root_image/ic_year.png';
  static const String icEdit = '$root_image/ic_edit.png';
  static const String icFile = '$root_image/ic_file.png';
  static const String wechatLogo = '$root_image/Wechat_logo.png';
  static const String loginLogo = '$root_image/login_logo.png';
  static const String linkLogo = '$root_image/link_logo.png';
  static const String icTag = '$root_image/ic_tag.png';
  static const String icFilters = '$root_image/ic_filters.png';
  static const String icFlip = '$root_image/ic_flip.png';
  static const String icFrame = '$root_image/ic_frame.png';
  static const String icMagicPen = '$root_image/ic_magic_pen.png';
  static const String icTextAlphabet = '$root_image/ic_text_alphabet.png';
  static const String icTimer = '$root_image/ic_timer.png';
  static const String icImage = '$root_image/ic_image.png';
  static const String icLayer = '$root_image/ic_layer.png';
  static const String icRecordButton = '$root_image/ic_record_button.png';
  static const String videoImageTemp = '$root_image/video_image_temp.png';
  static const String gifHeart = '$root_image/heart.gif';
  static const String file_icon = '$root_image/file_icon.jpeg';

  static const String ts = '$root_image/ts.png';
  static const String useraggrement = '$root_image/useraggrement.png';
  static const String ps = '$root_image/ps.png';
  static const String security = '$root_image/security.png';
  static const String ap = '$root_image/ap.png';
  static const String coin = '$root_image/coin.png';
  static const String icGoogle = '$root_image/google.png';
  static const String icFacebook = '$root_image/facebook.png';
  static const String icApple = '$root_image/apple.png';

  //fonts
  static const String fontPoppinsRegular = "Poppins-Regular";
  static const String fontPoppinsBold = "Poppins-Bold";
  static const String fontKalamRegular = "Kalam-Regular";

  //font-size
  static const double titleFontSize32 = 32;
  static const double mediumFontSize15 = 15;
  static const double mediumFontSize18 = 18;
  static const double mediumFontSize17 = 17;
  static const double mediumFontSize12 = 12;
  static const double mediumFontSize11 = 11;
  static const double mediumFontSize10 = 10;
  static const double mediumFontSize16 = 16;
  static const double mediumFontSize20 = 20;
  static const double mediumFontSize14 = 14;
  static const double mediumFontSize13 = 13;
  static const double mediumFontSize24 = 24;

//Height and Width
  static displayHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static displayWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  LinearGradient linearGradient = const LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      AppConstants.clrBtnBlueGradient1,
      AppConstants.clrBtnBlueGradient2
    ],
  );

 static Future <FilePickerResult> getFileMultiple() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'mp4','mp3'],
    );
    return result!;
  }
  static Future <FilePickerResult> getFileMultiplePhoneAndVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'mp4'],
    );
    return result!;
  }

  static Future <FilePickerResult> getDocPickOneFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf','jepg','docx'],
    );
    return result!;
  }

  static Future<Position> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

 static Future<Placemark?> getAddressFromLatLong(double lat, double lng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
     Placemark  place = placemarks[0];
    // '${place!.subLocality}, ${place!.locality}, ${place!.country}';
    print('_currentAddress  -- > ${place.toJson().toString()}');
    return place;
 }



}
