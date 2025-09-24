# d_manoj_pizza_sales
A SQL-based analysis project exploring pizza sales data. Includes database creation, querying, and advanced business insights such as revenue calculation, top-selling pizzas, order distribution, and category-wise performance.
# 🍕 Pizza Sales SQL Analysis

This project contains a comprehensive analysis of **pizza sales data using SQL**.  
The goal of this analysis is to answer key business questions — from basic metrics like total orders and revenue to advanced insights like hourly order distribution and revenue contribution by pizza type.

---

## 🗂️ Database Schema

The analysis is based on a database named **`d_manoj_pizza`** with the following tables:

### **orders**
- `order_id` → Unique identifier for each order  
- `order_date` → The date the order was placed  
- `order_time` → The time the order was placed  

### **order_details**
- `order_details_id` → Unique identifier for each item  
- `order_id` → The ID of the order this item belongs to  
- `pizza_id` → The ID of the pizza ordered  
- `quantity` → The number of pizzas of that type ordered  

### **pizzas**
- `pizza_id` → Unique identifier for each pizza  
- `pizza_type_id` → The ID of the pizza type  
- `size` → The size of the pizza (e.g., Small, Medium, Large)  
- `price` → The price of the pizza  

### **pizza_types**
- `pizza_type_id` → Unique identifier for each pizza type  
- `name` → The name of the pizza  
- `category` → The category of the pizza (e.g., Classic, Veggie)  

---

## 📊 Analysis Questions & SQL Queries

The project is structured into **three sections**: Basic, Intermediate, and Advanced SQL analysis.  
Below are some of the key questions addressed:

### 🔹 Basic Analysis
- **Total Number of Orders** → Count of all orders placed  
- **Total Revenue** → Total revenue from quantity × price of all pizzas  
- **Highest-Priced Pizza** → Identifies the costliest pizza  
- **Most Common Pizza Size** → Most frequently ordered size  
- **Top 5 Most Ordered Pizza Types** → Based on quantity sold  

### 🔹 Intermediate Analysis
- **Total Quantity by Pizza Category** → Orders grouped by pizza category (Classic, Veggie, Chicken, Supreme)  
- **Hourly Order Distribution** → Identifies peak ordering hours  
- **Average Pizzas Per Day** → Daily average pizzas sold  
- **Top 3 Pizza Types by Revenue** → Highest-earning pizza types  

### 🔹 Advanced Analysis
- **Percentage Contribution to Total Revenue** → Share of each pizza type in overall sales  
- **Cumulative Revenue Over Time** → Day-by-day running total of revenue  
- **Top 3 Pizzas by Category** → Uses window functions to rank pizzas within each category  

---

## 🛠️ Tech Stack
- **Database:** MySQL (works on SQL Server/PostgreSQL with minor changes)  
- **Language:** SQL  

---

## 🚀 Future Improvements
- Add visualizations in Tableau / Power BI / Python  
- Automate reporting with scripts  
- Explore customer segmentation and seasonal trends  

---

## 👤 Author
**Deepak Sharma**  
📌 Exploring Data Analytics, Business Intelligence & Consulting
