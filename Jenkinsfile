pipeline {
    agent any
    stages {
        stage('Load') {
            steps {
                sh 'git clean -f -d'
                sh 'scripts/build/load.sh'
            }
        }
        stage('Run examples') {
            steps {
                sh 'scripts/build/test.sh'
                junit '*.xml'
            }
        }
    }
}