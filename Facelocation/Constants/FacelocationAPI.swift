
import Alamofire

class URLlist{
    //Base URL
    static let baseURL = "https://face-location.com/"
    
    static let simpleHeaders: HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    
    static let headers: HTTPHeaders = [
        "Content-Type": "application/json",
        "X-Auth": "\(DataBaseHelper.userDataArray[2])"
    ]
    
    
    //Registration
    static let registrationPOST = "api/auth/register"
    
    
    //Login
    static let loginPOST = "api/auth/login"


    //Get nearest events
    static let nearestEventsGET = "api/events"
    
    
    //Create New Location
    static let createLocationPOST = "api/locations"
    
    
    //Create New Event
    static let createEventPOST = "api/events"
    
    
    //Upload Cover Photo to New Event
    static let uploadCoverPhotoPOST = "api/events/\(Event.eventID!)/upload-cover"
    
 
    
//    //Upload Event Cover
//    @Multipart
//    @POST("api/events/{eventID}/upload-cover")
//    Call <ResponseBody> uploadEventCover(
//    @HeaderMap Map<String, String> header,
//    @Path("eventID") String eventID,
//    @Part MultipartBody.Part file
//    );
    
    
//    //New LocationForAdapter
//    @POST("api/locations")
//    Call<LocationResponse> addLocation(
//    @HeaderMap Map<String, String> headers,
//    @Body LocationBody body
//    );
//
//    //My Events
//    @GET("api/events")
//    Call <List<MyEventResponse>> getMyEvents(
//    @HeaderMap Map<String, String> headers,
//    @Query("user") String userID
//    );
//
//
//    //Search LocationForAdapter
//    @GET("api/locations")
//    Call <List<LocationGetResponse>> searchLocation(
//    @HeaderMap Map<String, String> headers
//    );
//
//    //Upload User Avatar
//    @Multipart
//    @POST("api/profile/avatar")
//    Call <ResponseBody> uploadAvatar(
//    @HeaderMap Map<String, String> header,
//    @Part MultipartBody.Part file
//    );
//
//    //Update My Profile
//    @POST("api/profile")
//    Call<ProfileResponse> updateMyProfile(
//    @HeaderMap Map<String, String> headers,
//    @Body ProfileBody body
//    );
//
//    //My Profile
//    @GET("api/profile")
//    Call <ProfileResponse> getMyProfile(
//    @HeaderMap Map<String, String> headers
//    );
//
//    //My Visited Events
//    @GET("api/events")
//    Call <List<MyEventResponse>> getMyVisitedEvents(
//    @HeaderMap Map<String, String> headers,
//    @Query("subscriber") String userID
//    );
//
//    //My Locations
//    @GET("api/locations")
//    Call <List<LocationGetResponse>> getMyLocations(
//    @HeaderMap Map<String, String> headers,
//    @Query("user") String userID
//    );
//
//    //Update My Location
//    @PUT("api/locations/{locationID}")
//    Call <LocationPutResponse> updateLocation(
//    @HeaderMap Map<String, String> headers,
//    @Path("locationID") String locationID,
//    @Body LocationBody body
//    );
//
//    //Get My Event
//    @GET("api/events/{eventID}")
//    Call<EventResponse> getMyEvent(
//    @HeaderMap Map<String, String> headers,
//    @Path("eventID") String eventID
//    );
//
//    //Get Similar Events
//    @GET("api/events/")
//    Call <List<EventResponse>> getSimilarEvent(
//    @HeaderMap Map<String, String> headers,
//    @Query("limit") int limit,
//    @Query("exclude") String eventID,
//    @Query("start") String date,
//    @Query("type") String type
//    );
//
//
//
//    //Send Issue Report
//    @POST("api/chat")
//    Call<ResponseBody> sendIssue(
//    @HeaderMap Map<String, String> headers,
//    @Body IssueBody body
//    );
//
//
//    //Localize User on Event
//    @POST("api/events/{eventID}/activate")
//    Call <List<LocalizationResponse>> localizUser(
//    @HeaderMap Map<String, String> headers,
//    @Path("eventID") String eventID,
//    @Body LocalizationBody body
//    );
//
//    //Ban user on event
//    @GET("api/events/{eventID}/ban/{userID}")
//    Call <ResponseBody> userBan(
//    @HeaderMap Map<String, String> headers,
//    @Path("eventID") String eventID,
//    @Path("userID") String userID
//    );
//
//    //Get Main Event Chat
//    @GET("api/chat")
//    Call <List<MainChatResponse>> getChat(
//    @HeaderMap Map<String, String> headers,
//    @Query("event") String eventID
//    );
//
//    //Create chat
//    @POST("api/chat")
//    Call<ChatResponse> createChat(
//    @HeaderMap Map<String, String> headers,
//    @Body ChatBody body
//    );
//
//    //Get Chat By ID
//    @GET("api/chat/")
//    Call <List<MainChatResponse>> getChatByID(
//    @HeaderMap Map<String, String> headers,
//    @Query("chatID") String chatID
//    );


}
