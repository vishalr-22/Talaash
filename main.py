from distutils.log import debug
from email import message
from email.mime import base
from fileinput import filename
from msilib.schema import Error
import pyrebase
from flask import Flask, render_template, request, url_for, redirect, flash, jsonify, make_response, url_for
# from dbservices import dbservices
from datetime import datetime
from datetime import timedelta

import matplotlib as plt
import base64
from PIL import Image
import io
import os
import shutil
import codecs

import base64
import requests
import json
import cv2

from dbservices import get_alerts

from model import face_comparison

app = Flask(__name__)
app.secret_key = "super_secret_key"


config = {
    "apiKey": "AIzaSyC1IrB995nClG5Aj8TD7FcGsg9adLSSZxg",
    "authDomain": "kjsce-hack-6.firebaseapp.com",
    "databaseURL": "https://kjsce-hack-6-default-rtdb.firebaseio.com",
    "projectId": "kjsce-hack-6",
    "storageBucket": "kjsce-hack-6.appspot.com",
    "messagingSenderId": "732851077638",
    "appId": "1:732851077638:web:2b58fb2f26de96c6f97987",
    "measurementId": "G-3ZX7MZNR6T"
}

firebase = pyrebase.initialize_app(config)

db = firebase.database()
missing_child = db.child("Missing_Details").child().get()
mc = missing_child.val()
k1 = mc.values()

child_alert = db.child("Alert_Details").child().get()
ca = child_alert.val()
k2 = ca.values()


d1 = {}


def get_missing_details(firebase):
    db = firebase.database()
    missing_child = db.child("Missing_Details").child().get()
    mc = missing_child.val()
    k1 = mc.values()
    return k1


def get_alert_details(firebase):
    db = firebase.database()
    child_alert = db.child("Alert_Details").child().get()
    ca = child_alert.val()
    k2 = ca.values()
    return k2


def create_db(k1):
    cur_dir = os.getcwd()
    inner_dir = 'static/child_images/'
    dir_path = os.path.join(cur_dir, inner_dir)
    if os.path.exists(dir_path) and os.path.isdir(dir_path):
        shutil.rmtree(dir_path)
    os.mkdir(dir_path)
    global d1
    d1 = {}
    for i, imageData in enumerate(k1):
        image = imageData["Image"]
        image_id = imageData["Id"]
        image = base64.b64decode(image)
        filename = dir_path + "child_" + str(i) + ".jpg"
        d1[inner_dir+"child_"+str(i)+".jpg"] = image_id
        with open(filename, 'wb') as f:
            f.write(image)


create_db(k1)


def db_path():
    return "static/child_images"


@app.route('/')
def homepage():
    return render_template('home.html', val=k1)


@app.route('/home', methods=['POST', 'GET'])
def home():
    return render_template('home.html', val=k1)
    # return render_template('home.html')


@app.route('/missing_desc/<id>/', methods=['POST', 'GET'])
def missing_desc(id):
    # if request.method == 'GET':
    for i in k1:
        if i["Id"] == id:
            temp = i

    return render_template('description.html', details=temp)
    # return render_template('decription.html')


@app.route('/alerts', methods=['POST', 'GET'])
def alerts():
    return render_template('alerts.html', val=k2)


@app.route('/alert_desc/<id>/', methods=['POST', 'GET'])
def alert_desc(id):
    for i in k1:
        if i["Id"] == id:
            temp1 = i
    lst = []
    for i in k2:
        if i["Id"] == id:
            temp2 = i
    return render_template('alert_description.html', details=temp1, val2=temp2)


@app.route('/report_sighting', methods=['POST'])
def report_desc():
    if request.method == 'POST':
        request_data = request.get_json()
        aloneStatus = None
        address = None
        contact = None
        image = None

        if "address" in request_data:
            address = request_data["address"]
        else:
            return jsonify(
                status="error",
                message="address must be provided",
            )
        if "aloneStatus" in request_data:
            aloneStatus = request_data["aloneStatus"]
        else:
            return jsonify(
                status="error",
                message="alone status must be provided",
            )
        if "contact" in request_data:
            contact = request_data["contact"]

        if "image" in request_data:
            # try:
            image = request_data["image"]
            image = base64.b64decode(image)

            filename = 'static/input.jpg'  # I assume you have a way of picking unique filenames

            with open(filename, 'wb') as f:
                f.write(image)

            d1 = {'static/child_images/child_0.jpg': '1001', 'static/child_images/child_1.jpg': '1002',
                  'static/child_images/child_2.jpg': '1003'}

            print(filename)
            result = face_comparison(filename, 'static/child_images', d1)

            if result is None:
                return jsonify(status="error", message="No face detected")

            with open(result[0], "rb") as img_file:
                image_64_encode = base64.b64encode(img_file.read())
            image_64_encode = str(image_64_encode)
            image_64_encode = image_64_encode[2:-1]

            # print(image_64_encode)

            data = {'image': image_64_encode, "match_percent": result[1]}

            child_alert = db.child("Alert_Details")

            missing_child = None
            for i in k1:
                if i["Id"] == result[2]:
                    missing_child = i
                    break

            print(missing_child)

            alert_data = {
                "Alone": aloneStatus,
                "Contact": contact if contact is not None else "",
                "Location": address,
                'Image': str(image_64_encode),
                "Id": missing_child["Id"],
            }

            child_alert.push(alert_data)

            global k2
            k2 = get_alert_details(firebase)

            return jsonify(
                status="success",
                message="Face detected",
                image=str(image_64_encode),
                match_percent=result[1],
                missing_child=missing_child
            )
            # except Exception as e:
            #     print("Hello")
            #     print(e)
            #     return jsonify(
            #         status="error",
            #         message="Image is not in proper format",
            #     )
