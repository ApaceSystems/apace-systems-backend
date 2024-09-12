# apace-systems-backend
Backend for ~~Apace Systems~~ **Elevator and Industrial Component Manufacturers**.

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

## Future Enhancements
Further plans to make the backend more generic and adaptable for various companies in the elevator and industrial component manufacturing industry. The following enhancements are planned:

1. [] **Configurable Categories and Products**: The backend will support fully configurable categories and product types, allowing different companies to set up their own product hierarchies.
2. [] **Custom Fields**: The app will introduce custom fields for products and categories, enabling manufacturers to store and retrieve company-specific attributes.
3. [] **Multi-tenancy**: The backend architecture will be redesigned to support multi-tenancy, allowing multiple companies to use the same system with their own isolated data.
4. [] **Flexible Authentication**: A flexible authentication system will be implemented to support integration with various identity providers or company-specific authentication mechanisms.
5. [] **Customizable Workflows**: The backend will provide the foundation for customizable workflows, allowing companies to define their own approval processes and order flows.
6. [] **API Enhancements**: The GraphQL API will be expanded to support more advanced queries and mutations, catering to the diverse needs of different companies.
7. [] **Scalability and Performance**: Optimizations will be made to ensure the backend can handle high traffic and scale efficiently as more companies adopt the solution.

These enhancements will transform the backend into a robust and flexible foundation for supporting the needs of various companies in the elevator and industrial component manufacturing industry.

## Contributing
Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

## License
This project is licensed under the MIT License.