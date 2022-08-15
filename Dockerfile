FROM python:3.7.3-stretch

WORKDIR /app

COPY . app.py model_data requirements.txt /app/

# hadolint ignore=DL3013
RUN pip install --upgrade --no-cache-dir pip && \ 
    pip install --no-cache-dir -r requirements.txt

EXPOSE 80

CMD ["python", "app.py"]
