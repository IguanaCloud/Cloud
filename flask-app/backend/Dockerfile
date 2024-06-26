# Download python 3.9 from dockerhub
FROM python:3.5-alpine
# Specifying a working directory
WORKDIR /backend
# download & install dependencies
ADD . /backend
RUN pip3 install  --no-cache-dir -r requirements.txt
CMD ["flask", "run"]





