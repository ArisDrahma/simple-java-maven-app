# Gunakan base image openjdk 21
FROM eclipse-temurin:21-jdk

# Set working directory di container
WORKDIR /app

# Copy jar dari target ke container
COPY target/*.jar app.jar

# Expose port aplikasi
EXPOSE 8080
# Jalankan aplikasi
ENTRYPOINT ["java","-jar","/app/app.jar","--server.port=4000"]

