def image
pipeline {
    environment {
        registry = "22119697/pipline"
        registryCredential = 'docker-hub'
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
        stage("Deploy on k8s") {
            steps{
                     sshagent (['ssh-key']){
                     sh "scp -o StrictHostKeyChecking=no kube.yaml ubuntu@3.144.178.217:/home/ubuntu"
                         script{
                             try{
                                 sh "ssh -o ubuntu@3.144.178.217 kubectl apply -f ."
                             }catch(error){
                                 sh "ssh -o ubuntu@3.144.178.217 kubectl create -f ."

                     
                   }
                }
            }
            
        }
          
    }

}
}
