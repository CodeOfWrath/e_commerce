// import 'package:flutter_test/flutter_test.dart';
// import 'package:e_commerce/features/ventes/data/repositories/product_repository_impl.dart';
//
// class MockRemote extends Mock implements ProductRemoteDataSource {}
//
// class MockLocal extends Mock implements ProductLocalDataSource {}
//
// void main() {
//   late MockRemote remote;
//   late MockLocal local;
//   late ProductRepositoryImpl repo;
//
//   setUp(() {
//     remote = MockRemote();
//     local = MockLocal();
//     repo = ProductRepositoryImpl(remote: remote, local: local);
//   });
//
//   test('getProducts returns remote data and caches it', () async {
//     final products = [
//       const Product(
//         id: '1',
//         title: 'Test',
//         description: 'Desc',
//         price: 10,
//         imageUrl: '',
//         category: 'cat',
//       ),
//     ];
//
//     when(() => remote.fetchProducts()).thenAnswer((_) async => products);
//     when(() => local.cacheProducts(products)).thenAnswer((_) async {});
//
//     final result = await repo.getProducts();
//
//     expect(result, products);
//     verify(() => local.cacheProducts(products)).called(1);
//   });
//
//   test('getProducts falls back to cache on error', () async {
//     final cached = [
//       const Product(
//         id: '2',
//         title: 'Cached',
//         description: 'Desc',
//         price: 20,
//         imageUrl: '',
//         category: 'cat',
//       ),
//     ];
//
//     when(() => remote.fetchProducts()).thenThrow(Exception('network'));
//     when(() => local.getCachedProducts()).thenAnswer((_) async => cached);
//
//     final result = await repo.getProducts();
//
//     expect(result, cached);
//   });
//
//   test('getProducts rethrows when no cache available', () async {
//     when(() => remote.fetchProducts()).thenThrow(Exception('network'));
//     when(() => local.getCachedProducts()).thenAnswer((_) async => []);
//
//     expect(repo.getProducts(), throwsException);
//   });
// }
