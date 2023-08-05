import 'dart:async';

import 'package:e_commerce/model/productsModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class dbController {
  static Database? database;
  Future<Database?> get db async {
    if (database != null) return database;
    database = await initializeDatabase();
    return database;
  }

  Future<Database> initializeDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.toString(), "myMainDatabase.db");
    var db = await openDatabase(
      path,
      version: 19,
      onCreate: (db, version) {
        String sql =
            "CREATE TABLE cart( name TEXT,  image TEXT,  productId TEXT,   shopId TEXT,quantity INTEGER,perItem INTEGER ,deliveryCharge INTEGER,color TEXT,varient TEXT,brand Text,shopName text)";
        db.execute(sql);
      },
      onUpgrade: (db, oldVersion, newVersion) {
        String userTable =
            "CREATE TABLE  myactivity( id INTEGER,item TEXT)";
        db.execute(userTable);
        String purchase =
            "create table purchase( name TEXT,  image TEXT,  productId TEXT,  shopId TEXT,quantity INTEGER,perItem INTEGER ,deliveryCharge INTEGER,color TEXT,varient TEXT,brand Text,shopName text)";
        String cancellation =
            "create table cancellation( name TEXT,  image TEXT,  productId TEXT,   shopId TEXT,quantity INTEGER,perItem INTEGER ,deliveryCharge INTEGER,color TEXT,varient TEXT,brand Text,shopName text)";
        String order =
            "create table myproductorders( name TEXT,  image TEXT,  productId TEXT,quantity INTEGER,perItem INTEGER,orderAt TEXT,status TEXT,orderId TEXT,color TEXT,deliveryCharge INTEGER,varient TEXT,brand Text,shopName text,shopId TEXT)";

        String user =
            "create table me(name TEXT,phone TEXT,image  TEXT, email TEXT,deliveryAddress TEXT,id TEXT)";
        String myreview =
            "create table review(image TEXT,review Text,productId TEXT,reviewAt TEXT,rating INTEGER)";
        db.execute(user);
        db.execute(purchase);
        db.execute(cancellation);
        db.execute(order);
        db.execute(myreview);
      },
    );
    return db;
  }

  Future<Order> insertOrder(Order model) async {
    var dbClient = await db;
    await dbClient!.insert("myproductorders", model.toJson());
    return model;
  }

  Future<List<Order>> getOrders() async {
    var dbClient = await db;
    if (dbClient == null) return [];
    final List<Map<String, Object?>> result =
        await dbClient!.query("myproductorders");

    return result.map((e) => Order.fromJson(e)).toList();
  }

  Future<Order> updateOrder(Order model, String id) async {
    var dbClient = await db;
    await dbClient!.update("myproductorders", model.toJson(),
        where: "orderId=?", whereArgs: [id]);
    return model;
  }

  Future<List<Cart>> getCancelProduct() async {
    var dbClient = await db;
    if (dbClient == null) return [];
    final List<Map<String, Object?>> result =
        await dbClient!.query("cancellation");

    return result.map((e) => Cart.fromJson(e)).toList();
  }

  Future<Cart> insertCancellation(Cart model) async {
    var dbClient = await db;
    await dbClient!.insert("cancellation", model.toJson());
    return model;
  }

  Future<List<Cart>> getList() async {
    var dbClient = await db;
    if (dbClient == null) return [];
    final List<Map<String, Object?>> result = await dbClient!.query("cart");

    return result.map((e) => Cart.fromJson(e)).toList();
  }

  Future<Cart> insert(Cart model) async {
    var dbClient = await db;
    await dbClient!.insert("cart", model.toJson());
    return model;
  }

  Future<String> delete(String id) async {
    var dbClient = await db;
    return await dbClient!
        .delete("cart", where: "productId=?", whereArgs: [id]).toString();
  }

  Future<Cart> update(Cart model, int id) async {
    var dbClient = await db;
    await dbClient!
        .update("cart", model.toJson(), where: "productId=?", whereArgs: [id]);
    return model;
  }

  Future<Cart> insertPurchase(Cart model) async {
    var dbClient = await db;
    await dbClient!.insert("purchase", model.toJson());
    return model;
  }

  Future<String> deletePurchase(String id) async {
    var dbClient = await db;
    return await dbClient!
        .delete("purchase", where: "productId=?", whereArgs: [id]).toString();
  }

  Future<Cart> updatePurchase(Cart model, int id) async {
    var dbClient = await db;
    await dbClient!.update("purchase", model.toJson(),
        where: "productId=?", whereArgs: [id]);
    return model;
  }

  Future<List<Cart>> getPurchaseList() async {
    var dbClient = await db;
    if (dbClient == null) return [];
    final List<Map<String, Object?>> result = await dbClient!.query("purchase");

    return result.map((e) => Cart.fromJson(e)).toList();
  }

  Future<userActivity> insertUserActivity(userActivity a) async {
    var dbClient = await db;
    dbClient!.insert('myactivity', a.toJson());
    return a;
  }

  Future<List<userActivity>> getUserActivity() async {
    var dbClient = await db;
    if (dbClient == null) {
      return [];
    }
    List<Map<String, Object?>> result = await dbClient.query("myactivity");

    return result.map((e) => userActivity.fromJson(e)).toList();
  }

  Future<User> insertUser(User a) async {
    var dbClient = await db;
    dbClient!.insert('me', a.toJson());
    return a;
  }

  Future<List<User>> getUser() async {
    var dbClient = await db;
    if (dbClient == null) return [];
    final List<Map<String, Object?>> result = await dbClient!.query("me");

    return result.map((e) => User.fromJson(e)).toList();
  }

  Future<User> updateUser(User model, String id) async {
    var dbClient = await db;
    await dbClient!
        .update("me", model.toJson(), where: "id=?", whereArgs: [id]);
    return model;
  }

  updateDatabase() async {
    Database database = await openDatabase('main.db');
    String sql = '''
    ALTER TABLE cart 
    ADD COLUMN deliveryCharge INTEGER
    ''';
    await database.execute(sql);

    String updateQuery = '''
    UPDATE cart 
    SET deliveryCharge = 100
    ''';
    var s = await database.execute(updateQuery);

    await database.close();
  }

  Future<myReview> insertReview(myReview review) async {
    var dbClient = await db;
    dbClient!.insert('review', review.toJson());
    return review;
  }

  Future<List<myReview>> getReview() async {
    var dbClient = await db;
    if (dbClient == null) {
      return [];
    } else {
      final List<Map<String, Object?>> result = await dbClient.query("review");
      return result.map((e) => myReview.fromJson(e)).toList();
    }
  }
}
