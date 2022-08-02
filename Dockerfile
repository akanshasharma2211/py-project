FROM python:3.8-slim-buster as img1

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
EXPOSE 3089

COPY . .

CMD [ "python", "app.py"]

FROM python:3.8-slim-buster as img2

COPY requirements2.txt requirements2.txt
RUN pip3 install -r requirements2.txt
EXPOSE 5000

COPY . .

CMD [ "python", "app2.py"]
