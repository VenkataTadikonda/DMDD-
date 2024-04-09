import streamlit as st
import pyodbc
import pandas as pd

# Function to establish a database connection
def get_connection():
    conn_str = (
        r'DRIVER={SQL Server};'
        r'SERVER=LAPTOP-4KM5CND2;'  
        r'DATABASE=onlineretail;'
        r'Trusted_Connection=yes;'
    )
    return pyodbc.connect(conn_str)

# Function to read data from the database
def read_data(table, order_id=None) :
    with get_connection() as conn:
        if table.lower() == 'order' and order_id is not None:
            cursor = conn.cursor()
            cursor.execute("EXEC GetOrderDetailsByCustomerOrOrderID @OrderID=?", (order_id,))
            columns = [column[0] for column in cursor.description]
            data = cursor.fetchall()
            return pd.DataFrame.from_records(data, columns=columns)      
        else:      
            table = f"[{table}]" if table.lower() == 'order' else table
            query = f"SELECT * FROM {table}"
            return pd.read_sql(query, conn)
    
def add_product(brand_id, category_id, price, description, product_name, quantity, size, color, location, batch_number):
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute(
            """  
            DECLARE @OutputProductID INT, @OutputInventoryID INT;
            EXEC AddProduct
                @BrandID = ?,
                @CategoryID = ?,
                @Price = ?,
                @Description = ?,
                @ProductName = ?,
                @Quantity = ?,
                @Size = ?,
                @Color = ?,
                @Location = ?,
                @BatchNumber = ?,
                @NewProductID = @OutputProductID OUTPUT,
                @NewInventoryID = @OutputInventoryID OUTPUT;
             SELECT @OutputProductID as NewProductID, @OutputInventoryID as NewInventoryID;
            """,
            (brand_id, category_id, price, description, product_name, quantity, size, color, location, batch_number)
        )
        result = cursor.fetchone()
        conn.commit()
        if result:
            new_product_id, new_inventory_id = result
            return new_product_id, new_inventory_id
        else:
            return None, None

def create_customer(username, password, first_name, last_name, phone_number, dob):
    with get_connection() as conn:
        cursor = conn.cursor()
        formatted_dob = dob.strftime('%Y-%m-%d')
        cursor.execute(
            """  
            EXEC CreateCustomer
                @Username = ?,
                @Password = ?,
                @FirstName = ?,
                @LastName = ?,
                @PhoneNumber = ?,
                @DOB = ?;
            """,
            (username, password, first_name, last_name, phone_number, formatted_dob)
        )
        conn.commit()
        
def add_address(customer_id, recipient_name, street_address1, street_address2, city, state, postal_code, country):
    with get_connection() as conn:
        cursor = conn.cursor()
        insert_query = """
            INSERT INTO Address (CustomerID, RecipientName, StreetAddress1, StreetAddress2, City, [State], PostalCode, Country)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        """
        cursor.execute(insert_query, (customer_id, recipient_name, street_address1, street_address2, city, state, postal_code, country))
        conn.commit()

def create_order(customer_id, deliveryperson_id,address_id):
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute(
            """
            DECLARE @OrderID INT, @InvoiceID INT, @PaymentID INT,   @ShippingID INT , @DeliveryID INT;
            EXEC CreateOrder
                @CustomerID = ?,
                @AddressID = ?,
                @DeliveryPersonID = ?,
                @NewOrderID = @OrderID OUTPUT,
                @NewInvoiceID = @InvoiceID OUTPUT,
                @NewPaymentID = @PaymentID OUTPUT,
                @NewShippingID = @ShippingID OUTPUT,
                @NewDeliveryID = @DeliveryID OUTPUT;
                SELECT @OrderID as OrderID, @InvoiceID as InvoiceID, @PaymentID as PaymentID, @ShippingID as ShippingID, @DeliveryID as DeliveryID;
            """,
            (customer_id, deliveryperson_id,address_id)
        )
        result = cursor.fetchone()
        conn.commit()
        if result:
            return result
        else:
            return None

def insert_cart_item(cart_id, product_id, size, discount, quantity):

    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO CartItem (CartID, ProductID, [Size], Discount, Quantity) VALUES (?, ?, ?, ?, ?)",
            (cart_id, product_id, size, discount, quantity)
        )
        conn.commit()


