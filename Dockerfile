# Utiliza la imagen oficial de Jenkins como base
FROM jenkins/jenkins:lts

# Instala JMeter
USER root
RUN apt-get update && \
    apt-get install -y wget unzip maven && \
    wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-5.5.zip -O /tmp/jmeter.zip && \
    unzip /tmp/jmeter.zip -d /opt && \
    rm /tmp/jmeter.zip && \
    ln -s /opt/apache-jmeter-5.5 /opt/jmeter

# Configura el PATH para JMeter
ENV PATH=$PATH:/opt/jmeter/bin

# Instala JUnit y sus dependencias
RUN apt-get install -y junit4

# Instala SoapUI
RUN wget https://dl.eviware.com/soapuios/5.7.2/SoapUI-5.7.2-linux-bin.tar.gz && \
    tar -xzf SoapUI-5.7.2-linux-bin.tar.gz && \
    mv SoapUI-5.7.2 /opt/soapui && \
    ln -s /opt/soapui/bin/soapui.sh /usr/local/bin/soapui

# Configura el PATH para SoapUI
ENV PATH=$PATH:/opt/soapui/bin

# Instala Google Chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt-get install -y ./google-chrome-stable_current_amd64.deb && \
    rm google-chrome-stable_current_amd64.deb

# Descarga e instala Google Chrome versión 128 (si es necesario)
# Nota: La descarga de versiones específicas de Google Chrome puede no estar disponible en la URL directa proporcionada.
RUN wget https://storage.googleapis.com/chrome-for-testing-public/128.0.6613.86/linux64/chrome-linux64.zip && \
    unzip chrome-linux64.zip -d /opt/chrome && \
    rm chrome-linux64.zip && \
    ln -s /opt/chrome/chrome /usr/local/bin/google-chrome

# Instala ChromeDriver versión 128
RUN wget https://storage.googleapis.com/chrome-for-testing-public/128.0.6613.84/linux64/chromedriver-linux64.zip && \
    unzip chromedriver-linux64.zip -d /usr/local/bin/ && \
    mv /usr/local/bin/chromedriver-linux64 /usr/local/bin/chromedriver && \
    chmod +x /usr/local/bin/chromedriver && \
    rm chromedriver-linux64.zip

# Cambia el usuario de nuevo a Jenkins
USER jenkins
