create database shop;
use shop;

CREATE TABLE `shop`.`user` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(50) NULL DEFAULT NULL,
  `middleName` VARCHAR(50) NULL DEFAULT NULL,
  `lastName` VARCHAR(50) NULL DEFAULT NULL,
  `mobile` VARCHAR(15) NULL,
  `email` VARCHAR(50) NULL,
  `passwordHash` VARCHAR(32) NOT NULL,
  `admin` TINYINT(1) NOT NULL DEFAULT 0,
  `vendor` TINYINT(1) NOT NULL DEFAULT 0,
  `registeredAt` DATETIME NOT NULL,
  `lastLogin` DATETIME NULL DEFAULT NULL,
  `intro` TINYTEXT NULL DEFAULT NULL,
  `profile` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uq_mobile` (`mobile` ASC),
  UNIQUE INDEX `uq_email` (`email` ASC) );
  
  CREATE TABLE `shop`.`product` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `userId` BIGINT NOT NULL,
  `title` VARCHAR(75) NOT NULL,
  `metaTitle` VARCHAR(100) NULL,
  `slug` VARCHAR(100) NOT NULL,
  `summary` TINYTEXT NULL,
  `type` SMALLINT(6) NOT NULL DEFAULT 0,
  `sku` VARCHAR(100) NOT NULL,
  `price` FLOAT NOT NULL DEFAULT 0,
  `discount` FLOAT NOT NULL DEFAULT 0,
  `quantity` SMALLINT(6) NOT NULL DEFAULT 0,
  `shop` TINYINT(1) NOT NULL DEFAULT 0,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  `publishedAt` DATETIME NULL DEFAULT NULL,
  `startsAt` DATETIME NULL DEFAULT NULL,
  `endsAt` DATETIME NULL DEFAULT NULL,
  `content` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uq_slug` (`slug` ASC),
  INDEX `idx_product_user` (`userId` ASC),
  CONSTRAINT `fk_product_user`
    FOREIGN KEY (`userId`)
    REFERENCES `shop`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    CREATE TABLE `shop`.`product_meta` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `productId` BIGINT NOT NULL,
  `key` VARCHAR(50) NOT NULL,
  `content` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_meta_product` (`productId` ASC),
  UNIQUE INDEX `uq_product_meta` (`productId` ASC, `key` ASC),
  CONSTRAINT `fk_meta_product`
    FOREIGN KEY (`productId`)
    REFERENCES `shop`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE `shop`.`product_review` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `productId` BIGINT NOT NULL,
  `parentId` BIGINT NULL DEFAULT NULL,
  `title` VARCHAR(100) NOT NULL,
  `rating` SMALLINT(6) NOT NULL DEFAULT 0,
  `published` TINYINT(1) NOT NULL DEFAULT 0,
  `createdAt` DATETIME NOT NULL,
  `publishedAt` DATETIME NULL DEFAULT NULL,
  `content` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_review_product` (`productId` ASC),
  CONSTRAINT `fk_review_product`
    FOREIGN KEY (`productId`)
    REFERENCES `shop`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

