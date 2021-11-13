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
mvn clean package'''
      }
    }

    stage('Stop all runinig Containers') {
      steps {
        sh 'docker stop $(docker ps -aq) || true'
      }
    }

    stage('Delete all Images&Containers') {
      steps {
        sh '''docker rm -f $(docker ps -aq) || true
docker rmi -f $(docker images -q) || true'''
      }
    }

    stage('Docker Build') {
      steps {
        sh 'docker build -t ${reponame}:$BUILD_ID .'
      }
    }

    stage('Docker run') {
      steps {
        sh 'docker run -itd -p 8081:8080 ${reponame}:$BUILD_ID'
      }
    }

    stage('Test container before pushing to repo') {
      steps {
        sh '''#!/bin/bash

sleep 15
myip="$(ip route get 8.8.8.8 | sed -n \'/src/{s/.*src *\\([^ ]*\\).*/\\1/p;q}\')"
echo $myip

if curl -I "http://${myip}:8081" 2>&1 | grep -w "200\\|301" ; then
    echo "server is up"
else
    echo "server is down"
    exit 1
fi

exit 0'''
      }
    }

    stage('Push image to DockerHub') {
      steps {
        sh 'docker push ${reponame}:$BUILD_ID'
      }
    }

    stage('Slack') {
      steps {
        slackSend(token: 'WBoniVFZfbAefgOzyMSEscli', channel: 'int-project', message: '"started ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)"', color: '#439FE0', baseUrl: 'https://hub.docker.com/r/avishai201/hello-world-war/tags', notifyCommitters: true)
      }
    }

  }
  environment {
    reponame = 'avishai201/hello-world-war'
  }
}