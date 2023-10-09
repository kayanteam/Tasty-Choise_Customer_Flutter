import 'dart:developer';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:tasty_choise_customer/future/home/models/app.dart';
import 'package:tasty_choise_customer/future/home/models/categories.dart';
import 'package:tasty_choise_customer/future/home/models/home_response.dart';
import 'package:tasty_choise_customer/future/home/models/product.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasty_choise_customer/future/home/domin/home_repo.dart';
import 'package:tasty_choise_customer/future/home/models/my_media.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo repo;

  HomeCubit(this.repo) : super(HomeInitial());

  static HomeCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  App? appConfig;

  Future getAppConfig() async {
    emit(LoadingData());
    (await repo.appConfig()).fold(
      (l) {
        emit(FailureData(l));
      },
      (r) {
        appConfig = App.fromJson(r.data);
        emit(SuccessData());
      },
    );
  }

  List<Categories> resturents = [];
  Future getRestaurants(
    int? categoryId, {
    required double? maxPrice,
    required double? minPrice,
  }) async {
    resturents.clear();
    emit(RestaurentLoading());
    (await repo.getRestaurants(
      categoryId,
      maxPrice: maxPrice,
      minPrice: minPrice,
    ))
        .fold(
      (l) {
        emit(RestaurentFailure(l));
      },
      (r) {
        r.data.forEach((e) {
          resturents.add(Categories.fromJson(e));
        });
        emit(RestaurentSuccess());
      },
    );
  }

  Future makeOrder(int productId, int q) async {
    emit(MakeOrderLoading());
    (await repo.makeOrder(productId: productId, quintity: q)).fold(
      (l) {
        emit(MakeOrderFailure(l));
      },
      (r) {
        emit(MakeOrderSuccess(r.message!));
      },
    );
  }

  List<Product> resturentProducts = [];
  Future getRestaurantProducts(int id) async {
    resturentProducts.clear();
    emit(RestaurentProductsLoading());
    (await repo.getRestaurantProducts(id)).fold(
      (l) {
        emit(RestaurentProductsFailure(l));
      },
      (r) {
        r.data.forEach((e) {
          resturentProducts.add(Product.fromJson(e));
        });
        emit(RestaurentProductsSuccess());
      },
    );
  }

  Product? productDetails;
  Future getProductDetails(int id) async {
    productDetails = null;
    emit(ProductDetailsLoading());
    (await repo.getProductDetails(id)).fold(
      (l) {
        emit(ProductDetailsFailure(l));
      },
      (r) {
        productDetails = Product.fromJson(r.data);
        emit(ProductDetailsSuccess());
      },
    );
  }

  List<MyMedia> media = [];
  Future pickMedia() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );

    if (result != null) {
      log(result.files.single.path!);
      String? newPath;
      if (result.files.single.extension == 'mp4') {
        newPath = await getTunmp(result.files.single.path!);
      }
      media.add(MyMedia(
          file: result.files.single,
          thum: result.files.single.extension == 'mp4' ? newPath! : null));
      emit(HomeInitial());
    }
  }

  Future deleteMedia(int index) async {
    media.removeAt(index);
    emit(HomeInitial());
  }

  Future<String> getTunmp(String path) async {
    // final thumbnailFile = await VideoCompress.getFileThumbnail(path);

    final thumbnailFile = await VideoThumbnail.thumbnailFile(
      video: path,
      // thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.PNG,
      quality: 100,
    );
    return thumbnailFile!;
  }

  int indexSelected = -1;
  selectedCategory(int index) {
    indexSelected = index;
    emit(HomeInitial());
  }

  SfRangeValues values = SfRangeValues(40.0, 80.0);

  setValue(SfRangeValues value) {
    values = value;
    emit(HomeInitial());
  }

  HomeResponse? homeData;

  Future getHomeData() async {
    emit(HomeLoadingData());
    (await repo.homeData()).fold(
      (l) {
        emit(HomeFailureData(l));
      },
      (r) {
        homeData = HomeResponse.fromJson(r.data);
        emit(HomeSuccessData());
      },
    );
  }

  Future storeProduct({
    required String? image,
    required String name,
    required String description,
    required String price,
    required String categoryId,
    required int? productId,
  }) async {
    emit(AddProductLoadingData());
    (await repo.storeProduct(
      image: media[0].file == null ? null : media[0].file!.path!,
      name: name,
      price: price,
      description: description,
      productTypeId: categoryId,
      productId: productId,
    ))
        .fold(
      (l) {
        emit(AddProductFailureData(l));
      },
      (r) {
        media.clear();
        getHomeData();

        emit(AddProductSuccessData(r.message ?? ""));
      },
    );
  }

  Future deleteProduct({required int id}) async {
    emit(DeleteProductLoadingData());
    (await repo.deleteProduct(id)).fold(
      (l) {
        emit(DeleteProductFailureData(l));
      },
      (r) {
        homeData!.prodtucts!.removeWhere((element) => element.id == id);
        emit(DeleteProductSuccessData(r.message ?? ""));
      },
    );
  }
}
