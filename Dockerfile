FROM tomcat:9-jdk17

# 기존 기본 앱 제거
RUN rm -rf /usr/local/tomcat/webapps/*

# WAR 파일을 ROOT.war로 복사 (루트 경로에서 바로 접속되게 함)
COPY TravelSite.war /usr/local/tomcat/webapps/ROOT.war

# Tomcat 포트 8080 노출
EXPOSE 8080

CMD ["catalina.sh", "run"]