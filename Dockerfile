FROM python:3.11.0b4-slim-buster
WORKDIR /app
RUN pip install -r requirements.txt

EXPOSE 5000
CMD ["python3", "flask", "run", "app.py"]
