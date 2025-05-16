-- Create the database
CREATE DATABASE captains_dough;
USE captains_dough;

-- Users table
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone_number VARCHAR(15),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_admin BOOLEAN DEFAULT FALSE
    last_login TIMESTAMP,
);

-- Products table
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    image_url VARCHAR(255),
    category VARCHAR(50),
    stock_quantity INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) DEFAULT 'pending',
    shipping_address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Order items table (for items in each order)
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price_at_time DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Cart table (for active shopping carts)
CREATE TABLE cart (
    cart_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Cart items table
CREATE TABLE cart_items (
    cart_item_id INT PRIMARY KEY AUTO_INCREMENT,
    cart_id INT,
    product_id INT,
    quantity INT NOT NULL,
    FOREIGN KEY (cart_id) REFERENCES cart(cart_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Newsletter subscriptions table
CREATE TABLE newsletter_subscriptions (
    subscription_id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) UNIQUE NOT NULL,
    subscribed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

-- Insert sample products
INSERT INTO products (name, description, price, image_url, category, stock_quantity) VALUES
('Apple Pie', 'Classic American apple pie with a flaky crust', 6.50, '/src/applepie.jpg', 'Pies', 50),
('Baklava', 'Traditional Middle Eastern pastry with nuts and honey', 5.99, '/src/baklava.png', 'International', 40),
('Ginger Bread', 'Spiced holiday favorite', 2.99, '/src/bread.JPG', 'Breads', 60),
('Cheese Cake', 'Rich and creamy New York style cheesecake', 7.69, '/src/cheesecake.jpg', 'Cakes', 30),
('Sweet Choux', 'Light and airy French pastry', 5.00, '/src/choux pastry.jpg', 'French Pastries', 45),
('Macaron', 'Delicate French almond cookies', 3.79, '/src/macaron.jpg', 'French Pastries', 100),
('Palmier', 'Crispy French heart-shaped cookies', 9.00, '/src/palmier.jpg', 'French Pastries', 35),
('Puff Pastry', 'Buttery layered pastry', 12.20, '/src/puff pastry.jpeg', 'French Pastries', 25);

-- Insert dummy users
INSERT INTO users (username, email, password_hash, first_name, last_name, phone_number, address, is_admin) VALUES
('john_doe', 'john@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'John', 'Doe', '0712345678', '123 Main St, Nairobi', FALSE),
('jane_smith', 'jane@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Jane', 'Smith', '0723456789', '456 Oak Ave, Kiambu', FALSE),
('admin_user', 'admin@captainsdough.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Admin', 'User', '0734567890', '789 Admin St, Nairobi', TRUE),
('mary_jones', 'mary@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Mary', 'Jones', '0745678901', '321 Pine Rd, Machakos', FALSE),
('peter_king', 'peter@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Peter', 'King', '0756789012', '654 Cedar Ln, Kajiado', FALSE);

-- Insert dummy orders
INSERT INTO orders (user_id, total_amount, status, shipping_address) VALUES
(1, 25.97, 'completed', '123 Main St, Nairobi'),
(2, 18.47, 'pending', '456 Oak Ave, Kiambu'),
(4, 32.20, 'processing', '321 Pine Rd, Machakos'),
(5, 15.78, 'completed', '654 Cedar Ln, Kajiado'),
(1, 42.99, 'delivered', '123 Main St, Nairobi');

-- Insert dummy order items
INSERT INTO order_items (order_id, product_id, quantity, price_at_time) VALUES
(1, 1, 2, 6.50),  -- 2 Apple Pies
(1, 3, 1, 2.99),  -- 1 Ginger Bread
(2, 2, 1, 5.99),  -- 1 Baklava
(2, 5, 1, 5.00),  -- 1 Sweet Choux
(3, 8, 2, 12.20), -- 2 Puff Pastries
(4, 6, 3, 3.79),  -- 3 Macarons
(5, 4, 2, 7.69),  -- 2 Cheese Cakes
(5, 7, 1, 9.00);  -- 1 Palmier

-- Insert dummy shopping carts
INSERT INTO cart (user_id) VALUES
(1),
(2),
(4);

-- Insert dummy cart items
INSERT INTO cart_items (cart_id, product_id, quantity) VALUES
(1, 3, 2),  -- 2 Ginger Breads in John's cart
(1, 6, 4),  -- 4 Macarons in John's cart
(2, 1, 1),  -- 1 Apple Pie in Jane's cart
(2, 4, 1),  -- 1 Cheese Cake in Jane's cart
(3, 8, 2);  -- 2 Puff Pastries in Mary's cart

-- Insert dummy newsletter subscriptions
INSERT INTO newsletter_subscriptions (email, is_active) VALUES
('john@example.com', TRUE),
('jane@example.com', TRUE),
('mary@example.com', TRUE),
('peter@example.com', FALSE),
('sarah@example.com', TRUE),
('mike@example.com', TRUE),
('lisa@example.com', FALSE),
('david@example.com', TRUE);
-- Create indexes for better performance
CREATE INDEX idx_user_email ON users(email);
CREATE INDEX idx_order_user ON orders(user_id);
CREATE INDEX idx_order_status ON orders(status);
CREATE INDEX idx_product_category ON products(category); 