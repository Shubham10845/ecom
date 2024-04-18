package com.ecom.repository;

import com.ecom.model.Product;
import com.ecom.model.ProductMeta;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import java.util.ArrayList;
import java.util.List;

@Repository
public class ProductRepository {
    String INSERT_PRODUCT = "INSERT INTO shop.product (id, userId, title, metaTitle, slug, summary, type, sku, price, discount, quantity, shop, createdAt, updatedAt, publishedAt, startsAt, endsAt, content)" +
                            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
    String INSERT_PRODUCT_META = "INSERT INTO shop.product_meta (productId, `key`, content) VALUES (?, ?, ?);";
    String SELECT_PRODUCTS = "select id,userId,metaTitle,summary,price,discount,content from shop.product;";
    String SELECT_PRODUCTS_META = "select id, `key`, content from shop.product_meta where productId = ?;";
    String SLECT_PRODUCT_BY_ID = "select id,userId,metaTitle,summary,price,discount,content from shop.product where id = ?";
    String SELECT_CATEGORY_ID = "SELECT id FROM shop.category WHERE title = ?;";
    String INSERT_IDS_PRODUCT_CATEGORY = "INSERT INTO shop.product_category (productId, categoryId) VALUES (?, ?);";

    private final JdbcTemplate jdbcTemplate;
    @Autowired
    public ProductRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public void insertProduct(Product product,String categoryTitle) {
        jdbcTemplate.update(INSERT_PRODUCT,
                product.getId(), product.getUserId(), product.getTitle(), product.getMetaTitle(), product.getSlug(),
                product.getSummary(), product.getType(), product.getSku(), product.getPrice(),
                product.getDiscount(), product.getQuantity(), product.getShop(), product.getCreatedAt(),
                product.getUpdatedAt(), product.getPublishedAt(), product.getStartsAt(), product.getEndsAt(),
                product.getContent());
        long categoryId = jdbcTemplate.queryForObject(SELECT_CATEGORY_ID, Long.class, categoryTitle);
        jdbcTemplate.update(INSERT_IDS_PRODUCT_CATEGORY, product.getId(), categoryId);
        List<ProductMeta> metas = product.getMetas();
        for (ProductMeta meta : metas) {
            jdbcTemplate.update(INSERT_PRODUCT_META, product.getId(), meta.getKey(), meta.getContent());
        }
    }

    public List<Product> laodAllProducts() {
        List<Product> products = jdbcTemplate.query(SELECT_PRODUCTS, BeanPropertyRowMapper.newInstance(Product.class));
        for (Product product : products) {
            List<ProductMeta> metas = jdbcTemplate.query(SELECT_PRODUCTS_META, BeanPropertyRowMapper.newInstance(ProductMeta.class), product.getId());
            product.setMetas(metas);
        }
        return products;
    }

    public Product getProductById(Long productId) {
        Product product = jdbcTemplate.queryForObject(SLECT_PRODUCT_BY_ID, BeanPropertyRowMapper.newInstance(Product.class), productId);
        List<ProductMeta> metas = jdbcTemplate.query(SELECT_PRODUCTS_META, BeanPropertyRowMapper.newInstance(ProductMeta.class), product.getId());
        product.setMetas(metas);
        return product;
    }
}
