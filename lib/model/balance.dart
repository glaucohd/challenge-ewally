import 'dart:convert';

Balance balanceFromJson(String str) => Balance.fromJson(json.decode(str));

String balanceToJson(Balance data) => json.encode(data.toJson());

class Balance {
    Balance({
        this.balance,
        this.blockedBalance,
    });

    int balance;
    int blockedBalance;

    factory Balance.fromJson(Map<String, dynamic> json) => Balance(
        balance: json["balance"],
        blockedBalance: json["blockedBalance"],
    );

    Map<String, dynamic> toJson() => {
        "balance": balance,
        "blockedBalance": blockedBalance,
    };
}