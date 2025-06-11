from flask import Flask, render_template

app = Flask(__name__)

@app.route("/")
def home():
    return render_template("index.html", title="Home", alt_home="terminal")

@app.route("/terminal")
def terminal():
    return render_template("terminal.html", title="Terminal", alt_home="home")

@app.route("/about")
def about():
    return render_template("about.html", title="About")

@app.route("/projects")
def projects():
    return render_template("projects.html", title="Projects")

@app.route("/blog")
def blog():
    return render_template("blog/index.html", title="Blog")

@app.route("/contact")
def contact():
    return render_template("contact.html", title="Contact")

if __name__ == "__main__":
    app.run(debug=True)
