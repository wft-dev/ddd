class Queries {
  static const String product =
      '''mutation MyMutation(\$id: ID!, \$name: String!, \$type: String!,  \$price: Int!) {
          createProduct(input: {id: \$id, name: \$name, type: \$type, price: \$price}) {
            id
            name
          }
        }
    ''';

  static const String createInventory =
      '''mutation MyMutation(\$id: ID!, \$type: String!) {
          createInventory(input: {\$id: ID!, \$type: String!}) {
            id
            name
          }
        }
    ''';

  static const String createProduct1 =
      '''mutation MyMutation(\$input: [CreateProductInput!]!) {
          createProduct1(input: \$input) {
            id
            name
            type
            price
            userID
          }
        }
    ''';
}
