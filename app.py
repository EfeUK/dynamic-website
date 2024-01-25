from flask import Flask, render_template, request

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def index():
    dynamic_string = request.args.get('dynamic_string', 'dynamic string')

    if request.method == 'POST':
        new_string = request.form['new_string']
        dynamic_string = new_string

    return render_template('index.html', dynamic_string=dynamic_string)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=80)




# # Get the current directory
# current_dir = os.path.dirname(os.path.abspath(__file__))
# template_folder = os.path.join(current_dir, 'templates')

# # Set the template folder explicitly
# app.template_folder = template_folder

# @app.route('/')
# def index():
#     dynamic_string = request.args.get('query', 'default value')
#     return render_template('index.html', dynamic_string=dynamic_string)

# if __name__ == '__main__':
#     app.run(debug=True, host='0.0.0.0', port=80)