ALTER TABLE `shop`.`product_review` 
ADD INDEX `idx_review_parent` (`parentId` ASC);
ALTER TABLE `shop`.`product_review` 
ADD CONSTRAINT `fk_review_parent`
  FOREIGN KEY (`parentId`)
  REFERENCES `shop`.`product_review` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  CREATE TABLE `shop`.`category` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `parentId` BIGINT NULL DEFAULT NULL,
  `title` VARCHAR(75) NOT NULL,
  `metaTitle` VARCHAR(100) NULL DEFAULT NULL,
  `slug` VARCHAR(100) NOT NULL,
  `content` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`));

ALTER TABLE `shop`.`category` 
ADD INDEX `idx_category_parent` (`parentId` ASC);
ALTER TABLE `shop`.`category` 
ADD CONSTRAINT `fk_category_parent`
  FOREIGN KEY (`parentId`)
  REFERENCES `shop`.`category` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

  -- Insert data into the category table
INSERT INTO `shop`.`category` (`parentId`, `title`, `metaTitle`, `slug`, `content`) VALUES
(NULL, 'Electronics', 'Electronics', 'electronics', 'Electronics products'),
(NULL, 'Clothing and Apparel', 'Clothing and Apparel', 'clothing-apparel', 'Clothing and Apparel products'),
(NULL, 'Home and Kitchen', 'Home and Kitchen', 'home-kitchen', 'Home and Kitchen products'),
(NULL, 'Health and Beauty', 'Health and Beauty', 'health-beauty', 'Health and Beauty products'),
(NULL, 'Sports and Outdoors', 'Sports and Outdoors', 'sports-outdoors', 'Sports and Outdoors products'),
(NULL, 'Books, Movies, and Music', 'Books, Movies, and Music', 'books-movies-music', 'Books, Movies, and Music products'),
(NULL, 'Toys and Games', 'Toys and Games', 'toys-games', 'Toys and Games products'),
(NULL, 'Office Supplies and Stationery', 'Office Supplies and Stationery', 'office-supplies-stationery', 'Office Supplies and Stationery products'),
(NULL, 'Automotive', 'Automotive', 'automotive', 'Automotive products'),
(NULL, 'Pets', 'Pets', 'pets', 'Pet products'),
-- Subcategories for Electronics
(1, 'Smartphones', 'Smartphones', 'smartphones', 'Smartphones products'),
(1, 'Laptops', 'Laptops', 'laptops', 'Laptops products'),
(1, 'Tablets', 'Tablets', 'tablets', 'Tablets products'),
(1, 'Cameras', 'Cameras', 'cameras', 'Cameras products'),
(1, 'Televisions', 'Televisions', 'televisions', 'Televisions products'),
(1, 'Audio Devices', 'Audio Devices', 'audio-devices', 'Audio Devices products'),
(1, 'Wearable Technology', 'Wearable Technology', 'wearable-technology', 'Wearable Technology products'),
-- Subcategories for Clothing and Apparel
(2, 'Men''s Clothing', 'Men''s Clothing', 'mens-clothing', 'Men''s Clothing products'),
(2, 'Women''s Clothing', 'Women''s Clothing', 'womens-clothing', 'Women''s Clothing products'),
(2, 'Kids'' Clothing', 'Kids'' Clothing', 'kids-clothing', 'Kids'' Clothing products'),
(2, 'Shoes', 'Shoes', 'shoes', 'Shoes products'),
(2, 'Accessories', 'Accessories', 'accessories', 'Accessories products'),
-- Subcategories for Home and Kitchen
(3, 'Furniture', 'Furniture', 'furniture', 'Furniture products'),
(3, 'Home Decor', 'Home Decor', 'home-decor', 'Home Decor products'),
(3, 'Kitchen Appliances', 'Kitchen Appliances', 'kitchen-appliances', 'Kitchen Appliances products'),
(3, 'Cookware', 'Cookware', 'cookware', 'Cookware products'),
(3, 'Bedding and Linens', 'Bedding and Linens', 'bedding-linens', 'Bedding and Linens products'),
(3, 'Cleaning Supplies', 'Cleaning Supplies', 'cleaning-supplies', 'Cleaning Supplies products'),
-- Subcategories for Health and Beauty
(4, 'Skincare', 'Skincare', 'skincare', 'Skincare products'),
(4, 'Haircare', 'Haircare', 'haircare', 'Haircare products'),
(4, 'Makeup', 'Makeup', 'makeup', 'Makeup products'),
(4, 'Fragrances', 'Fragrances', 'fragrances', 'Fragrances products'),
(4, 'Personal Care', 'Personal Care', 'personal-care', 'Personal Care products'),
(4, 'Health Supplements', 'Health Supplements', 'health-supplements', 'Health Supplements products'),
-- Subcategories for Sports and Outdoors
(5, 'Fitness Equipment', 'Fitness Equipment', 'fitness-equipment', 'Fitness Equipment products'),
(5, 'Sports Apparel', 'Sports Apparel', 'sports-apparel', 'Sports Apparel products'),
(5, 'Outdoor Gear', 'Outdoor Gear', 'outdoor-gear', 'Outdoor Gear products'),
(5, 'Bicycles and Accessories', 'Bicycles and Accessories', 'bicycles-accessories', 'Bicycles and Accessories products'),
(5, 'Exercise Accessories', 'Exercise Accessories', 'exercise-accessories', 'Exercise Accessories products'),
-- Subcategories for Books, Movies, and Music
(6, 'Books', 'Books', 'books', 'Books products'),
(6, 'Movies', 'Movies', 'movies', 'Movies products'),
(6, 'Music', 'Music', 'music', 'Music products'),
(6, 'E-books and Audiobooks', 'E-books and Audiobooks', 'e-books-audiobooks', 'E-books and Audiobooks products'),
-- Subcategories for Toys and Games
(7, 'Toys for Kids', 'Toys for Kids', 'toys-for-kids', 'Toys for Kids products'),
(7, 'Board Games', 'Board Games', 'board-games', 'Board Games products'),
(7, 'Video Games', 'Video Games', 'video-games', 'Video Games products'),
(7, 'Puzzles and Brainteasers', 'Puzzles and Brainteasers', 'puzzles-brainteasers', 'Puzzles and Brainteasers products'),
-- Subcategories for Office Supplies and Stationery
(8, 'Writing Instruments', 'Writing Instruments', 'writing-instruments', 'Writing Instruments products'),
(8, 'Paper Products', 'Paper Products', 'paper-products', 'Paper Products products'),
(8, 'Desk Accessories', 'Desk Accessories', 'desk-accessories', 'Desk Accessories products'),
(8, 'Office Furniture', 'Office Furniture', 'office-furniture', 'Office Furniture products'),
(8, 'Organizational Products', 'Organizational Products', 'organizational-products', 'Organizational Products products'),
-- Subcategories for Automotive
(9, 'Car Accessories', 'Car Accessories', 'car-accessories', 'Car Accessories products'),
(9, 'Car Care Products', 'Car Care Products', 'car-care-products', 'Car Care Products products'),
(9, 'Automotive Parts and Tools', 'Automotive Parts and Tools', 'automotive-parts-tools', 'Automotive Parts and Tools products'),
(9, 'Motorcycle Accessories', 'Motorcycle Accessories', 'motorcycle-accessories', 'Motorcycle Accessories products'),
-- Subcategories for Pets
(10, 'Pet Food', 'Pet Food', 'pet-food', 'Pet Food products'),
(10, 'Pet Supplies', 'Pet Supplies', 'pet-supplies', 'Pet Supplies products'),
(10, 'Pet Care Products', 'Pet Care Products', 'pet-care-products', 'Pet Care Products products');

  
  CREATE TABLE `shop`.`product_category` (
  `productId` BIGINT NOT NULL,
  `categoryId` BIGINT NOT NULL,
  PRIMARY KEY (`productId`, `categoryId`),
  INDEX `idx_pc_category` (`categoryId` ASC),
  INDEX `idx_pc_product` (`productId` ASC),
  CONSTRAINT `fk_pc_product`
    FOREIGN KEY (`productId`)
    REFERENCES `shop`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pc_category`
    FOREIGN KEY (`categoryId`)
    REFERENCES `shop`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    CREATE TABLE `shop`.`cart` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `userId` BIGINT NULL DEFAULT NULL,
  `sessionId` VARCHAR(100) NOT NULL,
  `token` VARCHAR(100) NOT NULL,
  `status` SMALLINT(6) NOT NULL DEFAULT 0,
  `firstName` VARCHAR(50) NULL DEFAULT NULL,
  `middleName` VARCHAR(50) NULL DEFAULT NULL,
  `lastName` VARCHAR(50) NULL DEFAULT NULL,
  `mobile` VARCHAR(15) NULL,
  `email` VARCHAR(50) NULL,
  `line1` VARCHAR(50) NULL DEFAULT NULL,
  `line2` VARCHAR(50) NULL DEFAULT NULL,
  `city` VARCHAR(50) NULL DEFAULT NULL,
  `province` VARCHAR(50) NULL DEFAULT NULL,
  `country` VARCHAR(50) NULL DEFAULT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  `content` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_cart_user` (`userId` ASC),
  CONSTRAINT `fk_cart_user`
    FOREIGN KEY (`userId`)
    REFERENCES `shop`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    CREATE TABLE `shop`.`cart_item` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `productId` BIGINT NOT NULL,
  `cartId` BIGINT NOT NULL,
  `sku` VARCHAR(100) NOT NULL,
  `price` FLOAT NOT NULL DEFAULT 0,
  `discount` FLOAT NOT NULL DEFAULT 0,
  `quantity` SMALLINT(6) NOT NULL DEFAULT 0,
  `active` TINYINT(1) NOT NULL DEFAULT 0,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  `content` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_cart_item_product` (`productId` ASC),
  CONSTRAINT `fk_cart_item_product`
    FOREIGN KEY (`productId`)
    REFERENCES `shop`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

