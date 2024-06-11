
pipeline {
    agent any

    environment {
        // Define Docker Hub credentials environment variables
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
        DOCKER_IMAGE = 'madhurakurhadkar/caddy-static-site:latest'
    }

    stages {
        stage('Checkout') {
            steps{
                script {
                    echo 'Checking out the code from GitHub repository...'
                    checkout([
                        $class: 'GitSCM',
                        branches: [[name: 'main']],
                        userRemoteConfigs: [[credentialsId: 'github_token', url: 'https://github.com/SREArchitect/static-site.git']]
                    ])
                    echo 'Checkout completed.'
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    echo 'Building Docker image...'
                    sh "docker build --no-cache -t ${DOCKER_IMAGE} -f Dockerfile ."
                    echo 'Docker image build completed.'
                }
            }
        }
        stage('Push Docker Image to DockerHub') {
            steps {
                script {
                    echo 'Logging in to DockerHub...'
                    withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKERHUB_CREDENTIALS_USR', passwordVariable: 'DOCKERHUB_CREDENTIALS_PSW')]) {
                        sh "echo ${DOCKERHUB_CREDENTIALS_PSW} | docker login -u ${DOCKERHUB_CREDENTIALS_USR} --password-stdin"
                    }
                    echo 'DockerHub login successful.'

                    echo "Pushing Docker image: ${DOCKER_IMAGE}..."
                    sh "docker push ${DOCKER_IMAGE}"
                    echo 'Docker image push completed.'
                }
            }
        }
    }
}




// // ========================
// pipeline {
//     agent any

//     environment {
//         // Define Docker Hub credentials environment variables
//         DOCKERHUB_CREDENTIALS = credentials('dockerhub')
//     }

//     stages {
//         stage('Checkout') {
//             steps{
//                 script {
//                     checkout([
//                         $class: 'GitSCM',
//                         branches: [[name: 'main']],
//                         userRemoteConfigs: [[credentialsId: 'github_token', url: 'https://github.com/SREArchitect/static-site.git']]
//                     ])
//                 }
//             }
//         }
//         stage('Build Docker Image') {
//             steps {
//                 script {
//                     sh 'docker build --no-cache -t madhurakurhadkar/caddy-static-site:latest -f Dockerfile .'
//                 }
//             }
            
//         }
//         stage('Push Docker Image to DockerHub') {
//             steps {
//                 script {
//                     // withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USER_DOCKER', passwordVariable: 'DOCKER_ACCESS_TOKEN')]) {
//                     //     sh "echo ${USER_DOCKER} | docker login -u ${DOCKER_ACCESS_TOKEN} --password-stdin"
//                     // }
//                     sh "echo ${env.DOCKERHUB_CREDENTIALS_PSW} | docker login madhurakurhadkar/caddy-static-site -u ${env.DOCKERHUB_CREDENTIALS_USR} --password-stdin"
//                     sh 'docker push madhurakurhadkar/caddy-static-site:latest'
//                 }
//             }
//         }
//     }
    
// }

// // // ====================

// Key Features:
// Manual Git Checkout:

// Includes a Checkout stage where the code is checked out from a Git repository using checkout with the GitSCM class.
// Manual Docker Commands:

// Uses sh steps to run shell commands for building and pushing the Docker image. This provides more control over the Docker commands.
// docker build --no-cache -t image-name -f Dockerfile . is explicitly run to build the image.
// docker login and docker push commands are manually executed to push the image.
// Credentials Handling:

// Uses the withCredentials block to provide Docker Hub credentials. The credentials are stored in environment variables (DOCKERHUB_USERNAME and DOCKERHUB_PASSWORD) which are then used in the docker login command.

// Summary
// More streamlined and integrated approach using the Docker Pipeline plugin. Ideal for simpler setups where you prefer using high-level abstractions.

// When to Use?
// You need to perform additional steps, such as checking out code from a repository.
// You require explicit control over the Docker build and push processes.
// You prefer or need to run Docker commands manually.