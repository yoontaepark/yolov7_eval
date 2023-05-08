# checking performace on pascal voc dataset 
# pip install roboflow

from roboflow import Roboflow
rf = Roboflow(api_key="Q6USYNThYLbbBKQs5JOs")
project = rf.workspace("jacob-solawetz").project("pascal-voc-2012")
dataset = project.version(1).download("yolov7")

