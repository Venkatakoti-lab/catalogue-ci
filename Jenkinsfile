pipeline{
    agent{
        label "AGENT-1"
    }
    environment{
        appVersion= ""
        REGION= "us-east-1"
        ACC_ID= "747639505780"
        COMPONENT= "catalogue"
    }
    stages{
        stage("read app Version") {
            steps{
                script {
                    // Read the file and parse it into an object
                    def packageJson = readJSON file: 'package.json'
                    // Access the 'version' property directly
                    appVersion = packageJson.version
                    echo "Current package version: ${appVersion}"
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
        stage("Build and Push") {
            steps{
                withAWS(credentials: 'aws-creds', region: '${REGION}') {
                // Use plugin-specific steps or standard AWS CLI
                sh """
                aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${ACC_ID}.dkr.ecr.${REGION}.amazonaws.com
                docker build -t ${ACC_ID}.dkr.ecr.${REGION}.amazonaws.com/roboshop/${COMPONENT}:${appVersion} .
                docker push ${ACC_ID}.dkr.ecr.${REGION}.amazonaws.com/roboshop/${COMPONENT}:${appVersion}
                """
                }
            }
        }
    }
    post{
        always{
            echo "This will run always"
        }
        success{
            echo "This will run when the pipeline is SUCCESS"
        }
        failure{
            echo "This will run when the pipeline is FAIL"
        }
    }
}