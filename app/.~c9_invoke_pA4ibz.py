from flask import Flask
from flask import request
import requests
import os
app = Flask(__name__)

ingredient_to_expiry = {'bananas': 8, 'cheddar': 7, 'peaches': 4, 'frozen yogurt': 21, 'sweet potatoes': 30, 'chicken': 2, 'milk': 6, 'kale': 5, 'blueberries': 8, 'ham': 7, 'avocado': 5, 'celery': 7, 'cherries': 5, 'peanuts': 180, 'rice': 360, 'plums': 5, 'cottage cheese': 7, 'red bell pepper': 7, 'blackberries': 8, 'orange bell peppers': 7, 'oranges': 7, 'black-eyed peas': 360, 'watermelon': 5, 'romaine lettuce': 5, 'bread': 7, 'onion': 7, 'asparagus': 3, 'potatoes': 30, 'collard greens': 5, 'pork': 4, 'clams': 2, 'almonds': 180, 'lobster': 2, 'ice cream': 21, 'lentils': 360, 'mangoes': 3, 'honeydew': 5, 'flour tortillas': 7, 'crawfish': 2, 'flounder': 2, 'eggs': 21, 'cantaloupe': 5, 'cauliflower': 7, 'corn': 5, 'walnuts': 180, 'raspberries': 8, 'grapes': 5, 'sardines': 2, 'pasta': 360, 'mozzarella': 7, 'beef': 4, 'oatmeal': 360, 'garbanzo beans': 360, 'american': 7, 'cod': 2, 'eggplant': 7, 'tilapia': 2, 'tofu': 5, 'soy beans': 360, 'mushrooms': 5, 'duck': 2, 'turkey': 2, 'iceberg lettuce': 7, 'spinach': 5, 'pears': 5, 'grapefruit': 7, 'crab': 2, 'kiwi': 5, 'butternut squash': 5, 'squid': 2, 'green peas': 5, 'black beans': 360, 'cereal': 90, 'dark-green leaf lettuce': 5, 'split peas': 360, 'sugar snap peas': 5, 'anchovies': 2, 'apples': 21, 'pitas': 7, 'yellow bell pepper': 5, 'carrots': 14, 'green beans': 7, 'sunflower seeds': 180, 'shrimp': 2, 'lamb': 4, 'apricots': 5, 'catfish': 2, 'tomatoes': 7, 'zucchini': 5, 'pumpkin seeds': 180, 'papaya': 5, 'bokchoy': 5, 'salmon': 2, 'yogurts': 14, 'cucumber': 7, 'tuna': 2, 'broccoli': 5, 'puddings': 14, 'beets': 7, 'hot dog': 7, 'red beans': 360, 'white beans': 360, 'strawberries': 8, 'veal': 4, 'pineapple': 5, 'radicchio': 5, 'oysters': 2}

users = { "username:password": 0, "vidurm09:this_is_a_password":1}
user_items = {0:[], 1:[]}
google_search_API_key = "AIzaSyAJXDfdfOv4wnC2nVjslb0V2xrY9WL_k7Y"

ingredients = {}

def spell_check(text):
    payload = {
        'text': request.args.get('receipt_text')
    }
    headers = {
        'Ocp-Apim-Subscription-Key': 'b07aabfd70a74be99824615e2f3796e2',
    }
    url_base = 'https://api.cognitive.microsoft.com/bing/v5.0/spellcheck/'
    r = requests.get(url_base, headers=headers)
    return r.text

def add_ingredient(user, ingredient_name):
    assert user in ingredients.keys(), "User is not in the system"
    ingredients[user].append({ingredient_name: """URL"""})

def remove_ingredient(user, ingredient_name):
    assert user in ingredients.keys(), "User is not in the system"
    ingredients[user].remove({ingredient_name: """URL"""})
    
def get_ingredients_names(user):
    # Returns array of ingredient names, which are strings
    assert user in ingredients.keys(), "User is not in the system"
    lst_ingredients = []
    for item in ingredients[user]:
        lst_ingredients.append(item.keys()[0])
    return lst_ingredients
    
def edit_ingredient(user, old_ingredient_name, new_ingredient_name):
    assert user in ingredients.keys(), "User is not in the system"
    remove_ingredient(user, old_ingredient_name)
    add_ingredient(user, new_ingredient_name)

def is_in_ingredients_list(user, ingredient_name):
create_user("Abhinav")
    assert user in ingredients.keys(), "User is not in the system"
    values = ingredients[user]
    for item in values:
        if ingredient_name in item.keys():
            return True
    return False

def print_user_dictionary(user):
    # Prints value of the "user" key in the dictionary
    print(ingredients[user])

def create_user(user):
    ingredients[user] = []

def remove_user(user):
    del ingredients[user]

#***************************************************************************

def check_user(username, password):
    user_id = False
    user_pass_combo = "{}:{}".format(username,password)
    if user_pass_combo in users:
        user_id = users[user_pass_combo]
    return user_id

def items(uid):
    return user_items[uid]

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
    
@app.route('/receipt/add/<uid>')
def add_receipt(uid):
    #cognitive services (azure): b07aabfd70a74be99824615e2f3796e2
    return 
    if request.args.get('receipt_text'):
        

app.run(host=os.getenv('IP', '0.0.0.0'),port=int(os.getenv('PORT', 8080)))