def insert_inventory(quantity, size, color):
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO Inventory (Quantity, [Size], Color) VALUES (?, ?, ?);",
            (quantity, size, color)
        )
        new_inventory_id = cursor.execute("SELECT @@IDENTITY;").fetchval()
        conn.commit()
        return new_inventory_id

def insert_inventory_product(inventory_id, product_id, location, batch_number):
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO InventoryProduct (InventoryID, ProductID, [Location], BatchNumber) VALUES (?, ?, ?, ?);",
            (inventory_id, product_id, location, batch_number)
        )
        conn.commit()

def insert_brand(brand_name, description, company_info):
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO Brand (BrandName, [Description], CompanyInfo) VALUES (?, ?, ?);",
            (brand_name, description, company_info)
        )
        conn.commit()
def get_cart_items(customer_id):
    with get_connection() as conn:
        cart_query = f"SELECT * FROM Cart WHERE CustomerID = {customer_id}"
        cart = pd.read_sql(cart_query, conn)
        if not cart.empty:
            cart_id = cart['CartID'].iloc[0]
            query = f"SELECT * FROM CartItem WHERE CartID = {cart_id}"
            cart_items = pd.read_sql(query, conn)
            return cart_items
        return pd.DataFrame()
    
def insert_delivery_person(first_name, last_name, phone_number):
    with get_connection() as conn:
        cursor = conn.cursor()
        cursor.execute(
            """
            INSERT INTO DeliveryPerson (DeliveryPersonFName, DeliveryPersonLName, PhoneNumber)
            VALUES (?, ?, ?);
            """,
            (first_name, last_name, phone_number)
        )
        conn.commit()

def get_customer_data(customer_id):
    try:
        with get_connection() as conn:
            query = f"SELECT * FROM Customer WHERE CustomerID = ?"
            df = pd.read_sql(query, conn, params=(customer_id,))
            if not df.empty:
                print("Customer data found:", df) 
                return df.iloc[0]
            else:
                print("No data found for customer ID:", customer_id)
                return pd.DataFrame()
    except Exception as e:
        print("Error fetching customer data:", e)
        return pd.DataFrame()


def update_customer(customer_id, username, password, first_name, last_name, phone_number, dob):
    try:
        with get_connection() as conn:
            print(f"Updating customer {customer_id}") 
            cursor = conn.cursor()
            dob_str = dob.strftime('%Y-%m-%d') if dob else None

            cursor.execute("OPEN SYMMETRIC KEY passwordEncryptionKey DECRYPTION BY CERTIFICATE passwordEncryptCertificate;")
            update_query = """
            UPDATE Customer
            SET Username = ?, [Password] = EncryptByKey(Key_GUID('passwordEncryptionKey'), ?), FirstName = ?, LastName = ?, PhoneNumber = ?, DOB = ?
            WHERE CustomerID = ?;
            """
            cursor.execute(update_query, (username, password, first_name, last_name, phone_number, dob_str, customer_id))
            cursor.execute("CLOSE SYMMETRIC KEY passwordEncryptionKey;")
            conn.commit()
            print("Customer updated successfully")
            return True
    except Exception as e:
        print("An error occurred:", e)
        return False

def update_cart_item_quantity(new_quantity, selected_cart_item):
    try:
        with get_connection() as conn:
            print(f"Inside CartItem update Function {selected_cart_item} to quantity {new_quantity}")
            cursor = conn.cursor()
            query = """
            UPDATE CartItem
            SET Quantity = ?
            WHERE CartItemID = ?;
            """
            cursor.execute(query, (new_quantity, selected_cart_item))
            conn.commit()
            print(f"Updated CartItemID {selected_cart_item} to quantity {new_quantity}")
            st.success('Cart item quantity updated successfully.')
            return True
    except Exception as e:
        print(f"Failed to update cart item quantity: {e}")
        st.error(f'Failed to update cart item quantity: {e}')
        return False

