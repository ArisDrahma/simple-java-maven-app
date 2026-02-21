node {
    //deleteDir()
    //checkout scm

    docker.image('maven:3.9.9-eclipse-temurin-21')
    .inside('-v $HOME/.m2:/root/.m2'){
        stage('Build') {
            try {
                sh 'mvn clean package -DskipTests'
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

        //stage('Run Hello World') {
        //   try {
        //        sh 'nohup java -jar target/*.jar &'
        //            }
        //    } catch (exc) {
        //        echo 'Run Hello World failed!'
        //        throw exc
        //    }
        //}

        //stage('Manual Approval') {
        //    try {
        //        input message: 'Lanjutkan ke tahap Deploy?',
        //            ok: 'Proceed'
        //    } catch (exc) {
        //        echo 'Manual approval dibatalkan!'
        //        throw exc
        //    }
        //}

        stage('Deploy') {
            try {
                
            //    sh '''
            //    echo "Menghapus container lama jika ada..."
            //   docker rm -f my-app-container || true

            //    echo "Build Docker image..."
            //    docker build -t my-app .

            //    echo "Menjalankan container di port 4000..."
            //    docker run -d \
            //    --name my-app-container \
            //    -p 4000:4000 \
            //    my-app
            //    '''

            //    echo "Aplikasi berjalan selama 1 menit..."
            //    sleep(time: 1, unit: 'MINUTES')

            //    sh '''
            //    echo "Menghentikan container setelah 1 menit..."
            //    docker rm -f my-app-container || true
            //    '''

                sh 'mvn clean package -DskipTests'
                sh 'nohup java -jar target/my-app-1.0-SNAPSHOT.jar --server.port=4000 > app.log 2>&1 &'
                input message: 'Klik Proceed untuk menghentikan aplikasi'
                sh "pkill -f my-app-1.0-SNAPSHOT.jar || true" 

            } catch (exc) {
                echo 'Deploy failed!'
                throw exc
            }
        }
    }   
}