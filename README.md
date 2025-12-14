# Billing System

A Ruby on Rails billing system for managing product sales, calculating taxes, and handling cash denominations.

## Setup Instructions

### Prerequisites
- Ruby 3.4.4
- Rails 8.1.1
- PostgreSQL

### Installation

1. Clone the repository
```bash
git clone <repository-url>
cd billing_system
```

2. Install dependencies
```bash
bundle install
```

3. Setup environment variables
```bash
cp .env.example .env
# Edit .env file with your PostgreSQL password
```

4. Setup PostgreSQL
```bash
# Create PostgreSQL user (if needed)
sudo -u postgres createuser -s billing_system
sudo -u postgres psql -c "ALTER USER billing_system PASSWORD 'your_password';"

# Or use existing postgres user
# Update .env with: BILLING_SYSTEM_DATABASE_PASSWORD=your_postgres_password
```

5. Setup database
```bash
rails db:create
rails db:migrate
rails db:seed
```

4. Start the server
```bash
rails server
```

5. Visit `http://localhost:3000`

## Features

### Billing System
- **New Bill Creation** (`/`) - Create bills with multiple products
- **Bill Summary** (`/bills/:id`) - View detailed bill with tax calculations and change breakdown
- **Bill History** (`/bills`) - View all previous bills

### Product Management
- **Product List** (`/products`) - View all products
- **Add Product** (`/products/new`) - Add new products with tax rates

## Usage

### Creating a Bill

1. Enter customer email
2. Add products by entering Product Code and Quantity
3. Click "Add New Product" to add more items
4. Enter denomination counts (500, 50, 20, 10, 5, 2, 1 notes)
5. Amount paid auto-calculates based on denominations
6. Click "Generate Bill"

### Sample Products
- **LP001** - Laptop (₹50,000, 18% tax)
- **MS001** - Mouse (₹500, 12% tax)  
- **KB001** - Keyboard (₹1,500, 12% tax)

## Business Logic

- Tax calculated per item: `unit_price * quantity * tax_percentage / 100`
- Net price rounded down to nearest rupee
- Balance calculated using greedy algorithm with available denominations
- Stock automatically reduced after successful billing
- Denomination counts tracked for change calculation

## Database Schema

### Products
- name, product_code, stock, unit_price, tax_percentage

### Bills
- customer_email, total_price, total_tax, net_price, rounded_price, amount_paid, balance

### BillItems
- bill_id, product_id, quantity, unit_price, tax_amount, total_price

### Denominations
- value, count (available notes in shop)

## Testing

Access the application at `http://localhost:3000` and test the complete billing workflow.