/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;

/** This is an auto generated class representing the MoreProduct type in your schema. */
class MoreProduct extends amplify_core.Model {
  static const classType = const _MoreProductModelType();
  final String id;
  final String? _name;
  final String? _type;
  final int? _price;
  final int? _quantity;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;
  final String? _productMoreProductsId;

  @override
  getInstanceType() => classType;

  @Deprecated(
      '[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;

  MoreProductModelIdentifier get modelIdentifier {
    return MoreProductModelIdentifier(id: id);
  }

  String? get name {
    return _name;
  }

  String? get type {
    return _type;
  }

  int? get price {
    return _price;
  }

  int? get quantity {
    return _quantity;
  }

  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }

  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }

  String? get productMoreProductsId {
    return _productMoreProductsId;
  }

  const MoreProduct._internal(
      {required this.id,
      name,
      type,
      price,
      quantity,
      createdAt,
      updatedAt,
      productMoreProductsId})
      : _name = name,
        _type = type,
        _price = price,
        _quantity = quantity,
        _createdAt = createdAt,
        _updatedAt = updatedAt,
        _productMoreProductsId = productMoreProductsId;

  factory MoreProduct(
      {String? id,
      String? name,
      String? type,
      int? price,
      int? quantity,
      String? productMoreProductsId}) {
    return MoreProduct._internal(
        id: id == null ? amplify_core.UUID.getUUID() : id,
        name: name,
        type: type,
        price: price,
        quantity: quantity,
        productMoreProductsId: productMoreProductsId);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MoreProduct &&
        id == other.id &&
        _name == other._name &&
        _type == other._type &&
        _price == other._price &&
        _quantity == other._quantity &&
        _productMoreProductsId == other._productMoreProductsId;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("MoreProduct {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("type=" + "$_type" + ", ");
    buffer.write(
        "price=" + (_price != null ? _price!.toString() : "null") + ", ");
    buffer.write("quantity=" +
        (_quantity != null ? _quantity!.toString() : "null") +
        ", ");
    buffer.write("createdAt=" +
        (_createdAt != null ? _createdAt!.format() : "null") +
        ", ");
    buffer.write("updatedAt=" +
        (_updatedAt != null ? _updatedAt!.format() : "null") +
        ", ");
    buffer.write("productMoreProductsId=" + "$_productMoreProductsId");
    buffer.write("}");

    return buffer.toString();
  }

  MoreProduct copyWith(
      {String? name,
      String? type,
      int? price,
      int? quantity,
      String? productMoreProductsId}) {
    return MoreProduct._internal(
        id: id,
        name: name ?? this.name,
        type: type ?? this.type,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
        productMoreProductsId:
            productMoreProductsId ?? this.productMoreProductsId);
  }

  MoreProduct copyWithModelFieldValues(
      {ModelFieldValue<String?>? name,
      ModelFieldValue<String?>? type,
      ModelFieldValue<int?>? price,
      ModelFieldValue<int?>? quantity,
      ModelFieldValue<String?>? productMoreProductsId}) {
    return MoreProduct._internal(
        id: id,
        name: name == null ? this.name : name.value,
        type: type == null ? this.type : type.value,
        price: price == null ? this.price : price.value,
        quantity: quantity == null ? this.quantity : quantity.value,
        productMoreProductsId: productMoreProductsId == null
            ? this.productMoreProductsId
            : productMoreProductsId.value);
  }

  MoreProduct.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _name = json['name'],
        _type = json['type'],
        _price = (json['price'] as num?)?.toInt(),
        _quantity = (json['quantity'] as num?)?.toInt(),
        _createdAt = json['createdAt'] != null
            ? amplify_core.TemporalDateTime.fromString(json['createdAt'])
            : null,
        _updatedAt = json['updatedAt'] != null
            ? amplify_core.TemporalDateTime.fromString(json['updatedAt'])
            : null,
        _productMoreProductsId = json['productMoreProductsId'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': _name,
        'type': _type,
        'price': _price,
        'quantity': _quantity,
        'createdAt': _createdAt?.format(),
        'updatedAt': _updatedAt?.format(),
        'productMoreProductsId': _productMoreProductsId
      };

  Map<String, Object?> toMap() => {
        'id': id,
        'name': _name,
        'type': _type,
        'price': _price,
        'quantity': _quantity,
        'createdAt': _createdAt,
        'updatedAt': _updatedAt,
        'productMoreProductsId': _productMoreProductsId
      };

  static final amplify_core.QueryModelIdentifier<MoreProductModelIdentifier>
      MODEL_IDENTIFIER =
      amplify_core.QueryModelIdentifier<MoreProductModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final NAME = amplify_core.QueryField(fieldName: "name");
  static final TYPE = amplify_core.QueryField(fieldName: "type");
  static final PRICE = amplify_core.QueryField(fieldName: "price");
  static final QUANTITY = amplify_core.QueryField(fieldName: "quantity");
  static final PRODUCTMOREPRODUCTSID =
      amplify_core.QueryField(fieldName: "productMoreProductsId");
  static var schema = amplify_core.Model.defineSchema(
      define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "MoreProduct";
    modelSchemaDefinition.pluralName = "MoreProducts";

    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());

    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
        key: MoreProduct.NAME,
        isRequired: false,
        ofType: amplify_core.ModelFieldType(
            amplify_core.ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
        key: MoreProduct.TYPE,
        isRequired: false,
        ofType: amplify_core.ModelFieldType(
            amplify_core.ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
        key: MoreProduct.PRICE,
        isRequired: false,
        ofType:
            amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
        key: MoreProduct.QUANTITY,
        isRequired: false,
        ofType:
            amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(
        amplify_core.ModelFieldDefinition.nonQueryField(
            fieldName: 'createdAt',
            isRequired: false,
            isReadOnly: true,
            ofType: amplify_core.ModelFieldType(
                amplify_core.ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(
        amplify_core.ModelFieldDefinition.nonQueryField(
            fieldName: 'updatedAt',
            isRequired: false,
            isReadOnly: true,
            ofType: amplify_core.ModelFieldType(
                amplify_core.ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
        key: MoreProduct.PRODUCTMOREPRODUCTSID,
        isRequired: false,
        ofType: amplify_core.ModelFieldType(
            amplify_core.ModelFieldTypeEnum.string)));
  });
}

class _MoreProductModelType extends amplify_core.ModelType<MoreProduct> {
  const _MoreProductModelType();

  @override
  MoreProduct fromJson(Map<String, dynamic> jsonData) {
    return MoreProduct.fromJson(jsonData);
  }

  @override
  String modelName() {
    return 'MoreProduct';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [MoreProduct] in your schema.
 */
class MoreProductModelIdentifier
    implements amplify_core.ModelIdentifier<MoreProduct> {
  final String id;

  /** Create an instance of MoreProductModelIdentifier using [id] the primary key. */
  const MoreProductModelIdentifier({required this.id});

  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{'id': id});

  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
      .entries
      .map((entry) => (<String, dynamic>{entry.key: entry.value}))
      .toList();

  @override
  String serializeAsString() => serializeAsMap().values.join('#');

  @override
  String toString() => 'MoreProductModelIdentifier(id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is MoreProductModelIdentifier && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
