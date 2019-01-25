---
id: version-2.1.6-Account
title: Аккаунт
sidebar_label: Аккаунт
original_id: Account
---


# Система разрешений Аккаунта

## Обзор

Система доступа аккаунта IOST основана на механизме пар публичного-приватного ключей. Устанавливая ключ владельца и активный ключ, пользователи могут удобно управлять несколькими аккаунтами и в то же время настраивать новые доступы и секретный вес по желанию. Это обеспечивает множество индивидуальных функций управления.

## Основы системы аккаунта

Аккаунт IOST создается с ID и разрешениями. У аккаунта может быть несколько разрешений, и как минимум `owner`(владелец) и `active`(активный) разрешения. Каждое разрешение будет регистрировать несколько элементов, причем одним элементом является ID публичного ключа, или пара разрешений из другого аккаунта.

Публичный ключ это строка состоящая из префикса `IOST`  + закодированный функцией Base58-encoded публичный ключ + контрольная цифра crc32.

Пара разрешений может быть строкой, состоящей из account_name@permission_name (имя_аккаунта@имя_разрешения).

Каждый элемент имеет определенный вес; соответственно, каждое разрешение имеет порог. Когда элемент транзакции имеет вес, превышающий пороговое значение, транзакция допускает это разрешение.

Метод проверки владения элементом заключается в проверке, содержат ли подписи транзакции подпись для публичного ключа этого определенного элемента (в случае, когда элементом является публичный ключ), или рекурсивной проверки, содержит ли транзакция пару аккаунт-разрешение этого элемента (в случае, когда элементом является пара аккаунт-разрешение).

Как правило, при проверке разрешений смарт-контракты представляют свои ID аккаунта и ID разрешения. Система проверит подписи транзакции, вычислит вес элементов и, при условии удовлетворения подписью пороговых требований, подтверждает транзакцию. В противном случае, подтверждения не происходит.

Разрешение `active`(активный) может предоставлять все другие разрешения, кроме разрешения `owner`(владелец). Разрешение `owner` может предоставлять тот же набор разрешений и позволяет вносить изменения в элементы с разрешениями `owner` и `active`. Разрешение `active` требуется при отправке транзакции.

Разрешения могут работать с группами. Вы можете добавить разрешения в группу и добавить элементы в эту группу. Таким образом, элементы будут пользоваться всеми разрешениями этой группы.

## Использование системы аккаунта

Для смарт-контрактов есть простой API для вызова.

```
blockchain.requireAuth(id, permission_string)
```

Это вернет логическое значение для вас, чтобы решить, должна ли операция продолжаться.

Как правило, при использовании Ram и Tokens  вы должны сначала проверить разрешение `active` пользователя, иначе смарт-контракт не выполниться. Укажите уникальную строку для `permission_string`, чтобы минимизировать разрешение.

Как правило, вам не следует требовать разрешения `owner`, поскольку у пользователей не следует запрашивать ключ владельца кроме случая, когда они изменяют разрешения `owner` и `active`.

Нет необходимости требовать отправителя транзакции, так как у него всегда есть разрешение `active`.

На уровне пользователя, только предоставляя подпись, мы видим, что пользователи добавляют разрешения. Возьмем два аккаунта (и предположим один со всеми пороговыми значениями и весами элементов ключей):

```
User0
├── Groups
│   └── grp0: key3
└── Permissions
    ├── owner: key0
    ├── active: key1
    ├── perm0: key2, grp0
    ├── perm1: User1@active, grp0
    ├── perm2(threshold = 2): key4, key5, grp0
    ├── perm3: key8
    └── perm4(threshold = 2): User@perm3, key9

User1
└── Permissions
    ├── owner: key6
    └── active: key7
```

Форма RequireAuth