def remove_cart_item(cart_item_id):
    try:
        with get_connection() as conn:
            cursor = conn.cursor()
            query = """
            DELETE FROM CartItem
            WHERE CartItemID = ?;
            """
            cursor.execute(query, (cart_item_id,))
            conn.commit()
            print(f"Removed CartItemID {cart_item_id}")
            st.success('Cart item removed successfully.')
            return True
    except Exception as e:
        print(f"Failed to remove cart item: {e}")
        st.error(f'Failed to remove cart item: {e}')
        return False
    

def update_cart_item_size(cart_item_id, new_size):
    try:
        with get_connection() as conn:
            cursor = conn.cursor()
            query = """
            UPDATE CartItem
            SET Size = ?
            WHERE CartItemID = ?;
            """
            cursor.execute(query, (new_size, cart_item_id))
            conn.commit()
            print(f"Updated CartItemID {cart_item_id} to size {new_size}")
            st.success('Cart item size updated successfully.')
            return True
    except Exception as e:
        print(f"Failed to update cart item size: {e}")
        st.error(f'Failed to update cart item size: {e}')
        return False

def get_delivered_orders_and_products(customer_id):
    try:
        with get_connection() as conn:
            query = """
            SELECT o.OrderID, od.ProductID, p.ProductName
            FROM [Order] o
            JOIN OrderDetails od ON o.OrderID = od.OrderID
            JOIN Product p ON od.ProductID = p.ProductID
            WHERE o.OrderStatus = 'Delivered' AND EXISTS (
                SELECT 1 FROM Cart WHERE CartID = o.CartID AND CustomerID = ?
            )
            """
            return pd.read_sql(query, conn, params=[customer_id])
    except Exception as e:
        st.error(f"Failed to fetch delivered orders: {e}")
        return pd.DataFrame()
    
def insert_review(customer_id, order_id, product_id, rating, comment):
    try:
        with get_connection() as conn:
            cursor = conn.cursor()
            cursor.execute("""
            SELECT OrderDetailsID 
            FROM OrderDetails 
            WHERE OrderID = ? AND ProductID = ?
            """, (order_id, product_id))
            order_details_id = cursor.fetchone()

            if not order_details_id:
                st.error("Order Details not found.")
                return

            cursor.execute("""
            INSERT INTO Review (CustomerID, OrderDetailsID, Rating, Comment, [Date])
            VALUES (?, ?, ?, ?, GETDATE())
            """, (customer_id, order_details_id[0], rating, comment))
            
            conn.commit()
            st.success("Review added successfully!")
    except Exception as e:
        st.error(f"Failed to insert review: {e}")


def get_invoice_details(invoice_number):
    try:
        with get_connection() as conn:
            query = f"SELECT * FROM Invoice WHERE InvoiceNumber = ?"
            invoice_details = pd.read_sql(query, conn, params=(invoice_number,))
            return invoice_details
    except Exception as e:
        print("Error fetching invoice details:", e)
        return pd.DataFrame()
    
def get_payment_details(invoice_number):
    try:
        with get_connection() as conn:
            query = "SELECT * FROM Payment WHERE InvoiceNumber = ?"
            payment_details = pd.read_sql(query, conn, params=(invoice_number,))
            return payment_details
    except Exception as e:
        print("Error fetching payment details:", e)
        return pd.DataFrame()

def update_payment_status(invoice_number, new_status):
    valid_statuses = ['Success', 'Pending', 'Failed']
    if new_status not in valid_statuses:
        print(f"Invalid status: {new_status}")
        return False
    try:
        with get_connection() as conn:
            cursor = conn.cursor()
            update_query = """
            UPDATE Payment
            SET [Status] = ?
            WHERE InvoiceNumber = ?;
            """
            cursor.execute(update_query, (new_status, invoice_number))
            conn.commit()
            print(f"Payment status updated to {new_status} for Invoice Number {invoice_number}")
            return True
    except Exception as e:
        print("An error occurred while updating payment status:", e)
        return False

def get_order_details(order_id):
    try:
        with get_connection() as conn:
            query = """
            SELECT o.OrderID, o.OrderStatus, i.InvoiceNumber
            FROM [Order] o
            JOIN Invoice i ON o.OrderID = i.OrderID
            WHERE o.OrderID = ?
            """
            order_details = pd.read_sql(query, conn, params=(order_id,))
            return order_details
    except Exception as e:
        print("Error fetching order details:", e)
        return pd.DataFrame()

