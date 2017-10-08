from flask import Flask
from flask import request
from flask import jsonify
import requests
import os
import ast
from pattern.en import pluralize
app = Flask(__name__)

ingredient_to_expiry = {'banana': {'image_url': 'https://farm5.staticflickr.com/4279/35694008616_b8b756d234.jpg', 'expiry_days': 5}, 'cheddar': {'image_url': 'https://farm3.staticflickr.com/2371/32420492290_aa666014bb.jpg', 'expiry_days': 7}, 'peaches': {'image_url': 'https://farm6.staticflickr.com/5210/5377795177_24f15b3630.jpg', 'expiry_days': 4}, 'frozen yogurt': {'image_url': 'https://farm9.staticflickr.com/8455/8006085559_85876162e2.jpg', 'expiry_days': 21}, 'sweet potatoes': {'image_url': 'https://farm4.staticflickr.com/3004/2728191474_b72fb8ca59.jpg', 'expiry_days': 30}, 'chicken': {'image_url': 'https://farm4.staticflickr.com/3270/2928175524_a2af689480.jpg', 'expiry_days': 2}, 'milk': {'image_url': 'https://farm9.staticflickr.com/8640/15990631691_27fc3929e6.jpg', 'expiry_days': 6}, 'kale': {'image_url': 'https://farm5.staticflickr.com/4512/36828301843_50dbb6345a.jpg', 'expiry_days': 5}, 'blueberries': {'image_url': 'https://farm9.staticflickr.com/8603/15992926733_9617d767a2.jpg', 'expiry_days': 8}, 'ham': {'image_url': 'https://farm3.staticflickr.com/2224/2438420338_a216a13a76.jpg', 'expiry_days': 7}, 'avocado': {'image_url': 'https://farm5.staticflickr.com/4097/4899228690_c8581d3368.jpg', 'expiry_days': 5}, 'celery': {'image_url': 'https://farm1.staticflickr.com/631/32655316216_a048b4fe0d.jpg', 'expiry_days': 7}, 'cherries': {'image_url': 'https://farm8.staticflickr.com/7284/9006575884_113d97be90.jpg', 'expiry_days': 5}, 'peanuts': {'image_url': 'https://farm7.staticflickr.com/6226/6322438101_c0894069b4.jpg', 'expiry_days': 180}, 'rice': {'image_url': 'https://farm9.staticflickr.com/8602/16718855271_f7771eb883.jpg', 'expiry_days': 360}, 'plums': {'image_url': 'https://farm9.staticflickr.com/8039/8003711779_4dc4ed6833.jpg', 'expiry_days': 5}, 'cottage cheese': {'image_url': 'https://farm8.staticflickr.com/7415/16355949901_7cc2c43a7d.jpg', 'expiry_days': 7}, 'red bell pepper': {'image_url': 'https://farm4.staticflickr.com/3892/14823548306_8185d31a47.jpg', 'expiry_days': 7}, 'blackberries': {'image_url': 'https://farm9.staticflickr.com/8138/9008729721_1b9f5836e6.jpg', 'expiry_days': 8}, 'orange bell peppers': {'image_url': 'https://farm6.staticflickr.com/5554/14659994407_01915e1daa.jpg', 'expiry_days': 7}, 'oranges': {'image_url': 'https://farm4.staticflickr.com/3156/3636814216_807a8a5f46.jpg', 'expiry_days': 7}, 'black-eyed peas': {'image_url': 'https://farm5.staticflickr.com/4113/5014942846_78da0f3b7d.jpg', 'expiry_days': 360}, 'watermelon': {'image_url': 'https://farm7.staticflickr.com/6004/5988729666_7fac2e7211.jpg', 'expiry_days': 5}, 'romaine lettuce': {'image_url': 'https://farm5.staticflickr.com/4149/4957014943_f2ce61386d.jpg', 'expiry_days': 5}, 'bread': {'image_url': 'https://farm8.staticflickr.com/7228/7212631048_c5048ba57d.jpg', 'expiry_days': 7}, 'onion': {'image_url': 'https://farm9.staticflickr.com/8568/16030952646_4966b12a56.jpg', 'expiry_days': 7}, 'asparagus': {'image_url': 'https://farm8.staticflickr.com/7011/13894718622_6b9dcf0ab3.jpg', 'expiry_days': 3}, 'potatoes': {'image_url': 'https://farm3.staticflickr.com/2629/3985869198_4e76cd1959.jpg', 'expiry_days': 30}, 'collard greens': {'image_url': 'https://farm6.staticflickr.com/5176/5542219330_6dc3473370.jpg', 'expiry_days': 5}, 'pork': {'image_url': 'https://farm8.staticflickr.com/7172/6640085225_7ec27dd1c5.jpg', 'expiry_days': 4}, 'clams': {'image_url': 'https://farm2.staticflickr.com/1579/26094700162_0fddd76f04.jpg', 'expiry_days': 2}, 'almonds': {'image_url': 'https://farm3.staticflickr.com/2477/3654548090_16d3330a22.jpg', 'expiry_days': 180}, 'lobster': {'image_url': 'https://farm3.staticflickr.com/2151/2740737807_d3c266bd66.jpg', 'expiry_days': 2}, 'ice cream': {'image_url': 'https://farm5.staticflickr.com/4053/4617775243_3084bc771a.jpg', 'expiry_days': 21}, 'lentils': {'image_url': 'https://farm7.staticflickr.com/6142/6017262062_d0fe8f4a9e.jpg', 'expiry_days': 360}, 'mangoes': {'image_url': 'https://farm5.staticflickr.com/4004/35758915695_a4f4892b1c.jpg', 'expiry_days': 3}, 'honeydew': {'image_url': 'https://farm3.staticflickr.com/2814/10809921993_a1ca36a2f2.jpg', 'expiry_days': 5}, 'flour tortillas': {'image_url': 'https://farm3.staticflickr.com/2107/2425821971_4a1b384892.jpg', 'expiry_days': 7}, 'crawfish': {'image_url': 'https://farm1.staticflickr.com/284/32891126611_de14954dcb.jpg', 'expiry_days': 2}, 'flounder': {'image_url': 'https://farm5.staticflickr.com/4003/4654054160_f63d8cc9b9.jpg', 'expiry_days': 2}, 'eggs': {'image_url': 'https://farm8.staticflickr.com/7550/15765265510_a5892d2c0d.jpg', 'expiry_days': 21}, 'cantaloupe': {'image_url': 'https://farm5.staticflickr.com/4274/34459384443_94f7843d5c.jpg', 'expiry_days': 5}, 'cauliflower': {'image_url': 'https://farm7.staticflickr.com/6125/5992527222_c0bfe7cbc6.jpg', 'expiry_days': 7}, 'corn': {'image_url': 'https://farm4.staticflickr.com/3241/2758714217_7e7bee3253.jpg', 'expiry_days': 5}, 'walnuts': {'image_url': 'https://farm6.staticflickr.com/5082/5329093240_792942be34.jpg', 'expiry_days': 180}, 'raspberries': {'image_url': 'https://farm4.staticflickr.com/3875/14279777400_fc19569510.jpg', 'expiry_days': 8}, 'grapes': {'image_url': 'https://farm7.staticflickr.com/6132/6021069277_7057ac0065.jpg', 'expiry_days': 5}, 'sardines': {'image_url': 'https://farm3.staticflickr.com/2445/4087679390_62cb717e6c.jpg', 'expiry_days': 2}, 'pasta': {'image_url': 'https://farm5.staticflickr.com/4006/4549870013_73d6068409.jpg', 'expiry_days': 360}, 'mozzarella': {'image_url': 'https://farm5.staticflickr.com/4307/35470547404_06081d3d8f.jpg', 'expiry_days': 7}, 'beef': {'image_url': 'https://farm9.staticflickr.com/8426/7710758812_42011bbd80.jpg', 'expiry_days': 4}, 'oatmeal': {'image_url': 'https://farm7.staticflickr.com/6192/6105352966_a01e173d57.jpg', 'expiry_days': 360}, 'garbanzo beans': {'image_url': 'https://farm5.staticflickr.com/4014/4476602592_7dd60f60a7.jpg', 'expiry_days': 360}, 'american': {'image_url': 'https://farm5.staticflickr.com/4320/35689283550_39e3f95474.jpg', 'expiry_days': 7}, 'cod': {'image_url': 'https://farm3.staticflickr.com/2897/34063297272_1e3f2460e6.jpg', 'expiry_days': 2}, 'eggplant': {'image_url': 'https://farm5.staticflickr.com/4086/5006709440_4e906c42df.jpg', 'expiry_days': 7}, 'tilapia': {'image_url': 'https://farm8.staticflickr.com/7409/8717679130_82526f55e1.jpg', 'expiry_days': 2}, 'tofu': {'image_url': 'https://farm5.staticflickr.com/4017/4627861923_2f1a561ef6.jpg', 'expiry_days': 5}, 'soy beans': {'image_url': 'https://farm3.staticflickr.com/2350/2244739883_ffc1c371bb.jpg', 'expiry_days': 360}, 'mushrooms': {'image_url': 'https://farm4.staticflickr.com/3941/15067188063_87a66fec76.jpg', 'expiry_days': 5}, 'duck': {'image_url': 'https://farm9.staticflickr.com/8367/8441657930_5c225def90.jpg', 'expiry_days': 2}, 'turkey': {'image_url': 'https://farm8.staticflickr.com/7245/7267353614_4f87c53012.jpg', 'expiry_days': 2}, 'iceberg lettuce': {'image_url': 'https://farm3.staticflickr.com/2268/2242596378_79f12efac2.jpg', 'expiry_days': 7}, 'spinach': {'image_url': 'https://farm3.staticflickr.com/2908/14310585944_6a6a1bcae7.jpg', 'expiry_days': 5}, 'pears': {'image_url': 'https://farm3.staticflickr.com/2524/3895770896_c4734e66da.jpg', 'expiry_days': 5}, 'grapefruit': {'image_url': 'https://farm9.staticflickr.com/8625/16604662781_d36c33ba70.jpg', 'expiry_days': 7}, 'crab': {'image_url': 'https://farm6.staticflickr.com/5468/7081994063_f12e1a13ac.jpg', 'expiry_days': 2}, 'kiwi': {'image_url': 'https://farm2.staticflickr.com/1696/25710116771_8b4f1b201f.jpg', 'expiry_days': 5}, 'butternut squash': {'image_url': 'https://farm3.staticflickr.com/2437/4035002974_da4cd2e533.jpg', 'expiry_days': 5}, 'squid': {'image_url': 'https://farm4.staticflickr.com/3522/3236878388_52897a68e4.jpg', 'expiry_days': 2}, 'green peas': {'image_url': 'https://farm6.staticflickr.com/5490/14437743806_815f5a76e0.jpg', 'expiry_days': 5}, 'black beans': {'image_url': 'https://farm5.staticflickr.com/4222/34802706535_586988abaf.jpg', 'expiry_days': 360}, 'cereal': {'image_url': 'https://farm8.staticflickr.com/7364/27715442645_cc2802ded6.jpg', 'expiry_days': 90}, 'dark-green leaf lettuce': {'image_url': 'https://farm9.staticflickr.com/8092/8466412134_b9a7c112da.jpg', 'expiry_days': 5}, 'split peas': {'image_url': 'https://farm5.staticflickr.com/4110/4970270974_5b5268b4a9.jpg', 'expiry_days': 360}, 'sugar snap peas': {'image_url': 'https://farm1.staticflickr.com/417/19236457874_e2e33caef5.jpg', 'expiry_days': 5}, 'anchovies': {'image_url': 'https://farm6.staticflickr.com/5205/5348201668_68116ed553.jpg', 'expiry_days': 2}, 'apples': {'image_url': 'https://farm3.staticflickr.com/2950/15165630350_d6c66a346c.jpg', 'expiry_days': 21}, 'pitas': {'image_url': 'https://farm6.staticflickr.com/5071/13482254873_aecbe6708a.jpg', 'expiry_days': 7}, 'yellow bell pepper': {'image_url': 'https://farm4.staticflickr.com/3878/14659992817_e95bf01abe.jpg', 'expiry_days': 5}, 'carrots': {'image_url': 'https://farm7.staticflickr.com/6046/6390995447_1cced1f57d.jpg', 'expiry_days': 14}, 'green beans': {'image_url': 'https://farm9.staticflickr.com/8245/8473068751_5f4dc39d0c.jpg', 'expiry_days': 7}, 'sunflower seeds': {'image_url': 'https://farm8.staticflickr.com/7155/6407841903_ca11654c6a.jpg', 'expiry_days': 180}, 'shrimp': {'image_url': 'https://farm5.staticflickr.com/4269/35172789496_a387d77f5f.jpg', 'expiry_days': 2}, 'lamb': {'image_url': 'https://farm6.staticflickr.com/5252/5395681980_760abfa2da.jpg', 'expiry_days': 4}, 'apricots': {'image_url': 'https://farm5.staticflickr.com/4417/37185219925_d6dc502aa4.jpg', 'expiry_days': 5}, 'catfish': {'image_url': 'https://farm4.staticflickr.com/3033/2585284828_7799f5d5f4.jpg', 'expiry_days': 2}, 'tomatoes': {'image_url': 'https://farm9.staticflickr.com/8670/16079376619_ba63b87c63.jpg', 'expiry_days': 7}, 'zucchini': {'image_url': 'https://farm3.staticflickr.com/2505/3770188142_cf6176617a.jpg', 'expiry_days': 5}, 'pumpkin seeds': {'image_url': 'https://farm8.staticflickr.com/7230/26970203715_5160169c29.jpg', 'expiry_days': 180}, 'papaya': {'image_url': 'https://farm9.staticflickr.com/8786/16960986944_0583ff51bb.jpg', 'expiry_days': 5}, 'bokchoy': {'image_url': 'https://farm8.staticflickr.com/7056/6916064063_289be900cc.jpg', 'expiry_days': 5}, 'salmon': {'image_url': 'https://farm5.staticflickr.com/4406/36281602893_832e943b9f.jpg', 'expiry_days': 2}, 'yogurts': {'image_url': 'https://farm8.staticflickr.com/7225/7350739652_3e345cc425.jpg', 'expiry_days': 14}, 'cucumber': {'image_url': 'https://farm5.staticflickr.com/4094/4759742596_1ce49de72a.jpg', 'expiry_days': 7}, 'tuna': {'image_url': 'https://farm1.staticflickr.com/38/84158758_43dc71c738.jpg', 'expiry_days': 2}, 'broccoli': {'image_url': 'https://farm2.staticflickr.com/1290/607673097_870e3b455c.jpg', 'expiry_days': 5}, 'puddings': {'image_url': 'https://farm5.staticflickr.com/4015/35545313142_12db77d2c8.jpg', 'expiry_days': 14}, 'beets': {'image_url': 'https://farm8.staticflickr.com/7355/9231313120_11fa66d29d.jpg', 'expiry_days': 7}, 'hot dog': {'image_url': 'https://farm5.staticflickr.com/4370/37215361592_88c641c0a9.jpg', 'expiry_days': 7}, 'red beans': {'image_url': 'https://farm6.staticflickr.com/5023/5554118836_7bc2c1ca6b.jpg', 'expiry_days': 360}, 'white beans': {'image_url': 'https://farm7.staticflickr.com/6141/5933815882_2950326fcb.jpg', 'expiry_days': 360}, 'strawberries': {'image_url': 'https://farm6.staticflickr.com/5138/5392657738_a192633f61.jpg', 'expiry_days': 8}, 'veal': {'image_url': 'https://farm5.staticflickr.com/4022/4513311347_0435162f96.jpg', 'expiry_days': 4}, 'pineapple': {'image_url': 'https://farm4.staticflickr.com/3727/13385102264_b1ebcf0e0f.jpg', 'expiry_days': 5}, 'radicchio': {'image_url': 'https://farm4.staticflickr.com/3168/2931284513_0f2af6fdc8.jpg', 'expiry_days': 5}, 'oysters': {'image_url': 'https://farm4.staticflickr.com/3718/11883977796_0b2c9968e5.jpg', 'expiry_days': 2}}
users = { "username:password": 0, "vidurm09:this_is_a_password":1}
user_items = {0:[{'image_url': 'https://farm3.staticflickr.com/2629/3985869198_4e76cd1959.jpg', 'expiry_days': 30, 'ingredient_name': 'potatoes'}, {'image_url': 'https://farm2.staticflickr.com/1290/607673097_870e3b455c.jpg', 'expiry_days': 5, 'ingredient_name': 'broccoli'}, {'image_url': 'https://farm7.staticflickr.com/6132/6021069277_7057ac0065.jpg', 'expiry_days': 5, 'ingredient_name': 'grapes'}, {'image_url': 'https://farm9.staticflickr.com/8670/16079376619_ba63b87c63.jpg', 'expiry_days': 7, 'ingredient_name': 'tomatoes'}], 
            1:[{'ingredient_name':'banana','image_url': 'https://farm5.staticflickr.com/4279/35694008616_b8b756d234.jpg', 'expiry_days': 5}]}
