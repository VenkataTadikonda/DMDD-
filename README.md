# DMDD-Project
## Online Fashion Retail Database Management System

This repository contains the necessary files and instructions for setting up and managing the database for an Online Fashion Retail system, as well as running a Streamlit application that interfaces with this database.

### Prerequisites

- Python 3.x
- pip (Python package installer)
- Microsoft Sql Server 

### Setting Up the Database

1. **Database Creation**: Start by creating your database schema using the `P4 DDL.sql` file. This file contains the Data Definition Language (DDL) statements required to create tables and other associated database objects.

2. **Applying Constraints**: Next, use the `Table Level Check Constraints.sql` file to apply constraints to your tables to maintain data integrity.

3. **Populating Data**: Use the `P4 Data Insertion.sql` file to populate your tables with initial data.

4. **Creating Views**: Utilize the `P4 Views.sql` file to create views for easy data retrieval.

5. **Adding User Defined Functions**: Implement functions using the `P4 User Defined Function.sql` file for calculations and data manipulation.
   
6. **Creating Stored Procedures**: Finally, use the `P4 stored procedures.sql` file to create stored procedures that encapsulate common operations for the application.

7. **Setting Triggers**: The `P4 Triggers.sql` file is used to define triggers for automating tasks upon data changes.

8. **Indexing**: For optimizing data access and retrieval, use the `P4 NonClustered Index.sql` to create non-clustered indexes.



### Running Streamlit Application

To run the Streamlit application that interfaces with this database:

1. **Installation**: Ensure that you have Python installed on your system. Then, install Streamlit using pip:

   ```sh
   pip install streamlit
   ```
2. **Launching the App**: Navigate to the directory containing your Streamlit script (app.py) and run the following command:    

    ```sh
    streamlit run app.py
    ```
This command will start the Streamlit server, and the app should automatically open in your default web browser. If it doesn't, you can manually navigate to the local server address that the command line outputs, which is typically http://localhost:8501.
