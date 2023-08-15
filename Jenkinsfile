pipeline{
    agent any
    
    stages{
        stage("Download code"){
           steps{
                git branch: 'main', url: 'https://github.com/harshitadwivedi1199/Hello-World'
           }
        }

    
    
        stage("Build docker image"){
            steps{
                sh "sudo docker build -t harc1199/hello-world:${BUILD_TAG} ."
            }
        }
        
        stage("Push docker image"){
            steps{
                sh "whoami"
                withCredentials([string(credentialsId: 'DOCKER_HUB_PASSWD', variable: 'DOCKER_HUB_CRED_PASSWD')]) {
                    sh "docker login -u harc1199 -p $DOCKER_HUB_CRED_PASSWD"
                    sh "docker push harc1199/hello-world:${BUILD_TAG} "
                }
            }
        }
        
        stage("Push docker image"){
            steps{
                sshagent(['DEV_QA_PROD_ENV']) {
                    sh "ssh -o StrictKeyChecking=no ec2-user@54.81.157.211 sudo docker rm -f  myweb"
                    sh "ssh ec2-user@54.81.157.211 sudo docker run -d -p 80:80 --name myweb harc1199/hello-world:${BUILD_TAG}"
    
                }
            }
        }
    }
}
