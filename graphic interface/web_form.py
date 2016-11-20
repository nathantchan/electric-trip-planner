from bokeh.layouts import widgetbox
from bokeh.models.widgets import TextInput, Button, Paragraph
from bokeh.plotting import curdoc

import pandas as pd
import requests as rq

depart_in = TextInput(value="San Francisco, CA", title="Start")
arrival_in = TextInput(value="Lake Tahoe, CA", title="End")
range_in = TextInput(value="300", title="Range in KM")
button = Button(label="Map Route")

output_txt = Paragraph(text="")

stations = pd.read_csv('/Users/nathan/Downloads/alt_fuel_stations (Nov 18 2016).csv')
maps_url = "https://maps.googleapis.com/maps/api/directions/json"

def callback():
    f = open('range.csv', 'w')
    # write out range file
    f.write('Range (m)\n' + str(int(range_in.value) * 100))
    f.close()

    params = {
        "origin": depart_in.value,
        "destination": arrival_in.value,
        "key": "AIzaSyCj6u6Vo0x4hIBrQBxDdUIZeb1AKSGV95c"
    }
    b = rq.get(maps_url, params=params)
    j = b.json()
    r = j['routes']
    start = r[0]['legs'][0]['start_location']
    end = r[0]['legs'][0]['end_location']
    start_f = open('start.csv', 'w')
    start_f.write(str(start['lat']) + "\n" + str(start['lng']))
    start_f.close()
    end_f = open('end.csv', 'w')
    end_f.write(str(end['lat']) + "\n" + str(end['lng']))
    end_f.close()
    # load in file of IDs and destination
    res = open('results.csv', 'r')
    l = res.read()
    arr = l.split(',')
    maps_strings = [] 
    for i in range(len(arr)):
        v = int(arr[i])
        if v == -2:
            maps_strings.append(depart_in.value)
        elif v == -1:
            maps_strings.append(arrival_in.value)
        else:
            station = stations[stations['ID'] == v]
            maps_strings.append(station['Street Address'][0] + "+" + station['City'][0] + "+" + station['State'][0])

    output_txt.text=maps_strings

wb = widgetbox(depart_in,
    arrival_in,
    range_in,
    button,
    output_txt)

button.on_click(callback)

curdoc().add_root(wb)
