FROM python:3.8

WORKDIR /app

COPY . .

RUN pip install --upgrade pip && \
    pip install -r requirements.txt 
    # hadolint ignore=DL3013

EXPOSE 80

CMD ["python", "app.py"]