user_recipes = {0:[]}
google_search_API_key = "AIzaSyAJXDfdfOv4wnC2nVjslb0V2xrY9WL_k7Y"

def get_recipes(list_o_ingredients):
    payload = {
        'key': 'f9605adf0ef0907228005f9707cc029b',
        'q': ','.join(list_o_ingredients)
    }
    url_base = 'http://food2fork.com/api/search'
    r = requests.get(url_base, params=payload)
    dict = ast.literal_eval(r.text)
    return dict
    
def sort_user_items(uid):
    user_items[uid] = sorted(user_items[uid], key=lambda x: -x['expiry_days'])
    return user_items[uid]

def earliest_expiration_date(list_o_ingredient_names):
    return min([ingredient_to_expiry[ingredient]['expiry_days'] for ingredient in list_o_ingredient_names])


def get_recipes_for_user(uid):
    sort_user_items(uid)
    ingredients = [i['ingredient_name'] for i in user_items[uid]]
    list_o_recipes = []
    count_recipes = 0
    while count_recipes < 10 and ingredients:
        recipes = get_recipes(ingredients)
        recipes_w_images = [recipe for recipe in recipes['recipes'] if 'image_url' in recipe]
        count_recipes += len(recipes_w_images)
        for recipe in recipes_w_images:
            list_o_recipes.append({'recipe_name': recipe['title'], 'ingredients':ingredients, 'image_url': recipe['image_url'], 'recipe_url':recipe['source_url'], 'recipe_expiration':earliest_expiration_date(ingredients)})
        ingredients = ingredients[:-1]
    return list_o_recipes
