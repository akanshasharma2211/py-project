from flask import Flask
import pandas as pd
import redis
import pymongo

app = Flask(__name__)


@app.route('/')
def home():
    return {'msg': 'working'}


if _name_ == '__main__':
    app.run(host='0.0.0.0', port=3089)
