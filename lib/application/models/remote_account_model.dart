import '../../domain/entities/entities.dart';
import '../clients/clients.dart';

class RemoteAccountModel{
  final String accessToken;

  RemoteAccountModel({required this.accessToken});

  factory RemoteAccountModel.fromJson(Map json){
    if(!json.containsKey("accessToken")){
      throw ClientError.invalidData;
    }
    return RemoteAccountModel(accessToken: json["accessToken"]);
  }

  AccountEntity toEntity() => AccountEntity(token: accessToken);
}