sample_label_detection = [
        {
          "mid": "/m/02xwb",
          "description": "fruit",
          "score": 0.9466134
        },
        {
          "mid": "/m/0dqb5",
          "description": "citrus",
          "score": 0.9330487
        },
        {
          "mid": "/m/0p719",
          "description": "fruit tree",
          "score": 0.9031516
        },
        {
          "mid": "/m/0bv0f7",
          "description": "valencia orange",
          "score": 0.8475149
        },
        {
          "mid": "/m/0cyhj_",
          "description": "orange",
          "score": 0.83729565
        },
        {
          "mid": "/m/036qh8",
          "description": "produce",
          "score": 0.8323994
        },
        {
          "mid": "/m/05s2s",
          "description": "plant",
          "score": 0.8028104
        },
        {
          "mid": "/m/020csw",
          "description": "bitter orange",
          "score": 0.7985035
        },
        {
          "mid": "/m/02wbm",
          "description": "food",
          "score": 0.7685518
        },
        {
          "mid": "/m/0c17fh",
          "description": "rangpur",
          "score": 0.7050772
        }
      ]

def spell_check(text):
    payload = {
        'text': text,
        'mode': 'proof'
    }
    headers = {
        'Ocp-Apim-Subscription-Key': 'b07aabfd70a74be99824615e2f3796e2',
    }
    url_base = 'https://api.cognitive.microsoft.com/bing/v5.0/spellcheck/'
    r = requests.get(url_base, headers=headers, params=payload)
    dict = ast.literal_eval(r.text)
    print(dict)
    if dict["flaggedTokens"] == []:
        return text
    else:
        corrected_word = dict["flaggedTokens"][0]["suggestions"][0]["suggestion"]
        return corrected_word

