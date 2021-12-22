import os
from flask import Flask, flash, render_template, request, redirect, url_for
from werkzeug.utils import secure_filename

try:
    from PIL import Image
except ImportError:
    import Image
import pytesseract

import pyttsx3

from googletrans import Translator, constants
from pprint import pprint

import matplotlib.pyplot as plt
import itertools

UPLOAD_FOLDER = '.\static'
ALLOWED_EXTENSIONS = set(['png', 'jpg', 'jpeg'])

app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

text = ''

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

def ocr_core(filename):
    pytesseract.pytesseract.tesseract_cmd = (r'C:\Program Files\Tesseract-OCR\tesseract.exe')
    text = pytesseract.image_to_string(Image.open(filename))
    return text

def countL(text):
    lines = 0
    for l in text:
        if '\n' in l:
            lines += 1
    return lines

def word_count(str):
    counts = dict()
    words = str.split()
    for word in words:
        if word in counts:
            counts[word] += 1
        else:
            counts[word] = 1
    counts = sorted(counts.items(), key=lambda x: x[1], reverse=True)
    return counts

@app.route('/', methods=['GET', 'POST'])
def upload_file():
    if request.method == 'POST':
        if 'file' not in request.files:
            flash('No file part')
            return redirect(request.url)
        file = request.files['file']
        if file.filename == '':
            flash('No selected file')
            return redirect(request.url)
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            path = './static/' + filename
            text = ocr_core(path)
            lines = countL(text)
            words = word_count(text)
            words = itertools.islice(words , 0, len(words) // 2)
            return render_template('imagen.html', path = path, text = text, lines = lines, words = words)
    return render_template('index.html')

@app.route('/audio', methods=['POST'])
def playAudio():
    engine = pyttsx3.init()
    text = request.form.get('text')
    engine.say(text)
    engine.runAndWait()
    return text

@app.route('/translate', methods=['POST'])
def traducir():
    translator = Translator()
    text = request.form.get('text')
    translation = translator.translate(text)
    return (f"{translation.origin} ---> {translation.text}")

@app.route('/graphic', methods=['POST'])
def graficar():
    text = request.form.get('text')
    words = word_count(text)
    words = itertools.islice(words , 0, len(words) // 2)
    keys = list()
    values = list()
    for word in words:
        keys.append(word[0])
        values.append(word[1])
    plt.bar(keys, values)
    plt.show()
    return 'Grafico'

if __name__ == '__main__':
    app.run()