def update_delivery_status(invoice_number, new_status):
    print(f"Updating status for invoice {invoice_number} to {new_status}") 
    try:
        with get_connection() as conn:
            cursor = conn.cursor()
            check_query = "SELECT COUNT(*) FROM Delivery WHERE InvoiceNumber = ?"
            cursor.execute(check_query, int(invoice_number))
            if cursor.fetchone()[0] == 0:
                message=(f"No delivery record found for Invoice Number: {invoice_number}. Update aborted.")
                return False, message

            query = "UPDATE Delivery SET DeliveryStatus = ? WHERE InvoiceNumber = ?"
            cursor.execute(query, (new_status, int(invoice_number)))
            affected_rows = cursor.rowcount
            conn.commit()

            if affected_rows > 0:
                message=(f"Delivery status updated successfully for {affected_rows} row(s).")
                return True,message
            else:
                message=(f"Update failed or no rows affected for Invoice Number: {invoice_number}.")
                return False,message

    except Exception as e:
        message=(f"Error updating delivery status: {e}")
        return False,message

def get_customer_addresses(customer_id):
    try:
        with get_connection() as conn:
            query = "SELECT * FROM Address WHERE CustomerID = ?"
            return pd.read_sql(query, conn, params=(customer_id,))
    except Exception as e:
        print(f"Error fetching addresses: {e}")
        return pd.DataFrame()

def update_address(address_id, recipient_name, street_address1, street_address2, city, state, postal_code, country):
    print("Inside update address")
    try:
        with get_connection() as conn:
            cursor = conn.cursor()
            query = """
            UPDATE Address
            SET RecipientName = ?, StreetAddress1 = ?, StreetAddress2 = ?, City = ?, [State] = ?, PostalCode = ?, Country = ?
            WHERE AddressID = ?;
            """
            cursor.execute(query, (recipient_name, street_address1, street_address2, city, state, postal_code, country, int(address_id)))
            conn.commit()
            return True
    except Exception as e:
        print(f"Error updating address: {e}")
        return False
    
def get_order_details_by_customer_or_order_id(customer_id=None, order_id=None):
    with get_connection() as conn:
        cursor = conn.cursor()
        if customer_id is not None:
            cursor.execute("EXEC GetOrderDetailsByCustomerOrOrderID @CustomerID=?", int(customer_id))
        elif order_id is not None:
            cursor.execute("EXEC GetOrderDetailsByCustomerOrOrderID @OrderID=?", int(order_id))
        else:
            return pd.DataFrame()  # Return an empty DataFrame if neither parameter is provided

        columns = [column[0] for column in cursor.description]
        results = cursor.fetchall()
        df = pd.DataFrame.from_records(results, columns=columns)
        return df

st.markdown(
    """
    <style>
    @keyframes fadeIn {
        0% { opacity: 0; }
        100% { opacity: 1; }
    }

    .title-animation {
        animation-name: fadeIn;
        animation-duration: 2s;
    }
    </style>
    """,
    unsafe_allow_html=True
)

st.markdown('<h1 class="title-animation">Online Fashion Retail Management</h1>', unsafe_allow_html=True)    
# Streamlit UI
#st.title('Online Fashion Retail Management')

# Choose operation
st.sidebar.title("Operations")
operation = st.sidebar.radio('Choose Operation', ['Read', 'Insert', 'Update'])
# customer_id = st.number_input('Enter Customer ID (leave blank for order ID)', value=0, step=1)
# order_id = st.number_input('Enter Order ID (leave blank for customer ID)', value=0, step=1)
# if st.button('Show Order Details'):
#     # Check which input to use
#     if customer_id > 0:
#         df = get_order_details_by_customer_or_order_id(customer_id=customer_id)
#     elif order_id > 0:
#         df = get_order_details_by_customer_or_order_id(order_id=order_id)
#     else:
#         st.error('Please enter a Customer ID or Order ID.')
#         df = pd.DataFrame()
    
