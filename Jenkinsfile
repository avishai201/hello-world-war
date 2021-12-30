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
        sh '''mvn verify org.sonarsource.scanner.maven:sonar-maven-plugin:sonar -Dsonar.login=$sonar_cred
'''
      }
    }

    stage('Docker Build') {
      steps {
        sh 'docker build -t helloworld:$BUILD_ID .'
      }
    }

    stage('Push to Nexus') {
      steps {
        sh 'docker tag helloworld:$BUILD_ID 10.10.10.233:8123/repository/docker-hosted/helloworld:$BUILD_ID'
      }
    }

  }
  environment {
    sonar_cred = credentials('SONAR_TOKEN')
  }
}