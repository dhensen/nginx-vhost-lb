from flask import Flask
app = Flask(__name__)


@app.route("/")
def index():
    return ""


@app.route("/register")
def register():
    reload_nginx()
    return "register site"


@app.route("/deregister")
def deregister():
    reload_nginx()
    return "deregister site"


def reload_nginx():
    pass


if __name__ == '__main__':
    app.run()
