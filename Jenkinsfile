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
            // Build
            sh 'mvn clean package -DskipTests'

            // Stop jika masih ada yang jalan
            sh 'fuser -k 4000/tcp || true'

            // Run JAR
            sh '''
            JAR_FILE=$(find target -name "*.jar" ! -name "original-*.jar" | head -n 1)
            nohup java -jar $JAR_FILE --server.port=4000 > app.log 2>&1 &
            echo $! > app.pid
            '''

            input message: 'Aplikasi Java sudah berjalan. Klik "Proceed" untuk menghentikan.'

            // Stop App
            sh '''
            if [ -f app.pid ]; then
            kill $(cat app.pid) || true
            rm app.pid
            fi
            '''

        } catch (exc) {
            echo 'Deploy failed!'
            throw exc
        }

    }
}