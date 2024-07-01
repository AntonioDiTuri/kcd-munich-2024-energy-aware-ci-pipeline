FROM python:latest
WORKDIR /app
ARG arg
ENV use_case=$arg
COPY ${use_case}.py ./app.py
CMD ["python", "app.py"]