#     # Display the DataFrame
#     if not df.empty:
#         st.write(df)
#     else:
#         st.write('No details found for the provided ID.')
# Define list of table names
table_names = {
    'Read': [
    'Customer', 'Address', 'Cart', 'Brand', 'Category', 'Product', 'CartItem',
    'Inventory', 'InventoryProduct', 'Order', 'OrderDetails', 'Invoice', 'Payment',
    'DeliveryPerson', 'Delivery', 'Review', 'Shipping'
], # and so on for all options
    'Insert': ['Product', 'Customer', 'Address', 'Order', 'CartItem', 'Inventory', 'InventoryProduct', 'Brand', 'DeliveryPerson', 'Review'],       # use your existing lists here
    'Update': ['Customer', 'CartItem', 'Payment', 'Delivery', 'Address'] 
}

if 'cart_items' not in st.session_state:
    st.session_state['cart_items'] = pd.DataFrame()
if operation == 'Read':
        selected_table = st.sidebar.selectbox('Choose Table', table_names['Read']) 
        try:
            if selected_table.lower() == 'order':
                fetch_method = st.radio("Fetch method", ("All Orders", "By Order ID"))
                if fetch_method == "By Order ID":
                    order_id = st.number_input("Enter Order ID", min_value=1)
                    if st.button("Fetch Order Details"):
                      df = read_data(selected_table, order_id=order_id)
                      st.dataframe(df)
                else:
                    df = read_data(selected_table)
                    st.dataframe(df)
            else:
                df = read_data(selected_table)
                st.dataframe(df)
        except Exception as e:
            st.error('Error while fetching the data.')
            st.exception(e)

