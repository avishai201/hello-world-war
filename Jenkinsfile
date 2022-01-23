pipeline {
  agent {
    node {
      label 'docker-vm'
    }
  }
    environment {
      sonar_cred = credentials('SONAR_TOKEN')

    }

  triggers {
   //Query repository every minute
     pollSCM('* * * * *')
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

    stage('SonarCloud') {
      steps {
        sh '''mvn verify org.sonarsource.scanner.maven:sonar-maven-plugin:sonar -Dsonar.login=$sonar_cred
'''
      }
    }
    // Building Docker images
    stage('Docker Build') {
      steps {
        sh 'docker build -t helloworld:$BUILD_ID .'
      }
    }
    // Uploading Docker images into Nexus Registry
    stage('Tag and Push to Nexus') {
      steps {
            withDockerRegistry(credentialsId: 'Nexus' , url: 'http://10.10.10.226:8123/repository/docker-hosted/') {
        sh '''docker tag helloworld:$BUILD_ID 10.10.10.226:8123/repository/docker-hosted/helloworld:$BUILD_ID

               docker push 10.10.10.226:8123/repository/docker-hosted/helloworld:$BUILD_ID'''
              }
      }
    }
        stage('Remove docker image') {
          steps {
            sh 'docker rmi helloworld:$BUILD_ID 10.10.10.226:8123/repository/docker-hosted/helloworld:$BUILD_ID'
          }
        }
    }
    post {
     success {
        slackSend(message: "Build deployed successfully - ${env.JOB_NAME} #${env.BUILD_NUMBER} - (${env.BUILD_URL}) ", channel: 'int-project', color: '#008000')
     }

     failure {
          slackSend(message: " Build failed - ${env.JOB_NAME} #${env.BUILD_NUMBER} - (${env.BUILD_URL}) ", channel: 'int-project', color: '#FF0000')
     }
  }
}