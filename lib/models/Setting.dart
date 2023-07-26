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


/** This is an auto generated class representing the Setting type in your schema. */
class Setting extends amplify_core.Model {
  static const classType = const _SettingModelType();
  final String id;
  final String? _name;
  final String? _type;
  final int? _price;
  final int? _quantity;
  final amplify_core.TemporalDateTime? _date;
  final String? _userID;
  final bool? _isDefault;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  SettingModelIdentifier get modelIdentifier {
      return SettingModelIdentifier(
        id: id
      );
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
  
  amplify_core.TemporalDateTime? get date {
    return _date;
  }
  
  String get userID {
    try {
      return _userID!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  bool? get isDefault {
    return _isDefault;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Setting._internal({required this.id, name, type, price, quantity, date, required userID, isDefault, createdAt, updatedAt}): _name = name, _type = type, _price = price, _quantity = quantity, _date = date, _userID = userID, _isDefault = isDefault, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Setting({String? id, String? name, String? type, int? price, int? quantity, amplify_core.TemporalDateTime? date, required String userID, bool? isDefault}) {
    return Setting._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      name: name,
      type: type,
      price: price,
      quantity: quantity,
      date: date,
      userID: userID,
      isDefault: isDefault);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Setting &&
      id == other.id &&
      _name == other._name &&
      _type == other._type &&
      _price == other._price &&
      _quantity == other._quantity &&
      _date == other._date &&
      _userID == other._userID &&
      _isDefault == other._isDefault;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Setting {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("type=" + "$_type" + ", ");
    buffer.write("price=" + (_price != null ? _price!.toString() : "null") + ", ");
    buffer.write("quantity=" + (_quantity != null ? _quantity!.toString() : "null") + ", ");
    buffer.write("date=" + (_date != null ? _date!.format() : "null") + ", ");
    buffer.write("userID=" + "$_userID" + ", ");
    buffer.write("isDefault=" + (_isDefault != null ? _isDefault!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Setting copyWith({String? name, String? type, int? price, int? quantity, amplify_core.TemporalDateTime? date, String? userID, bool? isDefault}) {
    return Setting._internal(
      id: id,
      name: name ?? this.name,
      type: type ?? this.type,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      date: date ?? this.date,
      userID: userID ?? this.userID,
      isDefault: isDefault ?? this.isDefault);
  }
  
  Setting copyWithModelFieldValues({
    ModelFieldValue<String?>? name,
    ModelFieldValue<String?>? type,
    ModelFieldValue<int?>? price,
    ModelFieldValue<int?>? quantity,
    ModelFieldValue<amplify_core.TemporalDateTime?>? date,
    ModelFieldValue<String>? userID,
    ModelFieldValue<bool?>? isDefault
  }) {
    return Setting._internal(
      id: id,
      name: name == null ? this.name : name.value,
      type: type == null ? this.type : type.value,
      price: price == null ? this.price : price.value,
      quantity: quantity == null ? this.quantity : quantity.value,
      date: date == null ? this.date : date.value,
      userID: userID == null ? this.userID : userID.value,
      isDefault: isDefault == null ? this.isDefault : isDefault.value
    );
  }
  
  Setting.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _type = json['type'],
      _price = (json['price'] as num?)?.toInt(),
      _quantity = (json['quantity'] as num?)?.toInt(),
      _date = json['date'] != null ? amplify_core.TemporalDateTime.fromString(json['date']) : null,
      _userID = json['userID'],
      _isDefault = json['isDefault'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'type': _type, 'price': _price, 'quantity': _quantity, 'date': _date?.format(), 'userID': _userID, 'isDefault': _isDefault, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'name': _name,
    'type': _type,
    'price': _price,
    'quantity': _quantity,
    'date': _date,
    'userID': _userID,
    'isDefault': _isDefault,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<SettingModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<SettingModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final NAME = amplify_core.QueryField(fieldName: "name");
  static final TYPE = amplify_core.QueryField(fieldName: "type");
  static final PRICE = amplify_core.QueryField(fieldName: "price");
  static final QUANTITY = amplify_core.QueryField(fieldName: "quantity");
  static final DATE = amplify_core.QueryField(fieldName: "date");
  static final USERID = amplify_core.QueryField(fieldName: "userID");
  static final ISDEFAULT = amplify_core.QueryField(fieldName: "isDefault");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Setting";
    modelSchemaDefinition.pluralName = "Settings";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Setting.NAME,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Setting.TYPE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Setting.PRICE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Setting.QUANTITY,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Setting.DATE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Setting.USERID,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Setting.ISDEFAULT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
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

class _SettingModelType extends amplify_core.ModelType<Setting> {
  const _SettingModelType();
  
  @override
  Setting fromJson(Map<String, dynamic> jsonData) {
    return Setting.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Setting';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Setting] in your schema.
 */
class SettingModelIdentifier implements amplify_core.ModelIdentifier<Setting> {
  final String id;

  /** Create an instance of SettingModelIdentifier using [id] the primary key. */
  const SettingModelIdentifier({
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
  String toString() => 'SettingModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is SettingModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}