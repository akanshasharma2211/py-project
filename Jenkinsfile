def image
pipeline {
    environment {
        registry = "manish754/python"
        registryCredential = 'docker-hub-login'
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
                    def stopcontainer = "docker stop ${JOB_NAME}"
                    def delcontName = "docker rm ${JOB_NAME}"
                    def delimages = "docker image prune -a --force"
            

                    def drun = "docker run -d --name ${JOB_NAME} -p 5000:5000 ${img}"
                    sshagent(['docker-test']) {
                        sh returnStatus: true, script: "ssh -o StrictHostKeyChecking=no ubuntu@3.144.212.131 ${stopcontainer}"
                        sh returnStatus: true, script: "ssh -o StrictHostKeyChecking=no ubuntu@3.144.212.131 ${delcontName}"
                        sh returnStatus: true, script: "ssh -o StrictHostKeyChecking=no ubuntu@3.144.212.131 ${delimages}"
                        sh "ssh -o StrictHostKeyChecking=no ubuntu@3.144.212.131 ${drun}"
                    }
                    
                }
                
            }
        }
 }
 
}
