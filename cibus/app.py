from flask import Flask
from flask import request
import os
app = Flask(__name__)

users = { "username:password": 0, "vidurm09:this_is_a_password":1}

def check_user(username, password):
    user_id = False
    user_pass_combo = "{}:{}".format(username,password)
    if user_pass_combo in users.keys():
        user_id = users[user_pass_combo]
    return user_id

@app.route("/hello")
def hello():
    return "Hello World!"

@app.route("/user/login")
def login():
    username, password = request.args.get('username') , request.args.get('password')
    if username and password:
        return str(check_user(request.args.get('username'), request.args.get('password')))
    else:
        return "Request Malformed"


# app.run(host=os.getenv('IP', '0.0.0.0'),port=int(os.getenv('PORT', 8080)))