def add_ingredient(user, ingredient_name):
    #assert user in user_items.keys(), "User is not in the system"
    if not is_in_ingredients_list(user, ingredient_name):
        user_items[user].append({ingredient_name: ingredient_to_expiry[ingredient_name]})
    
def get_ingredients_names(user):
    # Returns array of ingredient names, which are strings
    #assert user in user_items.keys(), "User is not in the system"
    lst_ingredients = []
    for item in user_items[user]:
        lst_ingredients.append(item.keys()[0])
    return lst_ingredients
    
def edit_ingredient(user, old_ingredient_name, new_ingredient_name):
    #assert user in user_items.keys(), "User is not in the system"
    remove_ingredient(user, old_ingredient_name)
    add_ingredient(user, new_ingredient_name)

def is_in_ingredients_list(user, ingredient_name):
    # Checks if an ingredient is in the ingredients dictionary
    #assert user in user_items.keys(), "User is not in the system"
    values = user_items[user]
    for item in values:
        if ingredient_name in item.keys():
            return True
    return False

@app.route('/ingredients/list/<user>')
def get_user_dictionary(user):
    return jsonify({'ingredients':(user_items[int(user)])})
    return "Not Yet"
    
def print_user_dictionary(user):
    # Prints value of the "user" key in the dictionary
    print(user_items[user])

