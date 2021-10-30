pipeline {
  agent {
    node {
      label 'docker-vm'
    }

  }
  stages {
    stage('Clean before clone') {
      steps {
        cleanWs()
      }
    }

    stage('Check Out Code') {
      steps {
        git(url: 'https://github.com/avishai201/hello-world-war.git', branch: 'master', changelog: true)
      }
    }

    stage('Maven Compile ') {
      steps {
        sh '''mvn compile
mvn clean package
'''
      }
    }

  }
}