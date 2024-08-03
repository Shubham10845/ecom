package com.ecom.repository;

import com.ecom.model.Cart;
import com.ecom.model.CartAddress;
import com.ecom.model.CartItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import java.time.LocalDateTime;
import java.util.List;
import java.util.concurrent.atomic.AtomicReference;

@Repository
public class CartRepository {
    private final JdbcTemplate jdbcTemplate;
    @Autowired
    CartRepository(JdbcTemplate jdbcTemplate){
        this.jdbcTemplate = jdbcTemplate;
    }
    String selectCartSessionId = "select sessionId from shop.cart where userId = ? ";

    // Getting user details for cart
    String selectUserDetails = "SELECT firstName, middleName, lastName, mobile, email FROM user WHERE id = ?";

    // Define the SQL query template with placeholders
    String createCart = "INSERT INTO cart (userId, sessionId, token, firstName, middleName, " +
            "lastName, mobile, email, line1, line2, city, province, country, createdAt) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    String InsertItemIntoCartItem = "INSERT INTO cart_item (" +
            "productId, cartId, sku, price, discount, quantity, active, createdAt, updatedAt, content" +
            ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    String selectCartItemDetailFromPraductTable = "SELECT sku, price, discount FROM shop.product WHERE id = ?";
    String SelectCartIdFromCartTable = "select id from shop.cart where userId = ?";

    String selectCart = "SELECT id, userId, firstName, middleName, lastName, mobile, line1, line2," +
            " city, country FROM shop.cart WHERE userId=?";
    String slectCartItems = "SELECT productId, price, discount, quantity FROM shop.cart_item where cartId = ?";


    public String getCartSession(Long userId){
        System.out.println("Getting Cart session");
        String sessionId = null;
        try{
            jdbcTemplate.queryForObject(selectCartSessionId,String.class,userId);
        }catch (Exception e){
            System.out.println(e.getMessage());
            return null;
        }
        System.out.println("Session Id from cart :- " + sessionId);
        return sessionId;
    }

    public void createCart(Long userId, String sessionId, String token, LocalDateTime createdAt, CartAddress cartAddress){
        AtomicReference<String> firstNameRef = new AtomicReference<>();
        AtomicReference<String> middleNameRef = new AtomicReference<>();
        AtomicReference<String> lastNameRef = new AtomicReference<>();
        AtomicReference<String> mobileRef = new AtomicReference<>();
        AtomicReference<String> emailRef = new AtomicReference<>();

        jdbcTemplate.query(selectUserDetails, new Object[]{userId}, rs -> {
            firstNameRef.set(rs.getString("firstName"));
            middleNameRef.set(rs.getString("middleName"));
            lastNameRef.set(rs.getString("lastName"));
            mobileRef.set(rs.getString("mobile"));
            emailRef.set(rs.getString("email"));
        });

// Retrieve values
        String firstName = firstNameRef.get();
        String middleName = middleNameRef.get();
        String lastName = lastNameRef.get();
        String mobile = mobileRef.get();
        String email = emailRef.get();
        insertCart(userId, sessionId, token, firstName, middleName,lastName, mobile, email,
                cartAddress.getLine1(), cartAddress.getLine2(), cartAddress.getCity(),
                null, cartAddress.getCountry(), createdAt);
    }
    private void insertCart(
            Long userId, // getting
            String sessionId, // getting
            String token,  // getting
//            Integer status, // default 0
            String firstName, // get from user table
            String middleName, // get from user table
            String lastName,  // get from user table
            String mobile, // get from user table
            String email, // get from user table
            String line1, // take from JSON Object
            String line2, // take from JSON Object
            String city, // take from JSON Object
            String province, // keep null for now
            String country, // take from JSON Object
            LocalDateTime createdAt // getting
    ) {
        try {
            // Execute the query with parameters
            jdbcTemplate.update(createCart, userId, sessionId, token, firstName, middleName,
                    lastName, mobile, email, line1, line2, city, province, country, createdAt);
        } catch (Exception e) {
            // Handle any potential exceptions here
            e.printStackTrace();
            throw new RuntimeException("Failed to insert into cart table: " + e.getMessage());
        }
    }

    // fields which we will insert into cart item table
//        Long productId; // from UI through service layer
//    Long cartId; // from cart table
//    String sku; // from product table
//    float price; //from product table
//    float discount; // from product table
//    int quantity; // hardcode 1 for now
//    boolean active; // hardcode true default for now
//    LocalDateTime itemCreatedAt; // take from service layer
//    Date updatedAt; // null for now
//    String content; // null for now
    public void addProductToCartItem(Long userId,Long productId, LocalDateTime createdAt) {
        // selecting cartId from cart table and inserting into the cart item table
        AtomicReference<Long> cartIdRef = new AtomicReference<>();
        jdbcTemplate.query(SelectCartIdFromCartTable, new Object[]{userId}, rs -> {
            cartIdRef.set(rs.getLong("id"));
        });
        Long cartId = cartIdRef.get();

        // selecting fields from product table and inserting into the cart item table
        AtomicReference<String> skuRef = new AtomicReference<>();
        AtomicReference<Float> priceRef = new AtomicReference<>();
        AtomicReference<Float> discountRef = new AtomicReference<>();
        jdbcTemplate.query(selectCartItemDetailFromPraductTable, new Object[]{productId}, rs -> {
            skuRef.set(rs.getString("sku"));
            priceRef.set(rs.getFloat("price"));
            discountRef.set(rs.getFloat("discount"));
        });

        String sku = skuRef.get();
        float price = priceRef.get();
        float discount = discountRef.get();
        jdbcTemplate.update(InsertItemIntoCartItem, productId, cartId, sku, price, discount, 1,
                true, createdAt, null, null);
    }

    public Cart getCartAndItems(Long userId){
        Cart cart = getCart(userId);
        cart.setCartItems(getCartItems(cart.getId()));
        return cart;
    }
    public Cart getCart(Long userId){
//        return jdbcTemplate.queryForObject(selectCart,Cart.class,userId);
        return jdbcTemplate.queryForObject(selectCart, BeanPropertyRowMapper.newInstance(Cart.class),userId);
    }
    public List<CartItem> getCartItems(Long cartId){
//        return jdbcTemplate.queryForList(slectCartItems, CartItem.class,cartId);
//        return jdbcTemplate.queryForList(slectCartItems, BeanPropertyRowMapper.newInstance(CartItem.class),cartId);
        return jdbcTemplate.query(slectCartItems, new BeanPropertyRowMapper<>(CartItem.class), cartId);
    }

}
