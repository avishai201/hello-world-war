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
        withSonarQubeEnv(credentialsId: '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', installationName: 'SonarQube-Server')
        waitForQualityGate(webhookSecretId: 'SonarWebHook', credentialsId: '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', abortPipeline: true)
      }
    }

  }
  environment {
    reponame = 'avishai201/hello-world-war'
  }
}