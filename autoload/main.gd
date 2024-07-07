extends Node

var player_point: int = 0: set = set_player_point
var player_data: Dictionary = {
    'point': 0,
    'user': ''
}: set = set_player_data

func set_player_data(val) -> void:
    var data = {
        'user': await val.get_value('doc_name'),
        'point': await val.get_value('point')
    }
    player_data = data
    player_point = int(data.point)

func set_player_point(val: int) -> void:
    player_point = val
    player_data.point = str(val)
    var firestore_collection : FirestoreCollection = await Firebase.Firestore.collection('points')
    var firestore_document = await firestore_collection.get_doc(player_data.user)
    firestore_document.set('point', str(val))
    var filestore_update = await firestore_collection.update(firestore_document)
    print("Updated document: " + str(filestore_update))
