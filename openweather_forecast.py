#!/usr/bin/env python3
import pyowm
import argparse
import subprocess
import requests
import datetime

#https://api.openweathermap.org/data/2.5/forecast?q=Nimes,fr&appid=81baa8fffa0ec25a9a2d825c57d4adfe

def process (args):

    r = requests.get('https://api.openweathermap.org/data/2.5/forecast?q=Nimes,fr&appid=81baa8fffa0ec25a9a2d825c57d4adfe')
    
    day_to_search = datetime.date.today() + datetime.timedelta(days=int(args.nextday[0]))
    for forecast in r.json()['list']:
        if forecast['dt_txt'] == day_to_search.strftime('%Y-%m-%d')+" 12:00:00":
            print('PNG/small/'+ forecast['weather'][0]['icon'] +'.png')
            break

    #if args.get_weather_icon:
    #    print('PNG/'+ 'icon name' +'.png')


parser = argparse.ArgumentParser(description='Openweather script.')
parser.add_argument('--api_key',help='OWM API key.',nargs=1,metavar=('[api_key]'), required=True)
parser.add_argument('--city',help='Cityname.',nargs=1,metavar=('[city]'), required=True)
parser.add_argument('--ccode',help='Country code.',nargs=1,metavar=('[code]'), required=True)
parser.add_argument('--nextday',help='next 1 or 2 day forecast.',nargs=1,metavar=('[nextday]'), required=True)
parser.add_argument('--get_weather_icon',help='Get weekday.',action='store_true')
args = parser.parse_args()

process(args)