elif operation == 'Insert':
    selected_table = st.sidebar.selectbox('Choose Table', table_names['Insert'])
    if selected_table == 'Product':
        with st.form("Product Form",clear_on_submit=True):
            brand_id = st.number_input("Brand ID", min_value=1)
            category_id = st.number_input("Category ID", min_value=1)
            price = st.number_input("Price", min_value=0.0, format="%.2f")
            description = st.text_area("Description")
            product_name = st.text_input("Product Name")
            quantity = st.number_input("Quantity", min_value=0)
            size = st.text_input("Size")
            color = st.text_input("Color")
            location = st.text_input("Location")
            batch_number = st.text_input("Batch Number")
            submit_button = st.form_submit_button("Submit Product")

            if submit_button:
                new_product_id, new_inventory_id = add_product(brand_id, category_id, price, description, product_name, quantity, size, color, location, batch_number)
                if new_product_id is not None and new_inventory_id is not None:
                    # Display the new product and inventory IDs
                    st.success(f"Product added successfully with Product ID: {new_product_id} and Inventory ID: {new_inventory_id}")
                else:
                    # In case the stored procedure did not return the IDs
                     st.error("Failed to add the product.")
    if selected_table == 'Customer':
        with st.form("Customer Form", clear_on_submit=True):
            username = st.text_input("Username")
            password = st.text_input("Password", type="password")
            first_name = st.text_input("First Name")
            last_name = st.text_input("Last Name")
            phone_number = st.text_input("Phone Number")
            dob = st.date_input("Date of Birth")
            submit_button = st.form_submit_button("Submit Customer")

            if submit_button:
                create_customer(username, password, first_name, last_name, phone_number, dob)
                st.success("Customer added successfully!")
    if selected_table == 'Address':
        with st.form("Address Form", clear_on_submit=True):
            customer_id = st.number_input("Customer ID", min_value=1)
            recipient_name = st.text_input("Recipient Name")
            street_address1 = st.text_input("Street Address 1")
            street_address2 = st.text_input("Street Address 2", "")
            city = st.text_input("City")
            state = st.text_input("State")
            postal_code = st.text_input("Postal Code")
            country = st.text_input("Country")
            submit_button = st.form_submit_button("Submit Address")

            if submit_button:
                add_address(customer_id, recipient_name, street_address1, street_address2, city, state, postal_code, country)
                st.success(f"Address added successfully for Customer ID: {customer_id}")     
    
    if selected_table == 'Order':
        customer_id = st.number_input("Customer ID", min_value=1,key='customer_id')
        deliveryperson_id = st.number_input("Delivery Person ID", min_value=1)
        address_id = st.number_input("Address ID", min_value=1)
        # Button to load CartItems for the specified Customer ID
        load_cart_items = st.button("Load Cart Items")
        if load_cart_items:
            # Get cart items for the given customer ID and update session state
            cart_items = get_cart_items(customer_id)
            if not cart_items.empty:
                st.session_state['cart_items'] = cart_items
                st.success("Cart items loaded! You can now create an order.")
                # Display cart items in the Streamlit app
                st.write("Cart Items for Customer ID:", customer_id)
                st.dataframe(cart_items)
            else:
                st.session_state['cart_items'] = pd.DataFrame()
                st.warning("No items in the cart for the selected customer.")

        # Check if the 'cart_items' button has been pressed
        if 'cart_items' in st.session_state and not st.session_state['cart_items'].empty:
            submit_order = st.button("Create Order")
            if submit_order:
                result = create_order(customer_id, deliveryperson_id, address_id)
                if result:
                    order_id, invoice_id, payment_id, shipping_id, delivery_id = result
                    st.success(f"Order created successfully with Order ID: {order_id} and InvoiceID: {invoice_id} generated")
                    st.session_state['cart_items'] = pd.DataFrame()
                else:
                    st.error("Failed to create the order.")
        else:
            st.info("Please load cart items before creating an order.")

    if selected_table == 'CartItem':
        with st.form("Add to Cart Form", clear_on_submit=True):
            cart_id = st.number_input("Cart ID", min_value=1)
            product_id = st.number_input("Product ID", min_value=1)
            size = st.text_input("Size")
            discount = st.number_input("Discount (%)", min_value=0.0, max_value=100.0, format="%.2f")
            quantity = st.number_input("Quantity", min_value=1)
            submit_button = st.form_submit_button("Add to Cart")

            if submit_button:
                insert_cart_item(cart_id, product_id, size, discount, quantity)
                st.success("Item added to cart successfully!")    


    if selected_table == 'Inventory':
        with st.form("Add Inventory",clear_on_submit=True):
            quantity = st.number_input("Quantity", min_value=0)
            size = st.selectbox("Size", ["XS", "S", "M", "L", "XL"])
            color = st.text_input("Color")
            submit_button = st.form_submit_button("Add Inventory")
            if submit_button:
                new_inventory_id = insert_inventory(quantity, size, color)
                if new_inventory_id:
                        st.success(f"Inventory added successfully with Inventory ID: {new_inventory_id}")
                        product_id = st.session_state.get('last_added_product_id', None) 
                        location = "Default Location" 
                        batch_number = "Default Batch" 
                        insert_inventory_product(new_inventory_id, product_id, location, batch_number)
                        st.success(f"Inventory Product link added successfully for Inventory ID: {new_inventory_id} and Product ID: {product_id}")
                else:
                        st.error("Failed to add inventory.")

    if selected_table == 'InventoryProduct':
         with st.form("InventoryProduct Form", clear_on_submit=True):
            product_id = st.number_input("Product ID", min_value=1)
            inventory_id = st.number_input("Inventory ID", min_value=1)  # Presuming the user knows the inventory ID to link
            location = st.text_input("Location")
            batch_number = st.text_input("Batch Number")
            submit_button = st.form_submit_button("Link Product to Inventory")
            if submit_button:
             insert_inventory_product(inventory_id, product_id, location, batch_number)
             st.success(f"Linked Product ID {product_id} to Inventory ID {inventory_id} successfully.")
    if selected_table == 'Brand':
        with st.form("Brand Form", clear_on_submit=True):
            brand_name = st.text_input("Brand Name")
            description = st.text_area("Description")
            company_info = st.text_area("Company Info")
            submit_button = st.form_submit_button("Create Brand")

            if submit_button:
                insert_brand(brand_name, description, company_info)
                st.success(f"Brand '{brand_name}' created successfully.")

    if selected_table == 'DeliveryPerson':
     with st.form("Delivery Person Form", clear_on_submit=True):
        first_name = st.text_input("First Name")
        last_name = st.text_input("Last Name")
        phone_number = st.text_input("Phone Number")
        submit_button = st.form_submit_button("Add Delivery Person")

        if submit_button:
            insert_delivery_person(first_name, last_name, phone_number)
            st.success("Delivery person added successfully!")

    if selected_table == 'Review':
        customer_id = st.number_input("Customer ID", min_value=1, format="%d")
    
            # Only initialize the session state once and not on every rerun
            # ...

        if 'delivered_orders_products' not in st.session_state:
            st.session_state['delivered_orders_products'] = pd.DataFrame()

        if st.button("Load Delivered Orders"):
            delivered_orders_products = get_delivered_orders_and_products(customer_id)
            if not delivered_orders_products.empty:
                st.session_state['delivered_orders_products'] = delivered_orders_products
                st.dataframe(delivered_orders_products) 
            else:
                st.warning("No delivered orders found for this customer.")
                st.session_state['delivered_orders_products'] = pd.DataFrame() 

        if not st.session_state['delivered_orders_products'].empty:

            order_product_options = [
                (row.OrderID, row.ProductID, f"Order ID: {row.OrderID} - Product ID: {row.ProductID} - Product Name: {row.ProductName}")
                for index, row in st.session_state['delivered_orders_products'].iterrows()
            ]


            selected_order_product = st.selectbox(
                'Select an Order and Product',
                order_product_options,
                format_func=lambda op: op[2] 
            )

            selected_order_id, selected_product_id = selected_order_product[0], selected_order_product[1]


            with st.form(key='review_form'):
                rating = st.number_input("Rating", min_value=1, max_value=5, format="%d")
                comment = st.text_area("Comment")
                submit_review = st.form_submit_button("Submit Review")

            if submit_review:
                insert_review(customer_id, selected_order_id, selected_product_id, rating, comment)


