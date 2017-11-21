
pipeline {
    agent any

    stages {

        stage('Build') {

            agent {
              dockerfile { dir 'git-hg'
                args '-v $HOME:/root/host_home'
                }
            }
            steps {
              withCredentials([
                    [$class: 'UsernamePasswordMultiBinding', credentialsId: '23116a5d-8ea6-4b27-819e-94cef8861fac', usernameVariable: 'GIT_USER', passwordVariable: 'GIT_PASSWORD']
                    ]) {
                    sh '$PWD/git-hg/update_repo.sh'
                }
            }
        }
    }
}
