-- BrewQ Database Schema

CREATE DATABASE IF NOT EXISTS brewq;
USE brewq;

-- Users table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'customer'
);

-- Menu items table
CREATE TABLE menu_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    image VARCHAR(255),
    is_available BOOLEAN DEFAULT TRUE,
    category VARCHAR(50)
);

-- Orders table
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_number VARCHAR(10) UNIQUE NOT NULL,
    user_id INT,
    type VARCHAR(50),
    status VARCHAR(50) DEFAULT 'pending',
    payment_method VARCHAR(50),
    total DECIMAL(10, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

-- Order items table
CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    menu_item_id INT,
    quantity INT NOT NULL,
    price_at_time DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (menu_item_id) REFERENCES menu_items(id) ON DELETE CASCADE
);

-- Payments table
CREATE TABLE payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT UNIQUE,
    method VARCHAR(50),
    reference_number VARCHAR(100),
    status VARCHAR(50) DEFAULT 'pending',
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
);

-- Initial seed data
INSERT INTO menu_items (name, description, price, image, is_available, category) VALUES 
('Vanilla Oat Milk Latte', 'Smooth espresso with house-made vanilla bean syrup and steamed creamy oat milk.', 345.00, 'latte.jpg', 1, 'Coffee'),
('Blueberry Muffin', 'Wild mountain blueberries with a lemon zest crumble topping.', 185.00, 'muffin.jpg', 0, 'Pastries'),
('Signature Pour Over', 'Single-origin beans from Ethiopia, featuring notes of jasmine and citrus.', 320.00, 'pourover.jpg', 1, 'Coffee'),
('Avocado Tartine', 'Sourdough bread, crushed hass avocado, aleppo pepper, and olive oil.', 450.00, 'avocado.jpg', 1, 'Brunch'),
('Hibiscus Cold Brew', 'Floral and tart hibiscus petals steeped with sweet citrus peel.', 195.00, 'hibiscus.jpg', 1, 'Tea');
