from flask import Flask
import time
import threading
import os

app = Flask(__name__)

counter = 0

def print_every_threading(interval_s, initial_time):
    message = str(time.time() - initial_time) + "from thread " + counter
    print(message)
    threading.Timer(interval=interval_s, function=print_every_threading, args=[interval_s, initial_time]).start()

@app.route("/")
def hello_world():
    counter += 1
    print_per_second = os.getenv("PRINTS_PER_SECOND")
    interval_s = 1 / int(print_per_second)
    initial_time = time.time()
    print_every_threading(interval_s, initial_time)
    frequency = 1 / interval_s
    return "Hello, World from Flask! Printing " + str(int(frequency)) + " times in a second"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
