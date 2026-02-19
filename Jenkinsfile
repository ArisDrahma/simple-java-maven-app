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
                sh '''
                JAR_FILE=$(ls target/*.jar | grep -v original | head -n 1)

                # Stop aplikasi lama kalau ada
                if [ -f app.pid ]; then
                    kill -9 $(cat app.pid) || true
                    rm app.pid
                fi
                nohup java -jar $JAR_FILE --server.port=4000 > app.log 2>&1 &
                echo $! > app.pid
                '''
            } catch (exc) {
                echo 'Deploy failed!'
                throw exc
            }
        }
    }
}