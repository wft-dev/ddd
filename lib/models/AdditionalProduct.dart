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

/** This is an auto generated class representing the AdditionalProduct type in your schema. */
class AdditionalProduct extends amplify_core.Model {
  static const classType = const _AdditionalProductModelType();
  final String id;
  final String? _productID;
  final String? _name;
  final String? _price;
  final int? _quantity;
  final String? _type;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;
  final String? _productItemsId;

  @override
  getInstanceType() => classType;

  @Deprecated(
      '[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;

  AdditionalProductModelIdentifier get modelIdentifier {
    return AdditionalProductModelIdentifier(id: id);
  }

  String get productID {
    try {
      return _productID!;
    } catch (e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion: amplify_core.AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString());
    }
  }

  String get name {
    try {
      return _name!;
    } catch (e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion: amplify_core.AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString());
    }
  }

  String get price {
    try {
      return _price!;
    } catch (e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion: amplify_core.AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString());
    }
  }

  int get quantity {
    try {
      return _quantity!;
    } catch (e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion: amplify_core.AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString());
    }
  }

  String? get type {
    return _type;
  }

  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }

  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }

  String? get productItemsId {
    return _productItemsId;
  }

  const AdditionalProduct._internal(
      {required this.id,
      required productID,
      required name,
      required price,
      required quantity,
      type,
      createdAt,
      updatedAt,
      productItemsId})
      : _productID = productID,
        _name = name,
        _price = price,
        _quantity = quantity,
        _type = type,
        _createdAt = createdAt,
        _updatedAt = updatedAt,
        _productItemsId = productItemsId;

  factory AdditionalProduct(
      {String? id,
      required String productID,
      required String name,
      required String price,
      required int quantity,
      String? type,
      String? productItemsId}) {
    return AdditionalProduct._internal(
        id: id == null ? amplify_core.UUID.getUUID() : id,
        productID: productID,
        name: name,
        price: price,
        quantity: quantity,
        type: type,
        productItemsId: productItemsId);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdditionalProduct &&
        id == other.id &&
        _productID == other._productID &&
        _name == other._name &&
        _price == other._price &&
        _quantity == other._quantity &&
        _type == other._type &&
        _productItemsId == other._productItemsId;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("AdditionalProduct {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("productID=" + "$_productID" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("price=" + "$_price" + ", ");
    buffer.write("quantity=" +
        (_quantity != null ? _quantity!.toString() : "null") +
        ", ");
    buffer.write("type=" + "$_type" + ", ");
    buffer.write("createdAt=" +
        (_createdAt != null ? _createdAt!.format() : "null") +
        ", ");
    buffer.write("updatedAt=" +
        (_updatedAt != null ? _updatedAt!.format() : "null") +
        ", ");
    buffer.write("productItemsId=" + "$_productItemsId");
    buffer.write("}");

    return buffer.toString();
  }

  AdditionalProduct copyWith(
      {String? productID,
      String? name,
      String? price,
      int? quantity,
      String? type,
      String? productItemsId}) {
    return AdditionalProduct._internal(
        id: id,
        productID: productID ?? this.productID,
        name: name ?? this.name,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
        type: type ?? this.type,
        productItemsId: productItemsId ?? this.productItemsId);
  }

  AdditionalProduct copyWithModelFieldValues(
      {ModelFieldValue<String>? productID,
      ModelFieldValue<String>? name,
      ModelFieldValue<String>? price,
      ModelFieldValue<int>? quantity,
      ModelFieldValue<String?>? type,
      ModelFieldValue<String?>? productItemsId}) {
    return AdditionalProduct._internal(
        id: id,
        productID: productID == null ? this.productID : productID.value,
        name: name == null ? this.name : name.value,
        price: price == null ? this.price : price.value,
        quantity: quantity == null ? this.quantity : quantity.value,
        type: type == null ? this.type : type.value,
        productItemsId: productItemsId == null
            ? this.productItemsId
            : productItemsId.value);
  }

  AdditionalProduct.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _productID = json['productID'],
        _name = json['name'],
        _price = json['price'],
        _quantity = (json['quantity'] as num?)?.toInt(),
        _type = json['type'],
        _createdAt = json['createdAt'] != null
            ? amplify_core.TemporalDateTime.fromString(json['createdAt'])
            : null,
        _updatedAt = json['updatedAt'] != null
            ? amplify_core.TemporalDateTime.fromString(json['updatedAt'])
            : null,
        _productItemsId = json['productItemsId'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'productID': _productID,
        'name': _name,
        'price': _price,
        'quantity': _quantity,
        'type': _type,
        'createdAt': _createdAt?.format(),
        'updatedAt': _updatedAt?.format(),
        'productItemsId': _productItemsId
      };

  Map<String, Object?> toMap() => {
        'id': id,
        'productID': _productID,
        'name': _name,
        'price': _price,
        'quantity': _quantity,
        'type': _type,
        'createdAt': _createdAt,
        'updatedAt': _updatedAt,
        'productItemsId': _productItemsId
      };

  static final amplify_core
          .QueryModelIdentifier<AdditionalProductModelIdentifier>
      MODEL_IDENTIFIER =
      amplify_core.QueryModelIdentifier<AdditionalProductModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final PRODUCTID = amplify_core.QueryField(fieldName: "productID");
  static final NAME = amplify_core.QueryField(fieldName: "name");
  static final PRICE = amplify_core.QueryField(fieldName: "price");
  static final QUANTITY = amplify_core.QueryField(fieldName: "quantity");
  static final TYPE = amplify_core.QueryField(fieldName: "type");
  static final PRODUCTITEMSID =
      amplify_core.QueryField(fieldName: "productItemsId");
  static var schema = amplify_core.Model.defineSchema(
      define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "AdditionalProduct";
    modelSchemaDefinition.pluralName = "AdditionalProducts";

    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());

    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
        key: AdditionalProduct.PRODUCTID,
        isRequired: true,
        ofType: amplify_core.ModelFieldType(
            amplify_core.ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
        key: AdditionalProduct.NAME,
        isRequired: true,
        ofType: amplify_core.ModelFieldType(
            amplify_core.ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
        key: AdditionalProduct.PRICE,
        isRequired: true,
        ofType: amplify_core.ModelFieldType(
            amplify_core.ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
        key: AdditionalProduct.QUANTITY,
        isRequired: true,
        ofType:
            amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
        key: AdditionalProduct.TYPE,
        isRequired: false,
        ofType: amplify_core.ModelFieldType(
            amplify_core.ModelFieldTypeEnum.string)));

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
        key: AdditionalProduct.PRODUCTITEMSID,
        isRequired: false,
        ofType: amplify_core.ModelFieldType(
            amplify_core.ModelFieldTypeEnum.string)));
  });
}

class _AdditionalProductModelType
    extends amplify_core.ModelType<AdditionalProduct> {
  const _AdditionalProductModelType();

  @override
  AdditionalProduct fromJson(Map<String, dynamic> jsonData) {
    return AdditionalProduct.fromJson(jsonData);
  }

  @override
  String modelName() {
    return 'AdditionalProduct';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [AdditionalProduct] in your schema.
 */
class AdditionalProductModelIdentifier
    implements amplify_core.ModelIdentifier<AdditionalProduct> {
  final String id;

  /** Create an instance of AdditionalProductModelIdentifier using [id] the primary key. */
  const AdditionalProductModelIdentifier({required this.id});

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
  String toString() => 'AdditionalProductModelIdentifier(id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is AdditionalProductModelIdentifier && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