def create_user(user):
    user_items[user] = []

def remove_user(user):
    del user_items[user]
    
def process(user, s):
    words = [spell_check(w.lower()) for w in s.split()]
    # for word in words:
    #     if word in ingredient_to_expiry:
    #         add
            
    # ingredients = [spell_check(x.lower()) for x in s.split()]
    # print(ingredients)
    # for i in ingredients:
    #     if is_in_ingredients_list(user, i):
    #         add_ingredient(user, i)
    # print_user_dictionary(user)
    # return user_items[user]
    
sample = '''WED
$4.66
O6/01/2016
####################################
ZUCHINNI GREEN
0.778kg NET a $5.99/kg
BANANA CAVENDISH $1.32
0.442kg NET a $2.99/kg
SPECIAL $0.99
SPECIAL $1.50
POTATOES BRUSHED $3.97
1.328kg NET a $2.99/kg
BROCCOLI $4.84
0.808kg NET e $5.99/kg
BRUSSELSPROUTS $5.15
0.322kg NET e $15.99/kg
SPECIAL $0.99
GRAPES GREEN $7.03
1.174kg NET 0 $5.99/kg
PEAS SNON $3.27
0.218ka NET $14.99/kg
TOMATOES GRAPE $2.99
LETTUCE ICEBERG $2.49
SUBTOTAL $39.20
LOYALTY - 15.00
SUBTOTAL $24.20
SUBTOTAL $24.20
SUBTOTAL
TOTAL
CASH
CHANGE
$24.20
$24.20
$50.00
$25.80'''
#***************************************************************************

