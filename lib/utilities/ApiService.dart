import 'dart:io';

import 'package:dio/dio.dart';
import 'package:euvande/model/request/AddAddressRequestModel.dart';
import 'package:euvande/model/request/AddCarRequestModel.dart';
import 'package:euvande/model/request/AddSpecificationRequestModel.dart';
import 'package:euvande/model/request/ChangePasswordRequestModel.dart';
import 'package:euvande/model/request/EditAddressRequestModel.dart';
import 'package:euvande/model/request/GetModelRequestModel.dart';
import 'package:euvande/model/request/GetPeriodByMakeRequestModel.dart';
import 'package:euvande/model/request/GetVariantByModelRequestModel.dart';
import 'package:euvande/model/request/LoginRequestModel.dart';
import 'package:euvande/model/request/RegisterRequestModel.dart';
import 'package:euvande/model/request/UpdateProfileRequestModel.dart';
import 'package:euvande/model/request/VerifyRequestModel.dart';
import 'package:euvande/model/response/AddAddressResponseModel.dart';
import 'package:euvande/model/response/AddCarResponseModel.dart';
import 'package:euvande/model/response/AddMediaResponseModel.dart';
import 'package:euvande/model/response/AddSpecificationResponseModel.dart';
import 'package:euvande/model/response/ChangePasswordResponseModel.dart';
import 'package:euvande/model/response/DeleteCarResponseModel.dart';
import 'package:euvande/model/response/EditAddressResponseModel.dart';
import 'package:euvande/model/response/GetAddressResponseModel.dart';
import 'package:euvande/model/response/GetAllMakeResponseModel.dart';
import 'package:euvande/model/response/GetCarListResponseModel.dart';
import 'package:euvande/model/response/GetDefaultSpecificationResponseModel.dart';
import 'package:euvande/model/response/GetModelResponseModel.dart';
import 'package:euvande/model/response/GetPendingCarsResponseModel.dart';
import 'package:euvande/model/response/GetPeriodByMakeResponseModel.dart';
import 'package:euvande/model/response/GetUserDetailResponseModel.dart';
import 'package:euvande/model/response/GetVariantByModelResponseModel.dart';
import 'package:euvande/model/response/LoginResponseModel.dart';
import 'package:euvande/model/response/RegisterResponseModel.dart';
import 'package:euvande/model/response/SendForApprovalResponseModel.dart';
import 'package:euvande/model/response/UpdateProfileResponseModel.dart';
import 'package:euvande/model/response/VerifyResponseModel.dart';
import 'package:euvande/utilities/ApiConstants.dart';
import 'package:euvande/utilities/LoggerInterceptor.dart';
import 'package:euvande/utilities/MyLocalStorage.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';

class ApiService {
  final option = Options(responseType: ResponseType.json, headers: {
    Headers.contentTypeHeader: Headers.jsonContentType,
    // "Authorization":"Bearer ${token}",
  });

  final dio = Dio();

  final BuildContext context;

  ApiService(this.context) {
    dio.interceptors.addAll([
      LoggerInterceptor(context), //custom logger interceptor.
    ]);
    option.headers = {
      Headers.contentTypeHeader: Headers.jsonContentType,
      "accesstoken": SharedPrefManager.accessToken,
    };
  }

  Future<RegisterResponseModel> register(
      RegisterRequestModel loginOrRegisterRequestModel) async {
    Response response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.register,
        options: option,
        data: loginOrRegisterRequestModel);

