pipeline {
    agent any
    environment
    {
        IMAGE = "swvl-nodejs"
        MONGO_INITDB_DATABASE = "swvl-mongo"
        MONGO_INITDB_ROOT_USERNAME = "root"
        MONGO_INITDB_ROOT_PASSWORD = "X0YxdQOisKTF4q"
        MONGODB_URI = "swvl-mongodb"
        NODE_ENV = "production"
        SECRET = "SWVL"
        apiUrl = "swvl-nodejs"
    }   

    stages {
        // # Pull our project
        stage("git pull nodejs app") {
            steps {
              script {
                git branch: 'master',
                credentialsId: 'f099204e-cc18-4e26-bcff-1dabb9b5d149',
                url: 'git@github.com:EmaLinuxawy/node-express-realworld-example-app.git'
              }
            }
        }
        // # Start Build docker image stage
        stage("Docker build") {
            steps {
              script {
              //# Send a slack alert to let us the new build has been STARTED
              //slackSend (color: '#FFFF00', message: "STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'")
              sh 'docker-compose up -d --build'
              }
            }
        }
        // # Start test our Application API
        stage('Run our containers then Test API') {
            steps {
              script {
                docker.image('swvl-nodejs').inside {
                sh 'sleep 5'
                sh 'newman run ./tests/api-tests.postman.json -e ./tests/env-api-tests.postman.json'
                }
              }
            }
        }
        // # RUN our app.
        stage("Run Application") {
            steps {
                sh "docker-compose up -d --build"
                slackSend (color: '#008000', message: "SWVL App is running now") 
                }
              }
          }
}
