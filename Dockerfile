FROM python:3.10

# install google chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && \
    apt-get -y update && apt-get install -y google-chrome-stable unzip && \
    wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip && \
    unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/ && \
    chmod 777 /usr/local/bin/chromedriver 

RUN apt-get update && \
    apt-get install -y \
        fonts-ipafont-gothic fonts-ipafont-mincho \
        ttf-wqy-microhei fonts-wqy-microhei       \
        fonts-tlwg-loma fonts-tlwg-loma-otf       \
    && apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

COPY requirements.txt /tmp/requirements.txt
COPY cert.pem /tmp/cert.pem
RUN python3 -m pip install --upgrade pip &&\
    pip3 install -r /tmp/requirements.txt &&\
    cat /tmp/cert.pem >> /etc/ssl/certs/ca-certificates.crt

    
