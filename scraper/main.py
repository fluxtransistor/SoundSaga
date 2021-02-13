import billboard as bb
import json
import os
from datetime import date, timedelta
from time import perf_counter

W = '\033[0m'  # white (normal)
R = '\033[31m'  # red
G = '\033[32m'  # green
O = '\033[33m'  # orange
B = '\033[34m'  # blue
P = '\033[35m'  # purple

fileStart = ""
fileEnd = ".json"
chartDate = date(1958, 8, 4)
numTracks = 100
print("Starting.")
database = {}

while True:
    start = perf_counter()
    filename = fileStart + str(chartDate.year) + "-" + ("0" if len(str(chartDate.month)) == 1 else "") + str(
        chartDate.month) + fileEnd
    if os.path.isfile(filename):
        chartDate += timedelta(weeks=1)
        continue
    chart = bb.ChartData("hot-100", str(chartDate), timeout=6, max_retries=1)
    chartDict = {
        "billboard-url": "https://www.billboard.com/charts/hot-100/" + str(chartDate),
        "tracks": []
    }
    print(W + str(chartDate))
    for track_num in range(numTracks):
        track = chart.entries[track_num]
        trackData = {
            "rank": track.rank,
            "peak": track.peakPos,
            "last": track.lastPos,
            "weeks": track.weeks,
            "title": track.title,
            "artist": track.artist,
            "image": track.image,
        }
        if track.rank < 12:
            print("#" + R + str(track.rank), G + track.artist, "-", B + track.title)
        else:
            print("\r#" + R + str(track.rank), G + track.artist, "-", B + track.title, end="")
        chartDict["tracks"].append(trackData)
        if track.rank == 100:
            break
    database[str(chartDate)] = chartDict
    if (chartDate + timedelta(weeks=1)).month != chartDate.month:
        with open(filename, 'w') as outfile:
            json.dump(database, outfile)
            outfile.close()
            database = {}
        print(O + "\n Written!", R + str(perf_counter() - start) + " seconds")
    else:
        print(R + "\n Temporary,", R + str(perf_counter() - start) + " seconds")
    chartDate += timedelta(weeks=1)
