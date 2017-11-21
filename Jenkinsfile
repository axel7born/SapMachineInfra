pipeline {
    agent any
    stages {
        stage('Build') {
            agent {
              dockerfile { dir 'git-hg' }
            }
            steps {
                sh 'git-hg/update-repo.sh'
            }
        }
    }
}
