FROM python:3.11.0b4-slim-buster
WORKDIR /app .
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY . .
EXPOSE 3089
CMD ["python", "app.py"]
