FROM xylphid/wine

LABEL maintainer.name="Anthony PERIQUET"
LABEL maintainer.email="anthony@periquet.net"
LABEL description="Balsamiq is a rapid wireframing tool that helps you Work Faster & Smarter. It reproduces the experience of sketching on a whiteboard, but using a computer."

ENV MOCKUP_SRC		"https://builds.balsamiq.com/mockups-desktop/Balsamiq_Mockups_3.5.16_bundled.zip"

USER root

ADD $MOCKUP_SRC $HOME
RUN apt update && \
	apt install -y unzip && \
	unzip ${HOME}/Balsamiq*.zip -d ${HOME} && \
	rm ${HOME}/Balsamiq*.zip && \
	mv ${HOME}/Balsamiq* ${HOME}/mockup && \
	apt remove -y unzip && \
	rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh && \
    ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat

USER wine

ENTRYPOINT [ "docker-entrypoint.sh" ]