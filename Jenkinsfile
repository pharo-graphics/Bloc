pipeline {
    agent any
    stages {
        stage('Load') {
            steps {
                sh 'git clean -f -d'
                sh 'chmod +x scripts/build/load.sh'
                sh 'scripts/build/load.sh'
            }
        }
        stage('Run examples') {
            steps {
                sh 'chmod +x scripts/build/test.sh'
                sh 'scripts/build/test.sh'
                junit '*.xml'
            }
        }
    }
}
