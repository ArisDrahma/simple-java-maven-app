node {

    docker.image('maven:3.8-eclipse-temurin-17')
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
        stage('Manual Approval') {
            steps {
                script {
                    input message: 'Lanjutkan ke tahap Deploy?',
                          ok: 'Proceed'
                }
            }
        }
        stage('Deploy') {
            try {
                // Build
                sh 'mvn clean package -DskipTests'

                // Matikan jika port sudah dipakai
                sh 'fuser -k 4000/tcp || true'

                // Jalankan aplikasi
                sh '''
                nohup java -jar target/my-app-1.0-SNAPSHOT.jar --server.port=4000 > app.log 2>&1 &
                echo $! > app.pid
                '''

                echo "Aplikasi berjalan di port 4000 selama 1 menit..."

                // Jeda 1 menit
                sleep(time: 1, unit: 'MINUTES')

                echo "Menghentikan aplikasi..."

                // Stop aplikasi
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
}