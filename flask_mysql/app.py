from flask import Flask, render_template, request
from flask_mysqldb import MySQL
import yaml

app = Flask(__name__)

# Configure DB
db = yaml.load(open('db.yaml'))
app.config['MYSQL_HOST'] = db['mysql_host']
app.config['MYSQL_USER'] = db['mysql_user']
app.config['MYSQL_PASSWORD'] = db['mysql_password']
app.config['MYSQL_DB'] = db['mysql_db']

mysql = MySQL(app)

@app.route('/',methods=['GET','POST'])
def index():
        if request.method == 'POST':
                # FETCH FORM DATA
                userdetails = request.form
                name = userdetails['name']
                email = userdetails['email']
                gender = userdetails['gender']
                country = userdetails['country']
                password = userdetails['password']
                # CREATING MYSQL OBJECT
                cur = mysql.connection.cursor()
                cur.execute("INSERT INTO users(name, email, gender, country, password) VALUES(%s, %s, %s, %s, %s)", (name, email, gender, country,password))
                mysql.connection.commit()
                cur.close()
                return render_template('success.html')
        return render_template('index.html')

@app.route('/users')
def users():
        cur = mysql.connection.cursor()
        resutlValue = cur.execute("SELECT * FROM users") #this wiill return no. of rows
        if resutlValue > 0:
                userdetails = cur.fetchall()
                return render_template('users.html',userdetails=userdetails)

if __name__ == '__main__':
      app.run(debug=True)