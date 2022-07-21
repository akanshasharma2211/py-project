def image
pipeline {
    environment {
        registry = "22119697/k8s"
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
                     sh "scp -o StrictHostKeyChecking=no kube.yaml ubuntu@18.191.216.121:/home/ubuntu"
                         script{
                             try{
                                 sh "ssh -o StrictHostKeyChecking=no ubuntu@18.191.216.121 kubectl apply -f kube.yaml"
                             }catch(error){
                                 sh "ssh -o StrictHostKeyChecking=no ubuntu@18.191.216.121 kubectl create -f kube.yaml"

                     
                   }
                }
            }
            
        }
          
    }

}
}
