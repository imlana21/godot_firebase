extends Node

var player_point: int = 0: set = set_player_point
var player_coin: float = 0: set = set_player_coin
var player_data: Dictionary = {
    'point': 0,
    'user': '',
    'coin': 0
}: set = set_player_data

func set_player_data(val) -> void:
    var data = {
        'user': await val.get_value('doc_name'),
        'point': await val.get_value('point'),
        'coin': await val.get_value('coin')
    }
    player_data = data
    player_point = int(data.point)
    player_coin = float(data.coin)

func set_player_point(val: int) -> void:
    player_point = val
    player_data.point = val
    var firestore_collection : FirestoreCollection = await Firebase.Firestore.collection('currencies')
    var firestore_document = await firestore_collection.get_doc(player_data.user)
    firestore_document.set('point', val)
    var filestore_update = await firestore_collection.update(firestore_document)
    print("Updated document: " + str(filestore_update))

func set_player_coin(val: float) -> void:
    player_coin = val
    player_data.coin = val
    var firestore_collection : FirestoreCollection = await Firebase.Firestore.collection('currencies')
    var firestore_document = await firestore_collection.get_doc(player_data.user)
    firestore_document.set('coin', val)
    var filestore_update = await firestore_collection.update(firestore_document)
    print("Updated document: " + str(filestore_update))