elif operation == 'Update':
    selected_table = st.sidebar.selectbox('Choose Table',  table_names['Update'])
    if selected_table == 'Customer':
        customer_id = st.number_input('Enter Customer ID', min_value=0, step=1, key='customer_id')

        if customer_id:
            customer_data = get_customer_data(customer_id)
            if not customer_data.empty:
                with st.form(key='customer_update_form'):
                    username = st.text_input('Username', value=customer_data['Username'])
                    password = st.text_input('Password', type='password')
                    first_name = st.text_input('First Name', value=customer_data['FirstName'])
                    last_name = st.text_input('Last Name', value=customer_data['LastName'])
                    phone_number = st.text_input('Phone Number', value=customer_data['PhoneNumber'])
                    dob = st.date_input('Date of Birth', value=pd.to_datetime(customer_data['DOB']))
                    submit_update = st.form_submit_button('Update Customer')
                    
                if submit_update:
                    success = update_customer(customer_id, username, password, first_name, last_name, phone_number, dob)
                    if success:
                        st.success(f"Customer ID {customer_id} updated successfully.")
                    else:
                        st.error("Failed to update customer.")
            else:
                st.error("Customer not found.")
    if selected_table == 'CartItem':
     customer_id = st.number_input("Customer ID", min_value=1, key='customer_id_update_cart')
     available_sizes = ['XS', 'S', 'M', 'L', 'XL']
     load_cart_items = st.button("Load Cart Items")
     if load_cart_items or 'cart_items' in st.session_state:
        if 'cart_items' not in st.session_state or load_cart_items:
            st.session_state['cart_items'] = get_cart_items(customer_id)

        cart_items = get_cart_items(customer_id)
        if not cart_items.empty:
            st.dataframe(cart_items)
            selected_cart_item = st.selectbox('Select Cart Item to Update', cart_items['CartItemID'])
            action = st.radio("Action", ['Update Quantity', 'Change Size','Remove Item'])

            if action == 'Update Quantity':
                new_quantity = st.number_input('New Quantity', min_value=1, value=1, key='new_quantity')
                if st.button('Update Quantity'):
                    update_cart_item_quantity(new_quantity, selected_cart_item)

            elif action == 'Change Size':
                new_size = st.selectbox('Select New Size', available_sizes, key='new_size')
                if st.button('Change Size'):
                    update_cart_item_size(selected_cart_item, new_size)
                    
            elif action == 'Remove Item':
                if st.button('Remove Item'):
                    remove_cart_item(selected_cart_item)
        else:
            st.warning('No items in the cart.')

    if selected_table == 'Payment':
        invoice_number = st.number_input("Enter Invoice Number", min_value=0, step=1, key='invoice_number')

        # Fetch and display invoice details
        if invoice_number:
            invoice_details = get_invoice_details(invoice_number)
            if not invoice_details.empty:
                st.write(invoice_details)
                    
                # Fetch current status
                payment_details=get_payment_details(invoice_number)
                current_status = payment_details['Status'].iloc[0]
                st.write(f"Current Payment Status: {current_status}")

                # New status input
                new_status_options = ['Success', 'Pending', 'Failed']  # Update as per CHECK constraint
                new_status = st.selectbox("Select New Payment Status", new_status_options, key='new_status')
                    
                # Update button
                if st.button('Update Payment Status'):
                    if new_status not in new_status_options:
                        st.error("Invalid payment status.")
                    else:
                        success = update_payment_status(invoice_number, new_status)
                        if success:
                            st.success("Payment status updated successfully.")
                        else:
                            st.error("Failed to update payment status.")
            else:
                st.error("Invoice not found.")
    if selected_table == 'Delivery':
        order_id = st.number_input("Enter Order ID", min_value=1, format="%d")
        load_order_details = st.button("Load Order Details")

        # Use session state to store and retain order details
        if 'order_details' not in st.session_state:
            st.session_state['order_details'] = pd.DataFrame()

        if load_order_details or not st.session_state['order_details'].empty:
            if load_order_details:  # Load details only if the button is clicked
                st.session_state['order_details'] = get_order_details(order_id)

            order_details = st.session_state['order_details']

            if not order_details.empty:
                st.write(order_details)
                if order_details['OrderStatus'].iloc[0] == 'Ready to Ship':
                    new_status = st.selectbox("Select New Status", ['Pending', 'In Transit', 'Delivered', 'Failed'])
                    if st.button("Update Status"):
                        success, message = update_delivery_status(order_details['InvoiceNumber'].iloc[0], new_status)
                        if success:
                            st.success(message)
                        else:
                            st.error(message)
                else:
                    st.warning("Order status is not 'Ready to Ship'. Unable to update delivery status.")
            else:
                st.warning("No order details found for the provided order ID.")

    if selected_table == 'Address':
        customer_id = st.number_input("Customer ID", min_value=1, format="%d")

        # Only one st.button call with a unique key
        load_addresses_clicked = st.button("Load Addresses", key="load_addresses")

        if load_addresses_clicked or 'addresses' in st.session_state:
            if 'addresses' not in st.session_state or load_addresses_clicked:
                st.session_state['addresses'] = get_customer_addresses(customer_id)

            addresses = st.session_state['addresses']

            if not addresses.empty:
                st.write(addresses)
                selected_address_id = st.selectbox("Select Address ID", addresses['AddressID'].unique())

                # Get the details of the selected address
                selected_address = addresses[addresses['AddressID'] == selected_address_id].iloc[0]

                recipient_name = st.text_input("Recipient Name", value=selected_address['RecipientName'], key="recipient_name")
                street_address1 = st.text_input("Street Address 1", value=selected_address['StreetAddress1'], key="street_address1")
                street_address2 = st.text_input("Street Address 2", value=selected_address['StreetAddress2'] or "", key="street_address2")
                city = st.text_input("City", value=selected_address['City'], key="city")
                state = st.text_input("State", value=selected_address['State'], key="state")
                postal_code = st.text_input("Postal Code", value=selected_address['PostalCode'], key="postal_code")
                country = st.text_input("Country", value=selected_address['Country'], key="country")

                if st.button("Update Address", key="update_address"):
                    if update_address(selected_address_id, recipient_name, street_address1, street_address2, city, state, postal_code, country):
                        st.success("Address updated successfully!")
                        # Clear addresses to force refresh on next 'Load Addresses' press
                        del st.session_state['addresses']
                    else:
                        st.error("Failed to update address.")
            else:
                st.warning("This customer does not have any addresses.")


# Close the sidebar operations block with an else statement for a clean finish
else:
    st.sidebar.write("Select an operation.")