def check_user(username, password):
    user_id = False
    user_pass_combo = "{}:{}".format(username,password)
    if user_pass_combo in users:
        user_id = users[user_pass_combo]
    return user_id

def items(uid):
    return user_items[uid]
    
@app.route('/')
def hello_world():
    return 'hello world!'

@app.route("/hello")
def hello():
    return "Hello World!"
   
# verifies login info and returns (uid or False (if no matching pair)) or Request Malformed (if missing params)
@app.route("/user/login")
def login():
    if request.args.get('username') and request.args.get('password'):
        return str(check_user(request.args.get('username'), request.args.get('password')))
    else:
        return "Request Malformed"

# @app.route('/items/add/<uid>')
# def add_ingredients(uid):
#     print(uid)
#     return uid

def ingredient_in_user_list(uid, ingredient_name):
    for item in user_items[uid]:
        if ingredient_name == item['ingredient_name']:
            return True
    return False

def add_ingredient_to_user_list(uid, ingredient_name):
    user_items[uid].append({'ingredient_name':ingredient_name, 'expiry_days': ingredient_to_expiry[ingredient_name]['expiry_days'], 'image_url':ingredient_to_expiry[ingredient_name]['image_url']})

def label_detection(uid, response):
    uid = int(uid)
    labels = [label['description'] for label in response]
    labels_sanitized = []
    for label in labels:
        labels_sanitized.extend(label.split(' '))
    print(labels_sanitized)
    for word in labels_sanitized:
        word = pluralize(word)
        if word in ingredient_to_expiry:
            add_ingredient_to_user_list(uid, ingredient_name)
            return word

@app.route('/receipt/add/<uid>',methods=['GET', 'POST'])
def add_receipt(uid):
    #cognitive services (azure): b07aabfd70a74be99824615e2f3796e2
    if request.data:
        uid = int(uid)
        receipt_text = request.data.replace('\n', ' ')
        words = [w.lower() for w in receipt_text.split()]
        # words = [spell_check(w.lower()) for w in receipt_text.split()]
        for word in words:
            if word in ingredient_to_expiry:
                add_ingredient_to_user_list(uid, word)
        sort_user_items(uid)
        return jsonify({'recipes':get_recipes_for_user(int(uid)), 'ingredients':user_items[int(uid)]})
    return "Malformed Request"
        
        
@app.route('/recipes/list/<uid>')
def get_recipes_handler(uid):
    return jsonify({'recipes':get_recipes_for_user(int(uid))})
    
@app.route('/all/list/<uid>')
def get_all_handler(uid):
    return jsonify({'recipes':get_recipes_for_user(int(uid)), 'ingredients':user_items[int(uid)]})

@app.route('/item/recognize/<uid>')
def img_recognize(uid):
    if request.data:
        dict = ast.literal_eval(request.data)
        print(dict)
        return 'ok'
        # return jsonify({'recipes':get_recipes_for_user(int(uid)), 'ingredients':user_items[int(uid)]})
    return "Malformed Request"

app.run(host=os.getenv('IP', '0.0.0.0'),port=int(os.getenv('PORT', 8080)))