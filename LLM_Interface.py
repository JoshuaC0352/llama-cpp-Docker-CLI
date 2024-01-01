from llama_cpp import Llama
from flask import Flask, redirect, url_for, request
import copy
import json
import sys
import os



def run_model(query):
    output = llm(
         query,
         suffix="▌",
         max_tokens=131072,
         temperature=0.8,
         echo=False,
         stream=False,
         stop="▌"
         )

    return output['choices'][0]['text']


print("Loading model...")

model = "synthia-7b-v2.0.Q4_K_M.gguf"

if(sys.argv[0] == "GPU"):
    llm = Llama(model_path=f"./models/{model}", 
            verbose=True, n_gpu_layers=32, n_threads=6, n_ctx=512, n_batch=1024)
else:
    llm = Llama(model_path=f"./models/{model}", 
            verbose=False)

print("Model loaded")


app = Flask(__name__)

@app.route('/success/<response>')
def success(response):
    return response

@app.route('/login', methods=['POST', 'GET'])
def login():
    print("Message received!!")

    query = request.form['qr']
    result = run_model(str(query))
    htmlData = open("index.html", "r")
    result += htmlData.read()
    return result

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 8080))
    app.run(debug=True, host='0.0.0.0', port=port)
