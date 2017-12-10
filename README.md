# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

Wymagania na projekt
Backend API for mobile app

Points: 15

The task is to create a mobile app with server back-end for managing grocery products. User should be able to add products that he or she is interested in buying on regular basis. Each product is described by a set of fields:

    name of the product (e.g. milk) - string,
    name of the store where the product can be bought (e.g. Carrefour) - string,
    price of the product (e.g. 4.20 PLN) - decimal,
    amount - number of items of the product that user has in possession (e.g. 2 cartons of milk) - integer.

Application allows the user to keep track of the number of items he has in his fridge. When a new product is added to the list, it is stored on the server with amount equal to 0 (zero). For each existing product three operations should be available:

    increase amount - invoked when the user buys additional items of the given product,
    decrease amount - invoked when some items of the product are consumed,
    remove - invoked when the user is no longer interested in monitoring the amount of a given product.

For increase amount and decrease amount operations the user should be able to input the quantity of bought/consumed product.

Assuming above set of operations, the app can be used to keep track of the number of grocery products stored at home. When shopping this data can be utilized to decide which products have to be acquired so that the user won't run out of stock.

The list of products should be stored on the server. It is not required at this stage of the project to store the data on the mobile device (this ability will be added in stage II). All operations on products should immediately call appropriate server API methods, to update the state on the server.

The application should handle multiple users. Authentication may be based on login and password credentials or social accounts integration (e.g. signing up with Google account, Facebook account etc).

There are no restrictions regarding technologies used for the mobile app and the server side app - use the ones you see fit best.