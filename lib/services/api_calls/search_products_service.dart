import '../../models/product.dart';
import '../../services/api_base/api.dart';
import '../../services/api_base/api_service.dart';
class SearchProductsService {
  SearchProductsService._internal();

  static final SearchProductsService _searchService =
      SearchProductsService._internal();

  static SearchProductsService get instance => _searchService;

  final APIService _apiService = APIService();

  Future<Map<String, dynamic>> searchProducts(Map searchBody) async {

    Map<String, dynamic> searchData = {};

    List<Product> products = [];
    try {
      Map<String, dynamic> data = await _apiService.postData(
          endpoint: Endpoints.searchProducts, body: searchBody);
      print('SEARCH DATA==============> $data');
      List<dynamic> json = data['data'];
      int totalCount = data['totalCount'];
      products.addAll(json.map((e) => Product.fromJson(e)).toList());
      searchData['products']=products;
      searchData['total_count']=totalCount;
    } catch (e) {
      return searchData;
    }
    return searchData;
  }
}