ALTER TABLE `shop`.`cart_item` 
ADD INDEX `idx_cart_item_cart` (`cartId` ASC);
ALTER TABLE `shop`.`cart_item` 
ADD CONSTRAINT `fk_cart_item_cart`
  FOREIGN KEY (`cartId`)
  REFERENCES `shop`.`cart` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  CREATE TABLE `shop`.`order` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `userId` BIGINT NULL DEFAULT NULL,
  `sessionId` VARCHAR(100) NOT NULL,
  `token` VARCHAR(100) NOT NULL,
  `status` SMALLINT(6) NOT NULL DEFAULT 0,
  `subTotal` FLOAT NOT NULL DEFAULT 0,
  `itemDiscount` FLOAT NOT NULL DEFAULT 0,
  `tax` FLOAT NOT NULL DEFAULT 0,
  `shipping` FLOAT NOT NULL DEFAULT 0,
  `total` FLOAT NOT NULL DEFAULT 0,
  `promo` VARCHAR(50) NULL DEFAULT NULL,
  `discount` FLOAT NOT NULL DEFAULT 0,
  `grandTotal` FLOAT NOT NULL DEFAULT 0,
  `firstName` VARCHAR(50) NULL DEFAULT NULL,
  `middleName` VARCHAR(50) NULL DEFAULT NULL,
  `lastName` VARCHAR(50) NULL DEFAULT NULL,
  `mobile` VARCHAR(15) NULL,
  `email` VARCHAR(50) NULL,
  `line1` VARCHAR(50) NULL DEFAULT NULL,
  `line2` VARCHAR(50) NULL DEFAULT NULL,
  `city` VARCHAR(50) NULL DEFAULT NULL,
  `province` VARCHAR(50) NULL DEFAULT NULL,
  `country` VARCHAR(50) NULL DEFAULT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  `content` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_order_user` (`userId` ASC),
  CONSTRAINT `fk_order_user`
    FOREIGN KEY (`userId`)
    REFERENCES `shop`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    CREATE TABLE `shop`.`order_item` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `productId` BIGINT NOT NULL,
  `orderId` BIGINT NOT NULL,
  `sku` VARCHAR(100) NOT NULL,
  `price` FLOAT NOT NULL DEFAULT 0,
  `discount` FLOAT NOT NULL DEFAULT 0,
  `quantity` SMALLINT(6) NOT NULL DEFAULT 0,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  `content` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_order_item_product` (`productId` ASC),
  CONSTRAINT `fk_order_item_product`
    FOREIGN KEY (`productId`)
    REFERENCES `shop`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

ALTER TABLE `shop`.`order_item` 
ADD INDEX `idx_order_item_order` (`orderId` ASC);
ALTER TABLE `shop`.`order_item` 
ADD CONSTRAINT `fk_order_item_order`
  FOREIGN KEY (`orderId`)
  REFERENCES `shop`.`order` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  CREATE TABLE `shop`.`transaction` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `userId` BIGINT NOT NULL,
  `orderId` BIGINT NOT NULL,
  `code` VARCHAR(100) NOT NULL,
  `type` SMALLINT(6) NOT NULL DEFAULT 0,
  `mode` SMALLINT(6) NOT NULL DEFAULT 0,
  `status` SMALLINT(6) NOT NULL DEFAULT 0,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  `content` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_transaction_user` (`userId` ASC),
  CONSTRAINT `fk_transaction_user`
    FOREIGN KEY (`userId`)
    REFERENCES `shop`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

ALTER TABLE `shop`.`transaction` 
ADD INDEX `idx_transaction_order` (`orderId` ASC);
ALTER TABLE `shop`.`transaction` 
ADD CONSTRAINT `fk_transaction_order`
  FOREIGN KEY (`orderId`)
  REFERENCES `shop`.`order` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;