pipeline {
    agent any
    stages {
        stage('Build') {
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
