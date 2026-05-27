pipeline{
    agent{
        label "AGENT-1"
    }
    environment{
        appVersion= ""
    }
    stages{
        stage("read app Version") {
            step{
                script {
                    // Read the file and parse it into an object
                    def packageJson = readJSON file: 'package.json'
                    // Access the 'version' property directly
                    appVersion = packageJson.version
                    echo "Current package version: ${packageVersion}"
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