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
        git(url: 'https://github.com/avishai201/hello-world-war.git', branch: 'dev', changelog: true)
      }
    }

    stage('Maven Compile ') {
      steps {
        sh '''mvn compile
mvn clean package'''
      }
    }

    stage('SonarQube') {
      steps {
        withSonarQubeEnv(credentialsId: 'SonarQube', installationName: 'SonarQube-Server')
        waitForQualityGate(webhookSecretId: 'SonarWebHook', credentialsId: 'SonarQube', abortPipeline: true)
      }
    }

  }
}