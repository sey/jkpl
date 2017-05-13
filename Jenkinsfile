#!groovy

pipeline {
    agent any

    stages {
        stage('Prepare') {
            steps {
                sh 'node --version'
                sh 'npm --version'
            }
        }
        stage('Build') {
            steps {
                echo 'Building...'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing...'
                npm install
                npm test
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying.....'
            }
        }
    }
}
