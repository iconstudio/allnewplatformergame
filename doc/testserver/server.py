"""
	Project: Server
"""
from flask import Flask, escape, request

app = Flask(__name__)
name = "iconer"
"".encode

@app.route("/")
def hello():
	 name = request.args.get("name", "World")
	 return f'Hello, {escape(name)}!'

@app.route("/sun")
def subroot1():
	print("subroot1")
	return "subroot1"

if __name__ == "__main__":
	pass
