pipeline{
    agent any
    environment{
        Dev_IP="13.233.75.23"
        QA_IP="13.233.75.23"
    }
    stages{
        stage("Download code"){
           steps{
                git branch: 'main', url: 'https://github.com/harshitadwivedi1199/Hello-World'
           }
        }
        stage("Build docker image"){
            steps{
                sh " docker build -t harc1199/hello-world:${BUILD_TAG} ."
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
        stage("Deploy in Dev"){
            steps{
                // sshagent(['DEV_QA_PROD_ENV']) {
                    sh "docker rm -f  myweb"
                    sh "docker run -d -p 80:80 --name myweb harc1199/hello-world:${BUILD_TAG}"
    
                // }
            }
        }
        // stage("Deploy in Dev"){
        //     steps{
        //         sshagent(['DEV_QA_PROD_ENV']) {
        //             sh "ssh -o StrictHostKeyChecking=no ec2-user@${Dev_IP} sudo docker rm -f  myweb"
        //             sh "ssh ec2-user@${Dev_IP} sudo docker run -d -p 80:80 --name myweb harc1199/hello-world:${BUILD_TAG}"
    
        //         }
        //     }
        // }
        stage("Deploy in QA"){
            steps{
                sshagent(['DEV_QA_PROD_ENV']) {
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@${QA_IP} sudo docker rm -f  myweb"
                    sh "ssh ec2-user@${QA_IP} sudo docker run -d -p 80:80 --name myweb harc1199/hello-world:${BUILD_TAG}"
    
                }
            }
        }
        stage("Testing QA"){
            steps{
                sshagent(['DEV_QA_PROD_ENV']) {
                    sh "curl --silent http://${QA_IP}/"
                }
            }
        }
        stage("Manual Approval"){
            steps{
                input(message: "Do you want to continue ?? ")
            }
        }
        stage("Deploy in prod"){
            steps{
                echo "NEed to configure eks.."
            }
        }
        
    }
}
