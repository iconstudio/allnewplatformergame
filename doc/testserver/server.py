"""
	Project: Server
"""
from flask import Flask, escape, request, jsonify
from flask_restful import Resource, Api

app = Flask(__name__)
api = Api(app)

@app.route("/")
def hello():
	name = request.args.get("name", "World")
	return f'Hello, {escape(name)}!'
 
@app.route('/environments/<language>')
def environments(language):
	return jsonify({"language":language})

@app.route("/subroot1")
def fn_subroot1():
	print("subroot1-py-msg")
	return "subroot1-js-log"

@app.route('/user/login', methods = ['POST'])
def userLogin():
	user = request.get_json() # json 데이터를 받아옴
	return jsonify(user) # 받아온 데이터를 다시 전송

class RegistUser(Resource):
	"""Making a new restful api for URI 'user'.
	"""

	def post(self):
		return {'result': 'ok'}

"""app_route("/user")
"""
api.add_resource(RegistUser, '/user')

if __name__ == "__main__":
	app.run()
