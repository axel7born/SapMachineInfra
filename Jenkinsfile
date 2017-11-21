pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
              withCredentials([
                [$class: 'UsernamePasswordMultiBinding', credentialsId: '23116a5d-8ea6-4b27-819e-94cef8861fac', usernameVariable: 'GIT_USER', passwordVariable: 'GIT_PASSWORD']
                ]) {
                  sh '$PWD/run_in_docker.sh git-hg/update_repo.sh'
                  }
            }
        }
    }
}
