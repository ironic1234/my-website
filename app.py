from flask import Flask, render_template

app = Flask(__name__)

@app.route("/")
def home():
    return render_template("index.html", title="Home", alt_home="terminal")

@app.route("/terminal")
def terminal():
    return render_template("terminal.html", title="Terminal", alt_home="home")

@app.route("/projects")
def projects():
    return render_template("projects.html", title="Projects", alt_home="home")

@app.route("/blog")
def blog():
    return render_template("blog/index.html", title="Blog", alt_home="home")

@app.route("/blog/<path:post>")
def blog_post(post):
    return render_template(f"blog/{post}.html", title=post.replace("-", " ").title(), alt_home="home")

if __name__ == "__main__":
    app.run(debug=True)
