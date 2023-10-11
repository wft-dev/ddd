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
import 'package:collection/collection.dart';


/** This is an auto generated class representing the MoreProduct type in your schema. */
class MoreProduct extends amplify_core.Model {
  static const classType = const _MoreProductModelType();
  final String id;
  final List<String>? _products;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  MoreProductModelIdentifier get modelIdentifier {
      return MoreProductModelIdentifier(
        id: id
      );
  }
  
  List<String>? get products {
    return _products;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const MoreProduct._internal({required this.id, products, createdAt, updatedAt}): _products = products, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory MoreProduct({String? id, List<String>? products}) {
    return MoreProduct._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      products: products != null ? List<String>.unmodifiable(products) : products);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MoreProduct &&
      id == other.id &&
      DeepCollectionEquality().equals(_products, other._products);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("MoreProduct {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("products=" + (_products != null ? _products!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  MoreProduct copyWith({List<String>? products}) {
    return MoreProduct._internal(
      id: id,
      products: products ?? this.products);
  }
  
  MoreProduct copyWithModelFieldValues({
    ModelFieldValue<List<String>?>? products
  }) {
    return MoreProduct._internal(
      id: id,
      products: products == null ? this.products : products.value
    );
  }
  
  MoreProduct.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _products = json['products']?.cast<String>(),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'products': _products, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'products': _products,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<MoreProductModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<MoreProductModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final PRODUCTS = amplify_core.QueryField(fieldName: "products");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "MoreProduct";
    modelSchemaDefinition.pluralName = "MoreProducts";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: MoreProduct.PRODUCTS,
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
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
class MoreProductModelIdentifier implements amplify_core.ModelIdentifier<MoreProduct> {
  final String id;

  /** Create an instance of MoreProductModelIdentifier using [id] the primary key. */
  const MoreProductModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
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
    
    return other is MoreProductModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}