pipeline{
    agent{
        label "NODE-1"
    }
    environment{
        appVersion= ''
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
    }
    post{
        always{
            echo "this will execute always"
            deleteDir()
        }
        success{
            echo "this will execute only success the build"
        }
        failure{
            echo "this will execute only fail the build"
        }
    }
}