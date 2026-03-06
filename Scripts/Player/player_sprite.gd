extends CanvasGroup

@export_category("Appearance")
@export_group("Randomizer")
@export var randomizePlayer = false
@export var skinColorCount = 16
@export var hairColorCount = 15
@export var hairstyleCount = 4
@export var shirtCount = 3
@export var trousersCount = 3
@export_group("")
@export_enum("Warm Ivory","Sienna","Honey","Umber"
,"Sand","Limestone","Band","Golden"
,"Pale Ivory","Beige","Almond","Expresso"
,"Rose Beige","Amber","Bronze","Chocolate") var playerSkinColor := 0
var playerSkinColorList = [
	Color.hex(0xfde7adff), Color.hex(0xd49e7aff), Color.hex(0xcf965fff), Color.hex(0xb26644ff),
	Color.hex(0xf8d998ff), Color.hex(0xecc091ff), Color.hex(0xad8a60ff), Color.hex(0x7f4422ff),
	Color.hex(0xfee4c3ff), Color.hex(0xf2c280ff), Color.hex(0x935f37ff), Color.hex(0x5e320fff),
	Color.hex(0xf9d4a0ff), Color.hex(0xbb6536ff), Color.hex(0x733f17ff), Color.hex(0x281608ff)
	]
@export_enum("Black", "Coffee", "Ash", "Copper", "Wood",
"Blonde-Red", "Deep Red", "Ash-Blonde", "Natural-Blonde", "Extreme Blonde",
"Lime", "Magenta", "Light Blue", "Deep Blue", "Purple") var playerHairColor := 0
var playerHairColorList = [
	Color.hex(0x444547ff), Color.hex(0x654b4cff), Color.hex(0x514036ff), Color.hex(0x412814ff), Color.hex(0x98825bff),
	Color.hex(0x845132ff), Color.hex(0x762514ff), Color.hex(0x886d5aff), Color.hex(0xa99272ff), Color.hex(0xcebfa0ff),
	Color.hex(0x66ff33ff), Color.hex(0xff33ccff), Color.hex(0x66ffffff), Color.hex(0x0000ccff), Color.hex(0x990099ff)
]
@export_enum("None","Long","Shaggy Beard","Short") var playerHairstyle := 0
@export_enum("None","Black Suit","Blue Heart Longsleeve") var playerShirt := 0
@export_enum("None","Blue Jeans","Pink Tutu") var playerTrousers := 0

@export_group("Sprites [DEV]")
@export var hairSprites : Array[AnimatedSprite2D]
@export var skinSprites : Array[Sprite2D]
@export var shirtSprites : Array[AnimatedSprite2D]
@export var trousersSprites : Array[AnimatedSprite2D]

func _ready() -> void:
	if randomizePlayer:
		playerSkinColor = randi_range(0,skinColorCount - 1)
		playerHairColor = randi_range(0,hairColorCount - 1)
		playerHairstyle = randi_range(0,hairstyleCount - 1)
		playerShirt = randi_range(0,shirtCount - 1)
		playerTrousers = randi_range(0,trousersCount - 1)
	for i in skinSprites:
		i.modulate = playerSkinColorList[playerSkinColor]
	for i in hairSprites:
		i.modulate = playerHairColorList[playerHairColor]
		i.play(str(playerHairstyle))
	for i in shirtSprites:
		i.play(str(playerShirt))
	for i in trousersSprites:
		i.play(str(playerTrousers))
