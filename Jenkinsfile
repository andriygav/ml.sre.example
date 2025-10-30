pipeline {
  agent { label 'docker-agent' }

  options {
    disableConcurrentBuilds()
    buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '10')
  }
  
  environment {
    Registry                       = 'nexus.lcl'
  }
  
  stages {
    stage("PROD") {
      when {
        anyOf { branch 'master'; }
      }
      steps {
        sh """echo 'hello world'"""
      }
    }
  }
}