Параметры	|Ключ подписи	  |Возвращаемое значение    |Примечания
-----	      |----				|------	    |-------
User0, perm0		|key2			|true			|Разрешение предоставляется при наличии подписи для публичного ключа
User0, perm0		|key3			|true			|Разрешение предоставляется при условии подписи группы
User0, perm0		|key1			|true			|Разрешение предоставлены (за исключением разрешения `owner`), когда ключ `active` предоставлен
User0, perm1		|key7			|true			|key7 предоставляет разрешение User1@active, таким образом, предоставляя perm1
User0, owner		|key1			|false		|`active` не предоставляет разрешение `owner`
User0, active		|key0			|true			|`owner` предоставляет все разрешения
User0, perm2		|key4			|false		|Подписи не достигли пороговое значение
User0, perm2		|key4,key5	|true			|Подписи достигли пороговое значение
User0, perm2		|key3			|true			|Группа разрешений не рассчитывает и не проверяет пороговое значение
User0, perm2		|key1			|true			|`active` не проверяет пороговое значение
User0, perm4		|key8			|false		|Может быть реализовано при расчете веса группы разрешений

## Создание и управление Аккаунтами

Управление аккаунтом основано на контракте `auth.iost`. Со следующим ABI:

```
{
  "lang": "javascript",
  "version": "1.0.0",
  "abi": [
    {
      "name": "SignUp", // Create account
      "args": ["string", "string", "string"] // Username, ownerKey ID, activeKey ID
    },
    {
      "name": "AddPermission", // Add permission
      "args": ["string", "string", "number"] // Username, permission name, threshold
    },
    {
      "name": "DropPermission", // Drop permission
      "args": ["string", "string"] // Username, permission name
    },
    {
      "name": "AssignPermission", // Assign permission to an item
      "args": ["string", "string", "string","number"] // Username, permission, public key ID or account_name@permission_name, weight
    },
    {
      "name": "RevokePermission",    // Revoke permission
      "args": ["string", "string", "string"] // Username, permission, public key ID or account_name@permission_name
    },
    {
      "name": "AddGroup",   // Add permission group
      "args": ["string", "string"] // Username, group name
    },
    {
      "name": "DropGroup",   // Drop group
      "args": ["string", "string"] // Username, group name
    },
    {
      "name": "AssignGroup", // Assign item to group
      "args": ["string", "string", "string", "number"] // Username, group name, public key ID or account_name@permission_name, weight
    },
    {
      "name": "RevokeGroup",    // Revoke group
      "args": ["string", "string", "string"] // Username, group name, public key ID or account_name@permission_name
    },
    {
      "name": "AssignPermissionToGroup", // Assign permission to group
      "args": ["string", "string", "string"] // Username, permission name, group name
    },
    {
      "name": "RevokePermissionInGroup", // Revoke permissions from a group
      "args": ["string", "string", "string"] // Username, permission name, group name
    }
  ]
}
```

Имя аккаунта действительно только с `[a-z0-9_]` длиной от 5 до 11. Имя разрешения и имена групп действительны только с `[a-zA-Z0-9_]` длиной от 1 до 32.

Как правило, на баланс аккаунта необходимо перевести IOST или аккаунт может не использоваться. Один из способов сделать это с `iost.js`:

```
newAccount(name, ownerkey, activekey, initialRAM, initialGasPledge) {
    const t = new Tx(this.config.gasPrice, this.config.gasLimit, this.config.delay);
    t.addAction("iost.auth", "SignUp", JSON.stringify([name, ownerkey, activekey]));
    t.addAction("iost.ram", "buy", JSON.stringify([this.publisher, name, initialRAM]));
    t.addAction("iost.gas", "pledge", JSON.stringify([this.publisher, name, initialGasPledge]));
    return t
}
```

С целью оптимизации процесса создания аккаунта комиссия расчитывается следующим образом: комиссия за создание аккаунта GAS взимается с пользователя и Ram нового аккаунта оплачивает пользователь. Когда Ram накапливается до той же суммы, пользователь получает Ram обратно. Созданный аккаунт затем будет "платить" за создание аккаунта.

При создании аккаунта вы можете выбрать покупку Ram и внести токены на депозит для созданого аккаунта. Мы рекомендуем внести не менее 10 токенов, чтобы на новом аккаунте было достаточно газа для использования сети. Депозитный GAS должен быть не менее 10 токенов, чтобы обеспечить достаточное количество GAS для покупки ресурсов.
