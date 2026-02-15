node {
    // Gunakan image Maven resmi
    def mvnImage = docker.image('maven:3.9.9-eclipse-temurin-21')

    // Jalankan container Maven
    mvnImage.inside {
        stage('Build') {
            // Compile the Java code using Maven
            sh 'mvn clean install'
        }

        stage('Test') {
            sh 'mvn test'
        }

        stage('Run Hello World') {
            // Jalankan class Java hasil compile
            sh 'java -cp target/classes com.mycompany.app.App'
        }
    }
}