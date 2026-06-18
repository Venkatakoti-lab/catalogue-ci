pipeline{
    agent{
        label "NODE-1"
    }
    stages{
        stage("build"){
            steps{
                echo "Hello this is build"
            }
        }
        stage("test"){
            steps{
                echo "hello test"
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