FROM python:slim-bullseye

WORKDIR /wbb
RUN chmod 777 /wbb

# Install system dependencies
RUN apt-get -qq update && \
    apt-get -qq -y upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y git gcc build-essential ffmpeg libffi-dev libssl-dev

# Upgrade pip
RUN pip3 install -U pip

# Install pyrogram directly due to GitHub source
RUN pip3 install --no-cache-dir git+https://github.com/KurimuzonAkuma/pyrogram.git

# Copy requirements file and install dependencies in groups
COPY requirements.txt .

RUN pip3 install --no-cache-dir aiohttp aiofiles ffmpeg-python gTTS dnspython future
RUN pip3 install --no-cache-dir googletrans==4.0.0rc1 motor pillow psutil pykeyboard python-arq
RUN pip3 install --no-cache-dir requests search-engine-parser speedtest-cli TgCrypto uvloop youtube_dl
RUN pip3 install --no-cache-dir bs4 python-dotenv feedparser pyromod fuzzysearch img2pdf telegraph pytube pytz
RUN pip3 install --no-cache-dir Flask gunicorn Jinja2 werkzeug itsdangerous

# Copy all source files
COPY . .

# Start Bot
CMD ["python3", "-m", "wbb"]
