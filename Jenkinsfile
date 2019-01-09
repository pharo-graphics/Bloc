pipeline {
    agent any
    stages {
        stage('Load') {
            when { branch 'logging' }
            steps {
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