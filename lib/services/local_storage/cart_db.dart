import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../consts/cart_consts.dart';
import '../../models/cart.dart';
import '../../models/product.dart';

class CartDbHelper {
  CartDbHelper._();
  static final CartDbHelper db = CartDbHelper._();
  static Database _database;

  Future<Database> getDatabase() async {
    if (_database != null) {
      return _database;
    }
    _database = await initDb();
    return _database;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), 'Cart.db');
    return openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''CREATE TABLE $CART_TABLE (
        $COLUMN_ID INTEGER NOT NULL,
        $COLUMN_VENDOR_ID INTEGER NOT NULL,
        $COLUMN_NAME_AR TEXT NOT NULL,
        $COLUMN_NAME_EN TEXT NOT NULL,
        $COLUMN_PACKAGING_NAME TEXT NOT NULL,
        $COLUMN_IMAGE TEXT NOT NULL,
        $COLUMN_IMAGE_ID,
        $COLUMN_ITEM_PRICE INTEGER NOT NULL,
        $COLUMN_ITEM_SALE INTEGER NOT NULL,
        $COLUMN_TOTAL_PRICE DOUBLE NOT NULL,
        $COLUMN_PACKAGING_TYPE INTEGER NOT NULL,
        $COLUMN_QUANTITY INTEGER NOT NULL,
        $COLUMN_PRICE_1 INTEGER NOT NULL,
        $COLUMN_PRICE_2 INTEGER NOT NULL,
        $COLUMN_PRICE_3 INTEGER NOT NULL,
        $COLUMN_SALE_1 INTEGER NOT NULL,
        $COLUMN_SALE_2 INTEGER NOT NULL,
        $COLUMN_SALE_3 INTEGER NOT NULL,
        $COLUMN_PACKAGING_1_COUNT INTEGER NOT NULL,
        $COLUMN_PACKAGING_2_COUNT INTEGER NOT NULL,
        $COLUMN_PACKAGING_3_COUNT INTEGER NOT NULL,
        $COLUMN_STOCK INTEGER NOT NULL,
        $COLUMN_MAX_ORDER INTEGER NOT NULL,
        $COLUMN_MIN_ORDER INTEGER NOT NULL,
        $COLUMN_VENDOR_SHIPPING,
        $COLUMN_POINTS INTEGER NOT NULL)''');
    });
  }

  insertProduct(CartItem cart) async {
    var dbClient = await getDatabase();
    Map<String, dynamic> data = {
      COLUMN_ID: cart.product.id,
      COLUMN_NAME_EN: cart.product.nameEn,
      COLUMN_VENDOR_ID: cart.product.vendorId,
      COLUMN_NAME_AR: cart.product.nameAr,
      COLUMN_IMAGE: cart.product.imagesPath,
      COLUMN_IMAGE_ID: cart.product.imageId,
      COLUMN_ITEM_PRICE: cart.selectedPrice,
      COLUMN_ITEM_SALE: cart.selectedSalePrice ?? 0,
      COLUMN_TOTAL_PRICE: cart.totalPrice,
      COLUMN_QUANTITY: cart.quantity,
      COLUMN_PACKAGING_TYPE: cart.type,
      COLUMN_PACKAGING_NAME: cart.selectedPackagingName,
      COLUMN_PRICE_1: cart.product.package1Price,
      COLUMN_SALE_1: cart.product.price1Sale,
      COLUMN_PRICE_2: cart.product.package2Price,
      COLUMN_SALE_2: cart.product.price2Sale,
      COLUMN_PRICE_3: cart.product.package3Price,
      COLUMN_SALE_3: cart.product.price3Sale,
      COLUMN_PACKAGING_1_COUNT: cart.product.package1Count,
      COLUMN_PACKAGING_2_COUNT: cart.product.package2Count,
      COLUMN_PACKAGING_3_COUNT: cart.product.package3Count,
      COLUMN_STOCK: cart.selectedPackagingStock,
      COLUMN_POINTS: cart.product.points,
      COLUMN_MAX_ORDER: cart.product.maxOrder,
      COLUMN_MIN_ORDER: cart.product.minimumOrder,
      COLUMN_VENDOR_SHIPPING: cart.vendorShipping,
    };
    await dbClient.insert(CART_TABLE, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  updateProductQuantity(int quantity, int cartId) async {
    var dbClient = await getDatabase();
    Map<String, dynamic> data = {
      COLUMN_QUANTITY: quantity,
    };
    await dbClient
        .update(CART_TABLE, data, where: '$COLUMN_ID =?', whereArgs: [cartId]);
  }

  deleteProduct(CartItem cart) async {
    var dbClient = await getDatabase();

    await dbClient.delete(CART_TABLE,
        where: '$COLUMN_ID =?', whereArgs: [cart.product.id]);
  }

  Future<List<CartItem>> getAllProducts() async {
    var dbClient = await getDatabase();
    List<Map> cartData = await dbClient.query(CART_TABLE);
    print('CART DATA=====> $cartData');
    List<CartItem> cartList = cartData.isNotEmpty
        ? cartData
            .map((product) => CartItem(
                  product: Product(
                    id: product[COLUMN_ID] as int,
                    imagesPath: product[COLUMN_IMAGE],
                    imageId: product[COLUMN_IMAGE_ID],
                    nameAr: product[COLUMN_NAME_AR],
                    nameEn: product[COLUMN_NAME_EN],
                    package1Price: product[COLUMN_PRICE_1],
                    package2Price: product[COLUMN_PRICE_2],
                    package3Price: product[COLUMN_PRICE_3],
                    price1Sale: product[COLUMN_SALE_1],
                    price2Sale: product[COLUMN_SALE_2],
                    price3Sale: product[COLUMN_SALE_3],
                    package1Count: product[COLUMN_PACKAGING_1_COUNT],
                    package2Count: product[COLUMN_PACKAGING_2_COUNT],
                    package3Count: product[COLUMN_PACKAGING_3_COUNT],
                    points: product[COLUMN_POINTS],
                    minimumOrder: product[COLUMN_MIN_ORDER],
                    maxOrder: product[COLUMN_MAX_ORDER],
                    vendorId: product[COLUMN_VENDOR_ID],
                  ),
                  selectedPrice: product[COLUMN_ITEM_PRICE] as num,
                  selectedSalePrice: product[COLUMN_ITEM_SALE] as num,
                  selectedPackagingName: product[COLUMN_PACKAGING_NAME],
                  quantity: product[COLUMN_QUANTITY],
                  totalPrice: product[COLUMN_TOTAL_PRICE],
                  type: product[COLUMN_PACKAGING_TYPE] as int,
                  selectedPackagingStock: product[COLUMN_STOCK] as int,
                  vendorShipping: product[COLUMN_VENDOR_SHIPPING],
                ))
            .toList()
        : [];
    return cartList;
  }

  clearCart() async {
    var dbClient = await getDatabase();
    dbClient.delete(CART_TABLE);
  }
}
