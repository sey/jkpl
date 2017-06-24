#!groovy

pipeline {
    agent any

    environment {
        NPM_REPO_URL = credentials('npm-repo-url')
        NPM_REPO = credentials('npm-repo')
    }

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
                echo 'Archiving...'
                withNPM(npmrcConfig: 'npmrc-nexus') {
                    sh 'npm publish'
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                sh deploy.sh
            }
        }
    }
}
