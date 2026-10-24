import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:e_commerce/features/ventes/data/repositories/product_repository_impl.dart';
import 'package:e_commerce/features/ventes/data/datasources/product_remote_datasource.dart';
import 'package:e_commerce/features/ventes/data/datasources/product_local_datasource.dart';
import 'package:e_commerce/features/ventes/data/models/product_model.dart';
import 'package:e_commerce/features/ventes/domain/entities/product_entity.dart';
import 'package:e_commerce/core/network/network_info.dart';
import 'package:e_commerce/core/error/exceptions.dart';
import 'package:e_commerce/core/error/failures.dart';

class MockProductRemoteDataSource extends Mock implements ProductRemoteDataSource {}
class MockProductLocalDataSource extends Mock implements ProductLocalDataSource {}
class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockProductRemoteDataSource mockRemote;
  late MockProductLocalDataSource mockLocal;
  late MockNetworkInfo mockNetworkInfo;
  late ProductRepositoryImpl repository;

  setUp(() {
    mockRemote = MockProductRemoteDataSource();
    mockLocal = MockProductLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repository = ProductRepositoryImpl(
      remote: mockRemote,
      local: mockLocal,
      networkInfo: mockNetworkInfo,
    );
  });

  const tProductModel = ProductModel(
    id: '1',
    name: 'Test Product',
    description: 'Test Description',
    price: 99.99,
    imageUrl: 'https://example.com/image.png',
    category: 'beauty',
    rating: 4.5,
  );

  final List<ProductModel> tProductModelList = [tProductModel];
  final List<Product> tProductList = tProductModelList;

  group('getProducts - Online Mode', () {
    test('should return remote data and cache it when device is online', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemote.fetchProducts()).thenAnswer((_) async => tProductModelList);
      when(() => mockLocal.cacheProducts(any())).thenAnswer((_) async {});

      // act
      final result = await repository.getProducts();

      // assert
      expect(result, equals(tProductList));
      verify(() => mockRemote.fetchProducts()).called(1);
      verify(() => mockLocal.cacheProducts(tProductModelList)).called(1);
    });

    test('should fallback to local cache when remote call throws ServerException', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemote.fetchProducts()).thenThrow(ServerException('Server Error'));
      when(() => mockLocal.getCachedProducts()).thenAnswer((_) async => tProductModelList);

      // act
      final result = await repository.getProducts();

      // assert
      expect(result, equals(tProductList));
      verify(() => mockRemote.fetchProducts()).called(1);
      verify(() => mockLocal.getCachedProducts()).called(1);
    });
  });

  group('getProducts - Offline Mode', () {
    test('should return cached data when device is offline and cache is present', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(() => mockLocal.getCachedProducts()).thenAnswer((_) async => tProductModelList);

      // act
      final result = await repository.getProducts();

      // assert
      expect(result, equals(tProductList));
      verifyNever(() => mockRemote.fetchProducts());
      verify(() => mockLocal.getCachedProducts()).called(1);
    });

    test('should throw CacheFailure when device is offline and cache is empty', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(() => mockLocal.getCachedProducts()).thenAnswer((_) async => []);

      // act & assert
      expect(() => repository.getProducts(), throwsA(isA<CacheFailure>()));
      verifyNever(() => mockRemote.fetchProducts());
    });

    test('should throw CacheFailure when local data source throws CacheException', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(() => mockLocal.getCachedProducts()).thenThrow(CacheException('Cache error'));

      // act & assert
      expect(() => repository.getProducts(), throwsA(isA<CacheFailure>()));
    });
  });
}
