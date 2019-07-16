# ACTIVITY - SWIFT

<img src="https://images.unsplash.com/photo-1498484502070-2165cb42d504?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80">

# ABOUT

Activity is an IOS App that show how to train and deploy a Human Activity Model in your mobile thanks to CoreML and TuriCreate

Activity recognition is a really exciting field because it can associate a service based on what the user is doing.

Eventually, I'll associate activity with music.

## Training

I want to classify severals kind of activities : 

Simple activities :

- walking
- running
- sitting
- jumping

Complex activities :

- metro
- car
- skating
- biking

I recorded my movements - accelerometers and gyroscopes - during each activity with my Iphone7 sensors.

My python project is [here](https://github.com/hyazel/Activity-Python), I used Turi Create for the training part.

[Machine Learning Architecture](https://apple.github.io/turicreate/docs/userguide/activity_classifier/how-it-works.html)


## Deployment

The app is in Swift 5 with two targets :
- Activity : the app
- CoreActivity : the motion data handling and predictions with CoreML.

# Ressources

- [CoreML](https://developer.apple.com/documentation/coreml)
- [DeviceMotion](https://developer.apple.com/documentation/coremotion/cmmotionmanager/1616040-devicemotion)
- [TuriCreate](https://apple.github.io/turicreate/docs/userguide/activity_classifier/)
- [Building Activity Classification Models in Create ML](https://developer.apple.com/videos/play/wwdc2019/426)
- [Activity Recognition with Smartphone Sensors](https://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=6838194)