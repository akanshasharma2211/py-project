def image
pipeline {
    environment {
        registry = "22119697/pipline"
        registryCredential = 'docker_hub'
        dockerImage = ''
    }
    agent any

    stages{
        
        stage("Build Image") {

            steps {
                script {
                     image = registry + ":${env.BUILD_NUMBER}"
                     println ("${image}")
                     dockerImage = docker.build image
                    
                }
            }

        

        }

        stage("Testing - running in Jenkins Node") {

            steps {
                sh "docker run -d --name ${JOB_NAME} -p 5000:5000 ${image}"
            }
        }
        stage('Cleaning up') {
             steps {
                 sh "docker rm -f ${JOB_NAME}"
               }
        }
        stage("Push to Dockerhub") {
            steps {
                script {
                    docker.withRegistry('', registryCredential ) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage("running in staging") {
            steps {
                script {
                     def pullimage = "docker pull ${image}”
                     def drun = "docker run -d --name ${JOB_NAME} -p 5000:5000 ${image}”
                    sshagent([‘ssh’-login]) {
                        sh returnStatus: true, script: "ssh -o StrictHostKeyChecking=no ubuntu@3.140.247.108  ${pullimage}”
                        sh returnStatus: true, script: "ssh -o StrictHostKeyChecking=no ubuntu@3.140.247.108  ${drun}"
                    }
                    
                }
                
            }
        }
          
    }
}
