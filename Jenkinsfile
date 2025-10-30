pipeline {
  agent { label 'docker-agent' }

  options {
    disableConcurrentBuilds()
    buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '10')
  }
  
  environment {
    Registry                       = 'nexus.lcl'
    
    CREDENTIAL                     = credentials("admin")
    BITBUCKET_REPOSITORY           = "ml.sre.example"
  }
  
  stages {
    stage('Build') {
      environment {
          DOCKER_TLS_VERIFY        = "false"
      }
      steps {
        script {
          def buildArgs = "-f Dockerfile . --tls-verify=false"
          docker.build("${Registry}/${BITBUCKET_REPOSITORY}:latest", buildArgs)
        }
      }
    }

    stage('Publish Docker Artifact') {
      when {
        anyOf { branch 'dev'; branch 'master'; }
      }
      steps {
        script {
          sh """docker login --tls-verify=false --password ${CREDENTIAL_PSW} --username ${CREDENTIAL_USR} ${Registry}"""
          sh """docker push --tls-verify=false ${Registry}/${BITBUCKET_REPOSITORY}:latest"""
        }
      }
    }
  }
}
