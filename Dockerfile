FROM python:slim-bullseye

WORKDIR /wbb
RUN chmod 777 /wbb

RUN apt-get -qq update && \
    apt-get -qq -y upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y git gcc build-essential

RUN pip3 install -U pip

# Install pyrogram separately due to direct Git dependency
RUN pip3 install --no-cache-dir git+https://github.com/KurimuzonAkuma/pyrogram.git

COPY requirements.txt .
RUN pip3 install --no-cache-dir --progress-bar=on -U -r requirements.txt

# If you want to use /update feature, uncomment and edit the following
# RUN git config --global user.email "your_email"
# RUN git config --global user.name "git_username"

# Copying All Source
COPY . .

# Starting Bot
CMD ["python3", "-m", "wbb"]
