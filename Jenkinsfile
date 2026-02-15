node {
        // Use a Docker image that includes Maven and a specific Java version (e.g., Java 17)
        docker {
            image ('maven:3.9.9-eclipse-temurin-21') 
            args ('-v /var/run/docker.sock:/var/run/docker.sock') // Mount Docker socket to allow building Docker images from within Jenkins agent
        }
        stage('Build') {
            steps {
                // Compile the Java code using Maven
                sh 'mvn clean compile'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('Run Hello World') {
            steps {
                // Run the compiled Java class
                //  sh 'java Hello'
                 sh 'java -cp target/classes com.mycompany.app.App'
                // For a Maven project, the run command might be different, but for a simple "Hello.java" in the root directory:
                // sh 'java -cp target/classes Hello' // (if compiled into target/classes by mvn compile)
            }
        }
}
