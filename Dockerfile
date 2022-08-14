FROM python:3.8

WORKDIR /app

COPY . .

RUN pip install --upgrade --no-cache-dir pip==22.2.2 \
    && pip install --no-cache-dir -r requirements.txt \
    && hadolint ignore=DL3013

EXPOSE 80

CMD ["python", "app.py"]
