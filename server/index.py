from flask import Flask, request
import io
app = Flask(__name__)




@app.route('/', methods=['PUT'])
def index():
    raw_data = request.get_data()
    data = raw_data.decode()
    new_data = [int(num) for num in data[1:-1].split(",")]
    with open("./video.mov", "wb") as file:
        file.write(bytearray(new_data))
    return raw_data


app.run(host="0.0.0.0", port=8080)




#
    