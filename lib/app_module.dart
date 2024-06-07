import 'package:etag/cors/repository/repository.dart';
import 'package:etag/cors/repository/sqlite_db.dart';
import 'package:etag/cors/routes/routes.dart';
import 'package:etag/data/repository/category_repository.dart';
import 'package:etag/data/repository/event_repository.dart';
import 'package:etag/data/repository/option_repository.dart';
import 'package:etag/data/repository/ordered_item_repository.dart';
import 'package:etag/data/repository/ordered_repository.dart';
import 'package:etag/data/repository/product_repository.dart';
import 'package:etag/data/services/category_service.dart';
import 'package:etag/data/services/event_service.dart';
import 'package:etag/data/services/option_service.dart';
import 'package:etag/data/services/product_service.dart';
import 'package:etag/data/services/query_generator_service.dart';
import 'package:etag/domain/model/category/product/option_model.dart';
import 'package:etag/domain/model/category/product_model.dart';
import 'package:etag/domain/model/category_model.dart';
import 'package:etag/domain/model/event_model.dart';
import 'package:etag/domain/model/ordered/ordered_item_model.dart';
import 'package:etag/domain/model/ordered_model.dart';
import 'package:etag/ui/controller/home_controller.dart';
import 'package:etag/ui/controller/option_controller.dart';
import 'package:etag/ui/controller/ordered_controller.dart';
import 'package:etag/ui/controller/product_controller.dart';
import 'package:etag/ui/controller/sync_controller.dart';
import 'package:etag/ui/view/home_page.dart';
import 'package:etag/ui/view/ordered_page.dart';
import 'package:etag/ui/view/product_page.dart';
import 'package:etag/ui/view/sync_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton(QueryGeneratorService.new);

    i.addInstance(Sqlite.instance.db);

    i.addSingleton<Repository<EventModel>>(EventRepository.new);
    i.addSingleton<Repository<CategoryModel>>(CategoryRepository.new);
    i.addSingleton<Repository<ProductModel>>(ProductRepository.new);
    i.addSingleton<Repository<OptionModel>>(OptionRepository.new);
    i.addSingleton<Repository<OrderedModel>>(OrderRepository.new);
    i.addSingleton<Repository<OrderedItemModel>>(OrderedItemRepository.new);

    i.addLazySingleton(EventService.new);
    i.addLazySingleton(CategoryService.new);
    i.addLazySingleton(ProductService.new);
    i.addLazySingleton(OptionService.new);

    i.addLazySingleton(SyncController.new);
    i.addLazySingleton(HomeController.new);
    i.addLazySingleton(OrderedControler.new);
    i.addLazySingleton(ProductController.new);
    i.addLazySingleton(OptionController.new);
  }

  @override
  void routes(r) {
    r.child(Routes.init, child: (_) => const SyncPage());
    r.child(Routes.home, child: (_) => const HomePage());
    r.child(Routes.product, child: (_) => ProductPage(categoryModel: r.args.data['categoryModel']));
    r.child(Routes.ordered, child: (_) => const OrderedPage());
  }
}
