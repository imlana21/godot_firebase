extends Node

var player_data: Dictionary = {
    'point': 0,
    'user': '',
    'coin': 0,
    'level': 0,
    'max_point': 0
}: set = set_player_data
var prevent_mouse: bool = false

func set_player_data(val) -> void:
    var data = {
        'user': await val.get_value('doc_name'),
        'point': int(await val.get_value('point')),
        'coin': float(await val.get_value('coin')),
        'level': int(await val.get_value('level')),
        'max_point': int(await val.get_value('max_point'))
    }
    player_data = data
    init_level()
    update_database()
    print(data)

func update_database() -> void:
    var firestore_collection : FirestoreCollection = await Firebase.Firestore.collection('currencies')
    var firestore_document: FirestoreDocument = await firestore_collection.get_doc(player_data.user)
    firestore_document.set('point', int(player_data.point))
    firestore_document.set('coin', float(player_data.coin))
    firestore_document.set('level', int(player_data.level))
    firestore_document.set('max_point', int(player_data.max_point))
    var filestore_update = await firestore_collection.update(firestore_document)
    print("Updated document: " + str(filestore_update))

func init_level():
    if player_data.max_point == 0:
        player_data.level = 1
        player_data.max_point = 100
        update_database()

func level_up(val: int) -> bool: 
    print(val)
    player_data.point += val
    while player_data.point >= player_data.max_point:
        player_data.level += 1
        player_data.point -= player_data.max_point
        player_data.max_point = round(float(player_data.max_point) * 1.3)
        if player_data.point < player_data.max_point:
            update_database()
            return true
    update_database()
    return false

# func get_unique_randomize() -> int:
#     var rand_number = randi_range(1, 300)
#     while rand_number in registered_number:
#         rand_number = randi_range(1, 300)
#     registered_number.append(rand_number)
#     return rand_number