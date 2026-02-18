node {

    docker.image('maven:3.9.9-eclipse-temurin-21')
        .inside('-v /var/run/docker.sock:/var/run/docker.sock -v $HOME/.m2:/root/.m2') {

        stage('Build') {
            try {
                sh 'mvn clean compile'
            } catch (exc) {
                echo 'Build failed!'
                throw exc
            }
        }

        stage('Test') {
            try {
                sh 'mvn test'
            } catch (exc) {
                echo 'Test failed!'
                throw exc
            }
        }

        stage('Run Hello World') {
            try {
                sh 'java -cp target/classes com.mycompany.app.App'
            } catch (exc) {
                echo 'Run failed!'
                throw exc
            }
        }
        stage('Deploy') {
            try {
            // Build JAR
            sh 'mvn clean package -DskipTests'

            // Jalankan aplikasi Java di background
            sh 'nohup java -jar target/*.jar > app.log 2>&1 & echo $! > app.pid'

            // Tunggu konfirmasi manual
            input message: 'Aplikasi Java sudah selesai digunakan? Klik "Proceed" untuk menghentikan.'

            // Stop aplikasi berdasarkan PID
            sh 'kill $(cat app.pid)'

            } catch (exc) {
                echo 'Deploy failed!'
                throw exc
            }
        }
    }
}