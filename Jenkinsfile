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
                sh 'npm install'
                sh 'npm test'
            }
        }
        stage('Archive') {
            steps {
                withNPM(npmrcConfig: 'npmrc-nexus') {
                    sh 'npm publish'
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying.....'
            }
        }
    }
}
