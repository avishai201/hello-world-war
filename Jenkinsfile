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
        sh '''docker rm -f $(docker ps -aq)
docker rmi -f $(docker images -q)'''
      }
    }

    stage('Docker Build') {
      steps {
        sh 'docker build -t avishai201/hello-world-war:$BUILD_ID .'
      }
    }

    stage('Docker run') {
      steps {
        sh 'docker run -itd -p 8081:8080 avishai201/hello-world-war:$BUILD_ID'
      }
    }

    stage('Test container before pushing to repo') {
      steps {
        sh 'basic_test.sh'
      }
    }

    stage('Push image to DockerHub') {
      steps {
        sh 'docker push avishai201/hello-world-war:$BUILD_ID'
      }
    }

  }
}