FROM python:3.10-alpine

WORKDIR /app

RUN pip install Flask

COPY app.py .
COPY templates /app/templates

EXPOSE 80

CMD ["python", "app.py"]
