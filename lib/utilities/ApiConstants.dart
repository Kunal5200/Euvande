class ApiConstants {
  static  String baseUrl = 'http://3.78.154.29/';
  // static String baseUrl = 'http://192.168.1.3';
  
  // static String authenticationController = ":8085";
  // static String vehicleController = ":8087";
  static String authenticationController = "authentication";
  static String vehicleController = "vehicle";

  static String register = authenticationController + '/api/user/register';
  static String verify = authenticationController + '/api/user/verify';
  static String login = authenticationController + '/api/user/login';
  static String forgotPassword = authenticationController + '/api/forgotPassword';
  static String forgotPasswordVerify = authenticationController + '/api/forgotPassword/verify';
  static String changePassword = authenticationController + '/api/user/changePassword';
  static String addAddress = authenticationController + '/api/address/addAddress';
  static String editAddress = authenticationController + '/api/address/editAddress';
  static String getAddresses = authenticationController + '/api/address/getAddresses';
  static String removeAddress = authenticationController + '/api/address/removeAddress';
  static String updateUserDetail = authenticationController + '/api/user/updateUserDetail';
  static String getUserDetail = authenticationController + '/api/user/getUserDetail';
  static String getAllMake = vehicleController + '/api/make/getAllMake';
  static String getAllMakePublic = vehicleController + '/api/make/public/getA'
      'llMake';
  static String getPeriodByMake = vehicleController + '/api/period/getPeriodByMake';
  static String getModel = vehicleController + '/api/model/getModelByYear';
  static String getVariantByModel = vehicleController + '/api/variant/getVariantByModel';
  static String addMedia = vehicleController + '/api/cars/addMedia';
  static String addCar = vehicleController + '/api/cars/addCar';
  static String deleteCar = vehicleController + '/api/cars/deleteCar';
  static String sendForApproval = vehicleController + '/api/cars/sendForApproval';
  static String getPendingCars = vehicleController + '/api/cars/getPendingCars';
  static String getDefaultSpecification = vehicleController + '/api/carSpecification/getDefaultSpecification';
  static String addSpecification = vehicleController + '/api/cars/addSpecification';
  static String getCarList = vehicleController + '/api/newCars/getCarList?page=1&&pageSize=100000';
  static String getFavouriteCars = vehicleController + '/api/favouriteCar/getFavouriteCars';
  static String favorite = vehicleController + '/api/favouriteCar/favourite';

}