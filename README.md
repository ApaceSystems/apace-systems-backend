# apace-systems-backend
Backend for Apace Systems - Elevator components manufacturer.

## Technologies Used
- Ruby on Rails
- GraphQL
- PostgreSQL

## Setup Instructions
1. Install Ruby (version 3.3.1) and Rails (version 7.1.3 or higher)
2. Clone the repository: 
   ```
   git clone https://github.com/apacesystems/apace-systems-backend.git
   ```
3. Navigate to the project directory:
   ```
   cd apace-systems-backend
   ```
4. Install dependencies:
   ```
   bundle install
   ```
5. Set up the database:
   ```
   rails db:create
   rails db:migrate
   rails db:seed
   ```
6. Start the server:
   ```
   rails server
   ```
   
The GraphQL endpoint will be available at `http://localhost:3000/graphql`.

## GraphQL Schema
The backend provides the following main GraphQL types and operations:

### Types
- `Category`: Represents a product category
- `Product`: Represents a product

### Queries
- `categories`: Retrieves all categories
- `category(id: ID!)`: Retrieves a specific category by ID
- `products(categoryId: ID!, filters...)`: Retrieves products for a specific category with optional filters

### Mutations
- `createCategory(input: CategoryInput!)`: Creates a new category
- `updateCategory(id: ID!, input: CategoryInput!)`: Updates an existing category
- `deleteCategory(id: ID!)`: Deletes a category
- `createProduct(input: ProductInput!)`: Creates a new product
- `updateProduct(id: ID!, input: ProductInput!)`: Updates an existing product
- `deleteProduct(id: ID!)`: Deletes a product

For detailed information about the GraphQL schema, please refer to the schema definition files in the `app/graphql` directory.

## Contributing
Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

## License
This project is licensed under the MIT License.