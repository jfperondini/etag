import 'package:etag/cors/repository/sqlite_db.dart';
import 'package:etag/cors/routes/routes.dart';
import 'package:etag/data/services/category_service.dart';
import 'package:etag/data/services/event_service.dart';
import 'package:etag/data/services/option_service.dart';
import 'package:etag/data/services/product_service.dart';
import 'package:etag/data/services/query_generator_service.dart';
import 'package:etag/domain/model/generator_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SyncController extends ChangeNotifier {
  final QueryGeneratorService queryGeneratorService;
  final EventService eventService;
  final CategoryService categoryService;
  final ProductService productService;
  final OptionService optionService;

  SyncController(
    this.eventService,
    this.queryGeneratorService,
    this.categoryService,
    this.productService,
    this.optionService,
  );

  Future<void> awaitCall() async {
    await Future.wait([initSync()]);
  }

  Future<void> initSync() async {
    await Sqlite.instance.open();
    QueryGeneratorModel queryGenerator = await queryGeneratorService.getSqlFromService();
    if (queryGenerator.listSql.isNotEmpty) {
      await Sqlite.instance.onReplace(queryGeneratorModel: queryGenerator).then((value) async {
        await eventService.syncTable();
        await categoryService.syncTable();
        await productService.syncTable();
        await optionService.syncTable();
        await Modular.to.pushReplacementNamed(Routes.home);
      });
    } else {
      await Modular.to.pushReplacementNamed(Routes.home);
    }
    notifyListeners();
  }
}