    if (response.statusCode == 200) {
      return RegisterResponseModel.fromJson(response.data);
    } else {
      return Future.error(
          "{'code' : '${response.statusCode}', 'message' : '${response.statusMessage}'}");
    }
  }

  Future<VerifyResponseModel> verify(
      VerifyRequestModel verifyRequestModel) async {
    Response response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.verify,
        options: option,
        data: verifyRequestModel);
    if (response.statusCode == 200) {
      return VerifyResponseModel.fromJson(response.data);
    } else {
      return Future.error(
          "{'code' : '${response.statusCode}', 'message' : '${response.statusMessage}'}");
    }
  }

  Future<VerifyResponseModel> forgotPasswordVerify(
      VerifyRequestModel verifyRequestModel) async {
    Response response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.forgotPasswordVerify,
        options: option,
        data: verifyRequestModel);
    if (response.statusCode == 200) {
      return VerifyResponseModel.fromJson(response.data);
    } else {
      return Future.error(
          "{'code' : '${response.statusCode}', 'message' : '${response.statusMessage}'}");
    }
  }

  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
    Response response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.login,
        options: option,
        data: loginRequestModel);
    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(response.data);
    } else {
      return Future.error(
          "{'code' : '${response.statusCode}', 'message' : '${response.statusMessage}'}");
    }
  }

  Future<RegisterResponseModel> forgotPassword(
      RegisterRequestModel registerRequestModel) async {
    Response response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.forgotPassword,
        options: option,
        data: registerRequestModel);

    if (response.statusCode == 200) {
      return RegisterResponseModel.fromJson(response.data);
    } else {
      return Future.error(
          "{'code' : '${response.statusCode}', 'message' : '${response.statusMessage}'}");
    }
  }

  Future<ChangePasswordResponseModel> changePassword(
      ChangePasswordRequestModel changePasswordRequestModel) async {
    Response response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.changePassword,
        options: option,
        data: changePasswordRequestModel);

    if (response.statusCode == 200) {
      return ChangePasswordResponseModel.fromJson(response.data);
    } else {
      return Future.error(
          "{'code' : '${response.statusCode}', 'message' : '${response.statusMessage}'}");
    }
  }

  Future<GetAllMakeResponseModel> getAllMake() async {
    Response response = await dio
        .get(ApiConstants.baseUrl + ApiConstants.getAllMake, options: option);

    if (response.statusCode == 200) {
      return GetAllMakeResponseModel.fromJson(response.data);
    } else {
      return Future.error(
          "{'code' : '${response.statusCode}', 'message' : '${response.statusMessage}'}");
    }
  }

  Future<GetPeriodByMakeResponseModel> getPeriodByMake(
      GetPeriodByMakeRequestModel getPeriodByMakeRequestModel) async {
    Response response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.getPeriodByMake,
        options: option,
        data: getPeriodByMakeRequestModel);

    if (response.statusCode == 200) {
      return GetPeriodByMakeResponseModel.fromJson(response.data);
    } else {
      return Future.error(
          "{'code' : '${response.statusCode}', 'message' : '${response.statusMessage}'}");
    }
  }

  Future<GetModelResponseModel> getModel(
      GetModelRequestModel getModelRequestModel) async {
    Response response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.getModel,
        options: option,
        data: getModelRequestModel);

    if (response.statusCode == 200) {
      return GetModelResponseModel.fromJson(response.data);
    } else {
      return Future.error(
          "{'code' : '${response.statusCode}', 'message' : '${response.statusMessage}'}");
    }
  }

  Future<GetVariantByModelResponseModel> getVariantByModel(
      GetVariantByModelRequestModel getVariantByModelRequestModel) async {
    Response response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.getVariantByModel,
        options: option,
        data: getVariantByModelRequestModel);

    if (response.statusCode == 200) {
      return GetVariantByModelResponseModel.fromJson(response.data);
    } else {
      return Future.error(
          "{'code' : '${response.statusCode}', 'message' : '${response.statusMessage}'}");
    }
  }

  Future<AddMediaResponseModel> addMedia(int carId, String key, File file,
      ProgressCallback? onSendProgress) async {
    var formData = FormData.fromMap({
      'carId': carId,
      key:
          await MultipartFile.fromFile(file.path, filename: basename(file.path))
    });

    Response response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.addMedia,
        options: option,
        data: formData,
        onSendProgress: onSendProgress);

    if (response.statusCode == 200) {
      return AddMediaResponseModel.fromJson(response.data);
    } else {
      return Future.error(
          "{'code' : '${response.statusCode}', 'message' : '${response.statusMessage}'}");
    }
  }

  Future<AddCarResponseModel> addCar(
      AddCarRequestModel addCarRequestModel) async {
    Response response = await dio.post(
      ApiConstants.baseUrl + ApiConstants.addCar,
      options: option,
      data: addCarRequestModel,
    );

    if (response.statusCode == 200) {
      return AddCarResponseModel.fromJson(response.data);
    } else {
      return Future.error(
          "{'code' : '${response.statusCode}', 'message' : '${response.statusMessage}'}");
    }
  }

  Future<SendForApprovalResponseModel> sendForApproval(String carId) async {
    Response response = await dio.get(
      ApiConstants.baseUrl + ApiConstants.sendForApproval + "/" +carId,
      options: option,
    );

    if (response.statusCode == 200) {
      return SendForApprovalResponseModel.fromJson(response.data);
    } else {
      return Future.error(
          "{'code' : '${response.statusCode}', 'message' : '${response.statusMessage}'}");
    }
  }

  Future<DeleteCarResponseModel> deleteCar(String carId) async {
    Response response = await dio.delete(
      ApiConstants.baseUrl + ApiConstants.deleteCar + "/" + carId,
      options: option,
    );

    if (response.statusCode == 200) {
      return DeleteCarResponseModel.fromJson(response.data);
    } else {
      return Future.error(
          "{'code' : '${response.statusCode}', 'message' : '${response.statusMessage}'}");
    }
  }

  Future<GetPendingCarsResponseModel> getPendingCars(String status) async {
    Response response = await dio.get(
      ApiConstants.baseUrl + ApiConstants.getPendingCars +"?PageSize=10000" + (status.isEmpty ? "" : "&status="+status),
      options: option,
    );

    if (response.statusCode == 200) {
      return GetPendingCarsResponseModel.fromJson(response.data);
    } else {
      return Future.error(
          "{'code' : '${response.statusCode}', 'message' : '${response.statusMessage}'}");
    }
  }

  Future<GetDefaultSpecificationResponseModel> getDefaultSpecification() async {
    Response response = await dio.get(
      ApiConstants.baseUrl + ApiConstants.getDefaultSpecification,
      options: option,
    );

    if (response.statusCode == 200) {
      return GetDefaultSpecificationResponseModel.fromJson(response.data);
    } else {
      return Future.error(
          "{'code' : '${response.statusCode}', 'message' : '${response.statusMessage}'}");
    }
  }

  Future<AddSpecificationResponseModel> addSpecification(
      AddSpecificationRequestModel addSpecificationRequestModel) async {
    Response response = await dio.post(
      ApiConstants.baseUrl + ApiConstants.addSpecification,
      options: option,
      data: addSpecificationRequestModel,
    );

    if (response.statusCode == 200) {
      return AddSpecificationResponseModel.fromJson(response.data);
    } else {
      return Future.error(
          "{'code' : '${response.statusCode}', 'message' : '${response.statusMessage}'}");
    }
  }

  Future<AddAddressResponseModel> addAddress(
      AddAddressRequestModel addAddressRequestModel) async {
    Response response = await dio.post(
      ApiConstants.baseUrl + ApiConstants.addAddress,
      options: option,
      data: addAddressRequestModel,
    );

    if (response.statusCode == 200) {
      return AddAddressResponseModel.fromJson(response.data);
    } else {
      return Future.error(
          "{'code' : '${response.statusCode}', 'message' : '${response.statusMessage}'}");
    }
  }

  Future<EditAddressResponseModel> editAddress(
      EditAddressRequestModel editAddressRequestModel) async {
    Response response = await dio.post(
      ApiConstants.baseUrl + ApiConstants.editAddress,
      options: option,
      data: editAddressRequestModel,
    );

    if (response.statusCode == 200) {
      return EditAddressResponseModel.fromJson(response.data);
    } else {
      return Future.error(
          "{'code' : '${response.statusCode}', 'message' : '${response.statusMessage}'}");
    }
  }

  Future<GetAddressResponseModel> getAddresses() async {
    Response response = await dio.get(
      ApiConstants.baseUrl + ApiConstants.getAddresses,
      options: option,
    );

    if (response.statusCode == 200) {
      return GetAddressResponseModel.fromJson(response.data);
    } else {
      return Future.error(
          "{'code' : '${response.statusCode}', 'message' : '${response.statusMessage}'}");
    }
  }

  Future<AddAddressResponseModel> removeAddress(int addressId) async {
    Response response = await dio.get(
      ApiConstants.baseUrl +
          ApiConstants.removeAddress +
          "/" +
          addressId.toString(),
      options: option,
    );

    if (response.statusCode == 200) {
      return AddAddressResponseModel.fromJson(response.data);
    } else {
      return Future.error(
          "{'code' : '${response.statusCode}', 'message' : '${response.statusMessage}'}");
    }
  }

  Future<UpdateProfileResponseModel> updateUserDetail(UpdateProfileRequestModel updateProfileRequestModel) async {
    Response response = await dio.post(
      ApiConstants.baseUrl +
          ApiConstants.updateUserDetail,
      data: updateProfileRequestModel,
      options: option,
    );

    if (response.statusCode == 200) {
      return UpdateProfileResponseModel.fromJson(response.data);
    } else {
      return Future.error(
          "{'code' : '${response.statusCode}', 'message' : '${response.statusMessage}'}");
    }
  }

  Future<GetUserDetailResponseModel> getUserDetail() async {
    Response response = await dio.get(
      ApiConstants.baseUrl + ApiConstants.getUserDetail,
      options: option,
    );

    if (response.statusCode == 200) {
      return GetUserDetailResponseModel.fromJson(response.data);
    } else {
      return Future.error(
          "{'code' : '${response.statusCode}', 'message' : '${response.statusMessage}'}");
    }
  }
  Future<GetCarListResponseModel> getCarList() async {
    Response response = await dio.post(
      ApiConstants.baseUrl + ApiConstants.getCarList,
      options: option,
    );

    if (response.statusCode == 200) {
      return GetCarListResponseModel.fromJson(response.data);
    } else {
      return Future.error(
          "{'code' : '${response.statusCode}', 'message' : '${response.statusMessage}'}");
    }
  }
}
