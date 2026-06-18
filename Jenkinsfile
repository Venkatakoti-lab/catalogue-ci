pipeline{
    agent{
        label "NODE-1"
    }
    environment{
        appVersion= ""
        REGION= "us-east-1"
        ACC_ID= "747639505780"
        PROJECT= "roboshop"
        COMPONENT= "catalogue"
    }
    stages{
        stage("Read the version"){
            steps{
                script{
                    def packageJson = readJSON file: 'package.json'
                    appVersion = packageJson.version
                    echo "${appVersion}"
                }
            }
        }
        stage("Install Dependencies"){
            steps{
                sh """
                    npm install
                """
            }
        }
        stage("Build and Push"){
            steps{
                withAWS(credentials: 'aws-creds', region: '${REGION}') {
                    aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ACC_ID.dkr.ecr.${REGION}.amazonaws.com
                    docker build -t ACC_ID.dkr.ecr.${REGION}.amazonaws.com/${PROJECT}/${COMPONENT}:${appVersion} .
                    docker push ACC_ID.dkr.ecr.${REGION}.amazonaws.com/${PROJECT}/${COMPONENT}:${appVersion}
                }
            }
        }
    }
    post{
        success{
            echo "this will execute only success the build"
            cleanWs()
        }
        failure{
            echo "this will execute only fail the build"
        }
    }
}