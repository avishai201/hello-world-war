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
'''
      }
    }

    stage('Maven Test') {
      steps {
        sh 'mvn test'
      }
    }

    stage(' Increment the pom') {
      steps {
        sh 'mvn build-helper:parse-version versions:set -DnewVersion=1.0.0.$BUILD_ID-SNAPSHOT versions:commit'
      }
    }

  }
}