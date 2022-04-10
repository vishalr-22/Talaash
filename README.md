# Talaash - In Search of the Missing...
### __A facial recognition system for tracking missing children.__

### Project has two Apps linked to each other:
1. Talaash Mobile App(Flutter) : For Users to Report sighting of missing children.
2. Talaash Web App(Flask) : For Admin of Talaash from Concerned Authority who can see alerts when sightings are reported by people in Talaash Mobile App.
## Google Maps used in our App for Sighting Location of missing child:


https://user-images.githubusercontent.com/59617133/162607933-dd01d46b-0bc1-4201-9702-856293661a45.mp4


## 1. Problem Statement:

### -> Status of Missing Children Globally and in India: An Overview

* An estimated __8 million__ children are reported missing each year around the world.
* __174__ children go missing in India everyday.
* Only __half the children__ who go missing every year are able to be traced.
* Kidnapping and Abduction
(K&A) of children is the
largest crime committed
against children and
accounts for __51%__ of all crimes
against children (NCRB 2016)

## 2. Objective of the Project:
The objective of this project is to help Central authorities & Police track down missing children quickly with the help of citizens by making use of Modern Day ML and AI Technologies.

## 3. Standard Solution being used:
* Tracking a missing child using Manual investigation requires both time and experience (to ask right questions). 
* Most of the time, investigation method is time consuming as well as costly and can be unsuccessful if the person (missing) has been shifted/moved to different location (city/country).
* In such cases, the ideal approach is to go through CCTV footages and evidences. Again, this can be very time consuming and given the number of children that go missing everyday, it can be a challanage to keep up with it.

## 4. Our Proposed Solution:
* By Using Machine learning & AI, build a Missing Children Tracking system on the go to assist Central authorities(Gov, NGOs etc).
* Here we will have a database of Missing people, and whenever someone try to ping any photo against it, an algorithm hits off thats start matching those photographs with available database using our Face Recognition Mode .
* It will be an open-source product and free-to-use application that communities can use to help finding people and children in their neighbourhood.



## 5. Tech Stack:
* [Flutter](https://flutter.dev/) : For Android App on the User Side
* [Flask](https://flask.palletsprojects.com/en/2.1.x/) : For Web App on the admin side
* [DeepFace](https://pypi.org/project/deepface/) : For Making our Face Recognition Model
* [Firebase](https://firebase.google.com/?gclsrc=aw.ds)  : For Database
* [Google Maps API](https://developers.google.com/maps) : For Picking Location

## Source of facts : 
1. https://www.cry.org/wp-content/uploads/2018/08/International-Missing-Children_s-Day-2018.pdf.
2. https://www.icmec.org/press/activities-in-more-than-22-countries-around-the-globe-will-remember-missing-children-on-may-25/.


## Developed by Team Cryptasylum
- Shrikant Sahu
- Rishabh Kothari
- R. Vishal
- Piyush Sharma
