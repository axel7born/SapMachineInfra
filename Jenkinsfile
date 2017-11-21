pipeline {
    agent any
    stages {
        stage('Build') {
            withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: '23116a5d-8ea6-4b27-819e-94cef8861fac',
usernameVariable: 'GIT_USER', passwordVariable: 'GIT_PASSWORD']]) {
            agent {
                dockerfile {
                    dir 'git-hg'
                    args "-e GIT_USER=$GIT_USER -e GIT_PASSWORD=$GIT_PASSWORD"
                }
            }
            steps {
                sh 'git-hg/update_repo.sh'
            }
        }
    }
}
